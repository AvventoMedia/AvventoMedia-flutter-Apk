import 'package:avvento_media/models/youtubemodels/youtube_playlist_item_model.dart';

class YoutubePlaylistModel {
  final String id;
  final String title;
  final String description;
  final String thumbnailUrl;
  final int itemCount;
  final DateTime publishedAt;

  YoutubePlaylistModel({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.itemCount,
    required this.publishedAt,
  });

  factory YoutubePlaylistModel.fromJson(Map<String, dynamic> json) {
    final snippet = json['snippet'];
    final thumbnails = snippet['thumbnails'];
    // Check for the thumbnail qualities in order of preference
    final defaultThumbnail = thumbnails['maxres'] ??
        thumbnails['standard'] ??
        thumbnails['high'];

    return YoutubePlaylistModel(
      id: json['id'],
      title: snippet['title'],
      description: snippet['description'],
      thumbnailUrl: defaultThumbnail['url'],
      itemCount: json['contentDetails']['itemCount'],
      publishedAt: DateTime.parse(snippet['publishedAt']), // Parse the date
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'snippet': {
        'title': title,
        'description': description,
        'publishedAt': publishedAt.toIso8601String(),
        'thumbnails': {
          'maxres': {'url': thumbnailUrl},
        },
      },
      'contentDetails': {
        'itemCount': itemCount,
      },
    };
  }

  YoutubePlaylistModel updateItemCountBasedOnNonPrivateItems(List<YouTubePlaylistItemModel> items) {
    int validItemCount = items.where((item) {
      // Exclude private videos
      bool isNotPrivate = item.title != 'Private video';
      // Exclude unlisted videos (additional logic if possible)
      bool isNotUnlisted = item.privacyStatus != 'unlisted';

      return isNotPrivate && isNotUnlisted;
    }).length;

    return YoutubePlaylistModel(
      id: id,
      title: title,
      description: description,
      thumbnailUrl: thumbnailUrl,
      itemCount: validItemCount,
      publishedAt: publishedAt,
    );
  }

}