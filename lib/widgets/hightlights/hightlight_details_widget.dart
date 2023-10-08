import 'package:avvento_radio/models/exploremodels/programs.dart';
import 'package:avvento_radio/models/highlights/highlightModel.dart';
import 'package:avvento_radio/widgets/text/text_overlay_widget.dart';
import 'package:flutter/material.dart';

import '../images/resizable_image_widget.dart';

class HightlightsDetailsWidget extends StatefulWidget {
  final HighlightModel highlightModel;
  const HightlightsDetailsWidget({super.key, required this.highlightModel,});

  @override
  State<HightlightsDetailsWidget> createState() => _HightlightsDetailsWidget();
}

class _HightlightsDetailsWidget extends State<HightlightsDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ResizableImageWithOverlay(imageUrl: widget.highlightModel.imageUrl),
            const SizedBox(height: 15.0,),
            TextOverlay(label: widget.highlightModel.title, color: Colors.orangeAccent),
            const SizedBox(height: 8.0,),
            TextOverlay(label: widget.highlightModel.name, fontWeight: FontWeight.bold ,color: Theme.of(context).colorScheme.onPrimary, fontSize: 15.0,),
            const SizedBox(height: 8.0,),
          ],
      ),
    );
  }
}
