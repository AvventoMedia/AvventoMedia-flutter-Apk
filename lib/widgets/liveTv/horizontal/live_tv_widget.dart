import 'package:avvento_media/components/app_constants.dart';
import 'package:avvento_media/components/utils.dart';
import 'package:avvento_media/controller/live_tv_controller.dart';
import 'package:avvento_media/models/livetvmodel/livetv_model.dart';
import 'package:avvento_media/widgets/common/loading_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../apis/firestore_service_api.dart';
import '../../../routes/routes.dart';
import '../../text/label_place_holder.dart';
import 'live_tv_details_widget.dart';

class LiveTvWidget extends StatefulWidget {
  const LiveTvWidget({super.key});

  @override
  State<LiveTvWidget> createState() => _LiveTvWidget();
}

class _LiveTvWidget extends State<LiveTvWidget> {
  final _liveTvAPI = Get.put(FirestoreServiceAPI());
  final liveTvController = Get.put(LiveTvController());

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: double.infinity,
      height: Utils.calculateAspectHeight(context, 1.25),
      child: Column(
        children: [
          LabelPlaceHolder(title: AppConstants.liveTv,titleFontSize: 18, moreIcon: true ,onMoreTap: () => Get.toNamed(Routes.getLiveTvListRoute())),
          Expanded(child: buildListView(context),)
        ],
      ),
    );
  }

  Widget buildListView(BuildContext context) {
    return StreamBuilder(
        stream: _liveTvAPI.fetchLiveTv(),
        builder: (_, snapshot)  {
          if (snapshot.hasData) {
            List liveTvList = snapshot.data!.docs;

            if (liveTvList.isNotEmpty) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: liveTvList.length,
                itemBuilder: (BuildContext context, int index) {
                  DocumentSnapshot documentSnapshot = liveTvList[index];

                  LiveTvModel liveTvModel = LiveTvModel.fromSnapShot(documentSnapshot);

                  return  buildLiveTvDetailsScreen(liveTvModel);
                },
              );
            } else {
              return const LoadingWidget();
            }

          } else {
            return const LoadingWidget();
          }
        });

  }

  Widget buildLiveTvDetailsScreen(LiveTvModel liveTvModel) {
    return GestureDetector(
      onTap: () {
        if (liveTvModel.status == AppConstants.liveNow ) {
        // Set the selected tv using the controller
        liveTvController.setSelectedTv(liveTvModel);
        // Navigate to the "livetvPage"
        Get.toNamed(Routes.getLiveTvRoute());
        } else {
          Utils.showComingSoonDialog(context);
        }
      },
        child: LiveTvDetailsWidget(liveTvModel: liveTvModel,),
    );
  }
}
