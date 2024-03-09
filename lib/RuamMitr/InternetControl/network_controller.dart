/*import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    ThemeData theme = Get.theme;
    if (connectivityResult == ConnectivityResult.none) {
      Get.rawSnackbar(
        messageText: Text(
          'NO INTERNET CONNECTED',
          style: TextStyle(color: theme.colorScheme.onPrimary, fontSize: 18),
        ),
        isDismissible: false,
        duration: const Duration(days: 1),
        backgroundColor: theme.colorScheme.primary,
        icon: Icon(
          Icons.wifi_off,
          color: theme.colorScheme.onPrimary,
          size: 35,
        ),
        margin: EdgeInsets.zero,
        snackStyle: SnackStyle.GROUNDED,
      );
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }
}*/
