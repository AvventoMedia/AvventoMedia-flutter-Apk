import 'package:avvento_media/pages/podcast_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../pages/listen_page.dart';
import '../pages/live_tv_list_page.dart';
import '../pages/main_page.dart';
import '../pages/online_radio_page.dart';
import '../pages/podcast_episode_list_page.dart';
import '../pages/podcast_list_page.dart';
import '../pages/prayer_request_page.dart';
import '../pages/profile_page.dart';
import '../pages/watch_page.dart';
import '../pages/youtube_playlist_item_page.dart';
import '../pages/youtube_playlist_page.dart';
import '../pages/youtube_watch_page.dart';

class Routes {
  static String home = "/";
  static String listen = "/listen";
  static String profile = "/profile";
  static String podcast = "/podcast";
  static String podcastList = "/podcastList";
  static String podcastEpisodeList = "/podcastEpisode/List";
  static String onlineRadio = "/onlineRadio";
  static String liveTv = "/liveTv";
  static String liveTvList = "/liveTv/list";
  static String prayerRequest = "/prayerRequest";
  static String youtubePlaylist = "/youtubePlaylist";
  static String youtubePlaylistItem = "/youtubePlaylist/Item";
  static String watchYoutube = "/watch/YoutubeVideo";

  static  String getHomeRoute() => home;
  static  String getListenRoute() => listen;
  static  String getProfileRoute() => profile;
  static  String getPodcastRoute() => podcast;
  static  String getPodcastListRoute() => podcastList;
  static  String getPodcastEpisodeListRoute() => podcastEpisodeList;
  static  String getOnlineRadioRoute() => onlineRadio;
  static  String getLiveTvRoute() => liveTv;
  static  String getLiveTvListRoute() => liveTvList;
  static  String getPrayerRequestRoute() => prayerRequest;
  static  String getYoutubePlaylistRoute() => youtubePlaylist;
  static  String getYoutubePlaylistItemRoute() => youtubePlaylistItem;
  static  String getWatchYoutubeRoute() => watchYoutube;

  static List<GetPage> routes = [
    GetPage(name: home, page: () => const MainPage()),
    GetPage(name: listen, page: () => const ListenPage()),
    GetPage(name: profile, page: () => const ProfilePage()),
    GetPage(name: podcast, page: () => const PodcastPage()),
    GetPage(name: podcastList, page: () => const PodcastListPage()),
    GetPage(name: podcastEpisodeList, page: () => const PodcastEpisodeListPage()),
    GetPage(name: onlineRadio, page: () => const OnlineRadioPage()),
    GetPage(name: liveTv, page: () => const WatchPage()),
    GetPage(name: liveTvList, page: () => const LiveTvListPage()),
    GetPage(name: prayerRequest, page: () => const PrayerRequestPage()),
    GetPage(name: youtubePlaylist, page: () => const YoutubePlaylistPage()),
    GetPage(name: youtubePlaylistItem, page: () => const YoutubePlaylistItemPage()),
    GetPage(name: watchYoutube, page: () => const YoutubeWatchPage()),
  ];
}