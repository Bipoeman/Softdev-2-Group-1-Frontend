import 'package:get/get.dart';
import 'package:ruam_mitt/RuamMitr/InternetControl/Network_controller.dart';

class DependencyInjection {
  static void init() {
    Get.put<NetworkController>(NetworkController(), permanent: true);
  }
}
