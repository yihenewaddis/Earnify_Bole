import 'package:get/get.dart';

class WelcomescreenController extends GetxController {
  var count = 0;
  void increment() {
    count++;
    update();
  }
}