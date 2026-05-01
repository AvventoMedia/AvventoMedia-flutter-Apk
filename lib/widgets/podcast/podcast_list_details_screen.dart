import 'package:avvento_media/models/radiomodel/radio_podcast_model.dart';
import 'package:avvento_media/widgets/common/loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PodcastListDetailsWidget extends StatefulWidget {
  final RadioPodcast radioPodcast;
  const PodcastListDetailsWidget({super.key, required this.radioPodcast});

  @override
  PodcastPlayerWidgetState createState() => PodcastPlayerWidgetState();
}

class PodcastPlayerWidgetState extends State<PodcastListDetailsWidget> {
  static String? azuracastAPIKey = dotenv.env["AZURACAST_APIKEY"];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.secondary.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorScheme.tertiaryContainer.withValues(alpha: 0.3),
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Podcast artwork
          Expanded(
            flex: 5,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.radioPodcast.art,
                    httpHeaders: {
                      'Authorization': 'Bearer $azuracastAPIKey',
                    },
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: colorScheme.secondary,
                      child: const Center(child: LoadingWidget()),
                    ),
                    errorWidget: (context, _, error) => Container(
                      color: colorScheme.secondary,
                      child: Icon(
                        Icons.headphones_rounded,
                        color: colorScheme.onSecondary,
                        size: 40,
                      ),
                    ),
                  ),
                  // Subtle gradient overlay at the bottom of the image
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 40,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            colorScheme.secondary.withValues(alpha: 0.6),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                ],
              ),
            ),
          ),
          // Podcast info section
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.radioPodcast.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.podcasts_rounded,
                        size: 14,
                        color: Colors.amber.shade600,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${widget.radioPodcast.episodes} Episodes',
                        style: TextStyle(
                          fontSize: 11,
                          color: colorScheme.onSecondary,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
