import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controller/register_controller.dart';
import '../helper/imagepicker_controller.dart';
import '../helper/register_helper.dart';

class AddRegisterScreen extends StatelessWidget {
  AddRegisterScreen({super.key});

  final ImagepickerController controller = Get.put(ImagepickerController());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController meetpersonController = TextEditingController();
  final TextEditingController purposeController = TextEditingController();

  final DbHelper dbRef = DbHelper.getInstance;

  addData(String name, String address, String mobile, String meetperson) async {
    if (name.isEmpty || address.isEmpty || mobile.isEmpty || meetperson.isEmpty) {
      Get.snackbar("Error", "Please fill all required fields!",
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    } else {
      FirebaseFirestore.instance.collection("Users").doc(name).set({
        "Name": name,
        "Address": address,
        "Mobile": mobile,
        "MeetPerson": meetperson,
        "ImagePath": controller.imagepath.value, // Save Image Path to Firestore
      }).then((value) => Get.snackbar("Success", "Data Inserted",
          backgroundColor: Colors.green, colorText: Colors.white));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Add Visitor',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                // Profile Image using GetX (Obx)
                Obx(() {
                  return Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        backgroundImage: controller.imagepath.value.isNotEmpty
                            ? FileImage(File(controller.imagepath.value))
                            : null,
                        child: controller.imagepath.value.isEmpty
                            ? const Icon(Icons.person, size: 60, color: Colors.black45)
                            : null,
                      ),
                      FloatingActionButton(
                        mini: true,
                        backgroundColor: Colors.orange,
                        onPressed: () async {
                          await controller.getImage();
                        },
                        child: const Icon(Icons.camera_alt, color: Colors.white),
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 16),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        _buildTextField(
                          controller: nameController,
                          label: "Visitor Name *",
                          icon: Icons.person,
                        ),
                        const SizedBox(height: 10),
                        _buildTextField(
                          controller: mobileController,
                          label: "Mobile No *",
                          icon: Icons.phone,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                        ),
                        const SizedBox(height: 10),
                        _buildTextField(
                          controller: addressController,
                          label: "Visitor Address *",
                          icon: Icons.home,
                        ),
                        const SizedBox(height: 10),
                        _buildTextField(
                          controller: meetpersonController,
                          label: "Visitor Meet Name *",
                          icon: Icons.person_search,
                        ),
                        const SizedBox(height: 10),
                        _buildTextField(
                          controller: purposeController,
                          label: "Purpose *",
                          icon: Icons.note_alt,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildButton(
                      text: "Save",
                      color: Colors.green,
                      icon: Icons.save,
                      onTap: () async {
                        final name = nameController.text;
                        final address = addressController.text;
                        final mobile = mobileController.text;
                        final meetperson = meetpersonController.text;
                        final purpose = purposeController.text;
                        final dateTime = DateTime.now().toString();

                        if (name.isNotEmpty &&
                            address.isNotEmpty &&
                            mobile.isNotEmpty &&
                            meetperson.isNotEmpty &&
                            purpose.isNotEmpty) {
                          bool check = await dbRef.addRegister(
                            Mname: name,
                            Maddress: address,
                            Mmobile_no: mobile,
                            Mmeet_name: meetperson,
                            Mdatetime: dateTime,
                            Mpurpose: purpose,
                            MimagePath: '',
                          );
                          if (check) {
                            Get.find<RegisterController>().getRegister();
                            Navigator.pop(context);
                          }
                        } else {
                          Get.snackbar("Error", "All fields are mandatory!",
                              backgroundColor: Colors.red, colorText: Colors.white);
                        }
                        addData(name, address, mobile, meetperson,);
                      },
                    ),
                    _buildButton(
                      text: "Cancel",
                      color: Colors.red,
                      icon: Icons.cancel,
                      onTap: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.orange),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  Widget _buildButton({required String text, required Color color, required IconData icon, required VoidCallback onTap}) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      onPressed: onTap,
      icon: Icon(icon, color: Colors.white),
      label: Text(text, style: const TextStyle(color: Colors.white, fontSize: 18)),
    );
  }
}