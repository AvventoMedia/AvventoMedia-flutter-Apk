
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:yaml/yaml.dart';

import '../componets/utils.dart';
import '../widgets/common/loading_widget.dart';

class VersionChecker extends GetxController {
  final String githubRepoUrl;

  VersionChecker(this.githubRepoUrl);

  Future<void> checkForUpdates(BuildContext context) async {
    final String currentVersion = await _getCurrentVersion();

    try {
      final response = await http.get(Uri.parse(githubRepoUrl));

      if (response.statusCode == 200) {
        final String responseBody = response.body;
        print('Response Body: $responseBody');

        final Map<String, dynamic> data = json.decode(response.body);
        final String latestVersion = data['tag_name'];
        final String changelog = data['body'];

        if (latestVersion.isNotEmpty && latestVersion.compareTo(currentVersion) > 0) {
          if (!context.mounted) return;
          // New version available, show update prompt
          showUpdateDialog(context, changelog);
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> _getCurrentVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    return version;
  }

  // Display update prompt
  void showUpdateDialog(BuildContext context, String changelog) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.8,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 24.0,
                    color:  Theme.of(context).colorScheme.onPrimary,
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Update Available',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'Changelog:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: MarkdownBody(
                      data: changelog,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        style: ButtonStyle(
                         // backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.onPrimary),
                          foregroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.onPrimary),
                        ),
                          onPressed: () {
                            // Cancel update
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'),
                        ),
                      const SizedBox(width: 10.0),
                      OutlinedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.onSecondary),
                        ),
                        onPressed: () {
                          // Start update process
                          // Update progress indicator
                          // Close dialog on completion
                          _startUpdateProcess(context);
                        },
                        child: const Text('Update')
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Function to simulate the update process
  void _startUpdateProcess(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Dialog(
          child: SizedBox(
            height: 100.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoadingWidget(),
                SizedBox(height: 16.0),
                Text('Updating...'),
              ],
            ),
          ),
        );
      },
    );

    // Simulate update process delay
    Future.delayed(const Duration(seconds: 3), () {
      // Close update dialog
      Navigator.of(context, rootNavigator: true).pop();
      // Show completion dialog
      _showUpdateCompletionDialog(context);
    });
  }


// Function to show update completion dialog
  void _showUpdateCompletionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Completed'),
          content: const Text('The app has been successfully updated.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

}