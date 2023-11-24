import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:campus_app/core/themes.dart';
import 'package:campus_app/main.dart';
import 'package:campus_app/utils/widgets/campus_icon_button.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// This page shows an [InAppWebView] in order to display external
/// websites from the helpful ressources that are not yet natively implemented
class InAppWebViewPage extends StatefulWidget {
  /// The url that should be opened
  final String url;

  const InAppWebViewPage({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<InAppWebViewPage> createState() => _InAppWebViewPageState();
}

class _InAppWebViewPageState extends State<InAppWebViewPage> {
  InAppWebViewController? webViewController;
  late PullToRefreshController pullToRefreshController;

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
      verticalScrollBarEnabled: false,
      horizontalScrollBarEnabled: false,
    ),
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
    ),
  );

  @override
  void initState() {
    super.initState();

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(color: Colors.black),
      onRefresh: () async {
        if (Platform.isAndroid) {
          await webViewController?.reload();
        } else if (Platform.isIOS) {
          await webViewController?.loadUrl(urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await webViewController!.canGoBack()) {
          await webViewController?.goBack();
        } else {
          if (homeKey.currentState != null) {
            homeKey.currentState!.setSwipeDisabled();
          }
          return true;
        }
        return false;
      },
      child: VisibilityDetector(
        onVisibilityChanged: (info) {
          final bool isVisible = info.visibleFraction > 0;

          if (isVisible) {
            if (homeKey.currentState != null) {
              homeKey.currentState!.setSwipeDisabled(disableSwipe: true);
            }
          }
        },
        key: const Key('visibility-key'),
        child: Scaffold(
          backgroundColor: Provider.of<ThemesNotifier>(context).currentThemeData.colorScheme.background,
          body: SafeArea(
            child: Stack(
              children: [
                InAppWebView(
                  gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{}
                    ..add(const Factory<VerticalDragGestureRecognizer>(VerticalDragGestureRecognizer.new)),
                  pullToRefreshController: pullToRefreshController,
                  initialOptions: options,
                  initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
                  onWebViewCreated: (controller) {
                    webViewController = controller;
                  },
                ),
                // Back button
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: CampusIconButton(
                    iconPath: 'assets/img/icons/arrow-left.svg',
                    onTap: () {
                      if (homeKey.currentState != null) {
                        homeKey.currentState!.setSwipeDisabled();
                      }
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}