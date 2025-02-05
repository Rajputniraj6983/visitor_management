import 'dart:developer';
import 'package:get/get.dart';
import '../helper/register_helper.dart';

class RegisterController extends GetxController {
  final RxList<Map<String, dynamic>> allRegister = <Map<String, dynamic>>[].obs;
  final DbHelper dbRef = DbHelper.getInstance;

  void getRegister() async {
    allRegister.value = await dbRef.getAllRegister();
    log("Data fetched: ${allRegister.value}");
  }

  @override
  void onInit() {
    super.onInit();
    getRegister();
  }
}
