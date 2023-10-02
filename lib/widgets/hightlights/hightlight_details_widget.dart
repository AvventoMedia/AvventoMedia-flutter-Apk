import 'package:avvento_radio/models/exploremodels/programs.dart';
import 'package:avvento_radio/widgets/text/text_overlay_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HightlightsDetailsWidget extends StatefulWidget {
  final Programs explore;
  const HightlightsDetailsWidget({super.key, required this.explore});

  @override
  State<HightlightsDetailsWidget> createState() => _HightlightsDetailsWidget();
}

class _HightlightsDetailsWidget extends State<HightlightsDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double widgetWidth = 0.85 * screenWidth; // 80% of the screen width
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0), // Rounded corners with radius 15.0
      child: Container(
        width: widgetWidth,
        height: widgetWidth * 9.0 / 16.0, // 16:9 aspect ratio based on the width
        margin: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            // Add your GIF or photo here (replace with your actual image)
            CachedNetworkImage(
              imageUrl: widget.explore.urlToImage,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              placeholder: (context, url) => Center(
                  child: SizedBox(
                      width: 40.0, // Adjust the width to control the size
                      height: 40.0, // Adjust the height to control the size
                      child: CircularProgressIndicator(
                        strokeWidth: 3.0, // Adjust the stroke width as needed
                        valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.onPrimary), // Change the color here
                      ),
                  ),), // Placeholder widget
              errorWidget: (context, _, error) => Icon(Icons.error,color: Theme.of(context).colorScheme.error,), // Error widget
            ),
            TextOverlay(label: widget.explore.source.name, color: Theme.of(context).colorScheme.onSecondaryContainer),
            const SizedBox(height: 4.0,),
            TextOverlay(label: widget.explore.title, fontWeight: FontWeight.bold ,color: Theme.of(context).colorScheme.onPrimaryContainer, fontSize: 15.0,),
            const SizedBox(height: 4.0,),

          ],
        ),
      ),
    );
  }
}