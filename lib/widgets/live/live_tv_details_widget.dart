import 'package:avvento_radio/componets/app_constants.dart';
import 'package:avvento_radio/models/exploremodels/programs.dart';
import 'package:avvento_radio/widgets/text/text_overlay_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../images/resizable_image_widget.dart';
import '../images/resizable_image_widget_2.dart';

class LiveTvDetailsWidget extends StatefulWidget {
  final Programs explore;
  const LiveTvDetailsWidget({super.key, required this.explore});

  @override
  State<LiveTvDetailsWidget> createState() => _LiveTvDetailsWidget();
}

class _LiveTvDetailsWidget extends State<LiveTvDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: ResizableImageContainerWithOverlay(
              imageUrl: widget.explore.urlToImage,
              text: AppConstants.liveNow, icon: CupertinoIcons.dot_radiowaves_left_right,)),
            const SizedBox(height: 15.0,),
            TextOverlay(label: widget.explore.title, fontWeight: FontWeight.bold ,color: Theme.of(context).colorScheme.onPrimary, fontSize: 15.0,),
            const SizedBox(height: 8.0,),
          ],
      ),
    );
  }
}