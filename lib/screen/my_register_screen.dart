import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled3/controller/register_controller.dart';
import 'package:untitled3/modal/register_modal.dart';
import 'package:untitled3/screen/visitor_from.dart';
import 'package:untitled3/services/auth_services.dart';
import '../helper/api_service.dart';
import 'sign_in.dart';

class MyRegisterScreen extends StatefulWidget {
  MyRegisterScreen({super.key});

  @override
  State<MyRegisterScreen> createState() => _MyRegisterScreenState();
}

class _MyRegisterScreenState extends State<MyRegisterScreen> {
  final RegisterController _controller = Get.find();

  int indexRegister=0;
  TextEditingController txtName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
        title: const Text(
          'Visitor List',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
        elevation: 3,
        shadowColor: Colors.black26,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              onChanged: (value) {
                _controller.filterNames(value);
              },
              controller: txtName,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                hintText: "Search visitor...",
                prefixIcon: const Icon(Icons.search, color: Colors.red),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: RegisterService.fetchRegisters(), // Stream fetching registers
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator()); // Show loading indicator
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}")); // Show error message
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(
                      "No records found!",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  );
                }

                List<RegisterModal> registers = snapshot.data!.map((e) => RegisterModal.fromJson(e),).toList();
                List<RegisterModal> filteredRegisters = txtName.text.isEmpty
                    ? registers
                    : registers.where((register) =>
                    register.name
                        .toString()
                        .toLowerCase()
                        .contains(txtName.text.toLowerCase()))
                    .toList();
                String _imagePathSet = "http://103.217.85.133/api_visitor/";
                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  itemCount: filteredRegisters.length,
                  itemBuilder: (context, index) {
                    RegisterModal client = filteredRegisters[index];
                    final imagePath = client.imagePath ?? ''; // Fetch image path
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      elevation: 5,
                      shadowColor: Colors.black26,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15)),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(12),
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.red,
                            backgroundImage: imagePath.isNotEmpty
                                ? NetworkImage(_imagePathSet+imagePath)
                                : null,
                            child: imagePath.isEmpty
                                ? Icon(Icons.person, size: 40, color: Colors.black54)
                                : null,
                          ),
                          title: Text(
                            client.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Mobile: ${client.mobile}",
                                  style: TextStyle(fontSize: 14)),
                              Text("Address: ${client.address}",
                                  style: TextStyle(fontSize: 14)),
                              Text("Meet: ${client.visitorName}",
                                  style: TextStyle(fontSize: 14)),
                              Text("Purpose: ${client.purpose}",
                                  style: TextStyle(fontSize: 14)),
                              Text("Date & Time: ${client.dateTime}",
                                  style: TextStyle(fontSize: 14)),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: indexRegister,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        onTap: (value) async {
          _controller.getRegister();
          if (value == 1) {
            Get.to(() => VisitorForm(), transition: Transition.rightToLeft);
          } else if (value == 2) {
            await AuthServices.authServices.signout();
            Get.offAll(() => SignIn());
          }

          setState(() {
            indexRegister = value;
          });
        },

        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home, size: 28), label: "Home"),
          BottomNavigationBarItem(
            icon: const Icon(Icons.add, size: 28),
            label: "Add Visitor",
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.logout_outlined, size: 28),
            label: "Logout",
          ),
        ],
      ),
    );
  }
}
