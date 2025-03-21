import 'package:avvento_media/models/livetvmodel/livetv_model.dart';
import 'package:avvento_media/widgets/text/text_overlay_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../components/utils.dart';
import '../../images/resizable_image_widget_2.dart';

class LiveTvDetailsWidget extends StatefulWidget {
  final LiveTvModel liveTvModel;
  const LiveTvDetailsWidget({super.key, required this.liveTvModel});

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
          Expanded(
            child: ResizableImageContainerWithOverlay(
              imageUrl: widget.liveTvModel.imageUrl,
              icon: CupertinoIcons.dot_radiowaves_left_right,
              text: widget.liveTvModel.status,
              textFontSize: 10,
            ),
          ),
          const SizedBox(height: 15.0,),
          SizedBox(
              width: Utils.calculateWidth(context, 0.76),
              child: TextOverlay(label: widget.liveTvModel.name, fontWeight: FontWeight.bold ,color: Theme.of(context).colorScheme.onPrimary, fontSize: 15.0,maxLines: 1,)),
          const SizedBox(height: 8.0,),
        ],
      ),
    );
  }
}
