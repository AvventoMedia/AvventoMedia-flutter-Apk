import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class MyAudioHandler extends BaseAudioHandler with SeekHandler {
  final AudioPlayer _player;

  MediaItem? _currentItem;

  MyAudioHandler(this._player) {
    // Broadcast media item changes
    _player.sequenceStateStream.listen((sequenceState) {
      final item = sequenceState.currentSource?.tag as MediaItem?;
      if (item != null) {
        if (_currentItem != null && _currentItem!.id == item.id) {
          // Keep our dynamically updated metadata instead of reverting
          return;
        }
        _currentItem = item;
        mediaItem.add(item);
      }
    });

    // Broadcast playback state changes
    _player.playbackEventStream.listen(_broadcastState);
  }

  Duration _positionOffset = Duration.zero;
  bool _isLive = false;

  void setLivePlayback(bool isLive) {
    _isLive = isLive;
    if (!isLive) {
      _positionOffset = Duration.zero;
    }
  }

  void syncLiveProgress(Duration elapsed) {
    if (_isLive) {
      _positionOffset = _player.position - elapsed;
      _broadcastState();
    }
  }

  void _broadcastState([PlaybackEvent? event]) {
    final playing = _player.playing;
    final queueIndex = event?.currentIndex ?? _player.currentIndex;
    final position = _isLive ? (_player.position - _positionOffset) : _player.position;

    playbackState.add(playbackState.value.copyWith(
      controls: [
        if (!_isLive) MediaControl.skipToPrevious,
        if (playing) MediaControl.pause else MediaControl.play,
        MediaControl.stop,
        if (!_isLive) MediaControl.skipToNext,
      ],
      systemActions: {
        if (!_isLive) ...const {
          MediaAction.seek,
          MediaAction.seekForward,
          MediaAction.seekBackward,
        }
      },
      androidCompactActionIndices: _isLive ? const [0, 1] : const [0, 1, 3],
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_player.processingState]!,
      playing: playing,
      updatePosition: position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
      queueIndex: queueIndex,
    ));
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> stop() => _player.stop();

  @override
  Future<void> skipToNext() => _player.seekToNext();

  @override
  Future<void> skipToPrevious() => _player.seekToPrevious();

  /// Dynamically update the current MediaItem (e.g., for live radio title changes)
  @override
  Future<void> updateMediaItem(MediaItem item) async {
    _currentItem = item;
    mediaItem.add(item);
  }
}
