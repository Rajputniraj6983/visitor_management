import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../helper/api_service.dart';
import '../modal/register_modal.dart';

class RegisterController extends GetxController {
  TextEditingController txtName = TextEditingController();
  TextEditingController textEmail = TextEditingController();
  TextEditingController textPassword = TextEditingController();
  TextEditingController txtConfirmPassword = TextEditingController();

  RxList<RegisterModal> allRegister = <RegisterModal>[].obs;
  RxList<RegisterModal> filteredVisitors = <RegisterModal>[].obs; // Renamed correctly
  RxList<RegisterModal> filteredVisitorsName = <RegisterModal>[].obs; // Renamed correctly
  RxString searchQuery = ''.obs;
  RxString imagePath = ''.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getRegister();
  }

  /// Fetch visitor data from API
  void getRegister() async {
    try {
      isLoading(true);
      String? response = await ApiService.apiService.getCalling(); // Corrected API call

      if (response != null) {
        List data = jsonDecode(response);
        allRegister.assignAll(data.map((e) => RegisterModal.fromJson(e)).toList());
        filterNames(searchQuery.value); // Apply filter after fetching data
      }
    } catch (e) {
      log('Error fetching visitors: ${e.toString()}');
      Get.snackbar("Error", "Failed to fetch visitors");
    } finally {
      isLoading(false);
    }
  }

  /// Filter visitor names based on search input
  void filterNames(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredVisitors.assignAll(allRegister);
    } else {
      filteredVisitors.assignAll(
        allRegister.where((element) => element.name.toLowerCase().contains(query.toLowerCase())).toList(),
      );
    }
    update();
  }
  void filterRegisterNames(String query) {
    if (query.isEmpty) {
      filteredVisitorsName.assignAll(allRegister);
    } else {
      filteredVisitorsName.assignAll(
        allRegister.where((element) => element.name.toLowerCase().contains(query.toLowerCase())).toList(),
      );
    }
    update();
  }

  /// Open camera to capture an image
  Future<void> getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      imagePath.value = image.path;
    }
  }
}
