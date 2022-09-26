import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:efood_multivendor_driver/controller/auth_controller.dart';
import 'package:efood_multivendor_driver/controller/splash_controller.dart';
import 'package:efood_multivendor_driver/helper/route_helper.dart';
import 'package:efood_multivendor_driver/util/dimensions.dart';
import 'package:efood_multivendor_driver/util/images.dart';
import 'package:efood_multivendor_driver/util/styles.dart';
import 'package:efood_multivendor_driver/view/base/powered_by_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  StreamSubscription<ConnectivityResult> _onConnectivityChanged;

  @override
  void initState() {
    super.initState();

    bool _firstTime = true;
    _onConnectivityChanged = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (!_firstTime) {
        bool isNotConnected = result != ConnectivityResult.wifi &&
            result != ConnectivityResult.mobile;
        isNotConnected
            ? SizedBox()
            : ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: isNotConnected ? Colors.red : Colors.green,
          duration: Duration(seconds: isNotConnected ? 6000 : 3),
          content: Text(
            isNotConnected ? 'no_connection' : 'connected',
            textAlign: TextAlign.center,
          ),
        ));
        if (!isNotConnected) {
          _route();
        }
      }
      _firstTime = false;
    });

    Get.find<SplashController>().initSharedData();
    _route();
  }

  @override
  void dispose() {
    super.dispose();

    _onConnectivityChanged.cancel();
  }

  void _route() {
    Get.find<SplashController>().getConfigData().then((isSuccess) {
      if (isSuccess) {
        Timer(Duration(seconds: 1), () async {
          if (Get.find<SplashController>().configModel.maintenanceMode) {
            Get.offNamed(RouteHelper.getUpdateRoute(false));
          } else {
            if (Get.find<AuthController>().isLoggedIn()) {
              Get.find<AuthController>().updateToken();
              await Get.find<AuthController>().getProfile();
              Get.offNamed(RouteHelper.getInitialRoute());
            } else {
              Get.offNamed(RouteHelper.getSignInRoute());
            }
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: PoweredByWidget(),
      key: _globalKey,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                SvgPicture.asset(
                  "assets/image/re.svg",
                  width: 200,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 90),
                  child: SvgPicture.asset(
                    "assets/image/Puff.svg",
                    width: 200,
                  ),
                ),
                Positioned(
                  bottom: 15,
                  child: Text(
                    'suffix_name'.tr,
                    style: robotoBlack.copyWith(fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            // Image.asset(Images.logo, width: 150),
            // SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
            // Image.asset(Images.logo_name, width: 150),
            //Text(AppConstants.APP_NAME, style: robotoMedium.copyWith(fontSize: 25), textAlign: TextAlign.center),
            // SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
            // Text('suffix_name'.tr,
            //     style: robotoMedium, textAlign: TextAlign.center),
          ]),
        ),
      ),
    );
  }
}
