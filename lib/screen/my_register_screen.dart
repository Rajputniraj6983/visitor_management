import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled3/controller/register_controller.dart';
import 'package:untitled3/helper/register_helper.dart';
import 'package:untitled3/screen/add_register_screen.dart';
import 'package:untitled3/screen/setting_page.dart';

class MyRegisterScreen extends StatelessWidget {
  MyRegisterScreen({super.key});

  final RegisterController _controller = Get.find();
  final RxString searchQuery = ''.obs;
  final RxInt _selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent.shade100,
        title: Text(
          'My Register',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
        elevation: 5,
        shadowColor: Colors.black26,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              onChanged: (value) {
                searchQuery.value = value;
              },
              cursorColor: Colors.deepOrangeAccent.shade100,
              decoration: InputDecoration(
                hintText: "Search by name...",
                prefixIcon: Icon(Icons.search, color: Colors.deepOrange),
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
            child: Obx(() {
              final filteredRegisters = searchQuery.value.isEmpty
                  ? _controller.allRegister
                  : _controller.allRegister
                  .where((register) =>
                  register[DbHelper.COLUMN_REGISTER_NAME]
                      .toString()
                      .toLowerCase()
                      .contains(searchQuery.value.toLowerCase()))
                  .toList();
              if (filteredRegisters.isEmpty) {
                return const Center(
                  child: Text(
                    "No records found!",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                );
              }
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                itemCount: filteredRegisters.length,
                itemBuilder: (context, index) {
                  final client = filteredRegisters[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 5,
                    shadowColor: Colors.black26,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(12),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.deepOrange.shade100,
                        child: Icon(Icons.person, size: 40, color: Colors.black54),
                      ),
                      title: Text(
                        client[DbHelper.COLUMN_REGISTER_NAME],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5),
                          Text("Mobile: ${client[DbHelper.COLUMN_REGISTER_MOBILE]}",
                              style: TextStyle(fontSize: 14)),
                          Text("Address: ${client[DbHelper.COLUMN_REGISTER_ADDRESS]}",
                              style: TextStyle(fontSize: 14)),
                          Text("Meeting: ${client[DbHelper.COLUMN_REGISTER_MEET_NAME]}",
                              style: TextStyle(fontSize: 14)),
                          Text("Purpose: ${client['purpose'] ?? 'No purpose'}",
                              style: TextStyle(fontSize: 14)),
                          Text("Date & Time: ${client[DbHelper.COLUMN_REGISTER_DATETIME]}",
                              style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrangeAccent.shade100,
        onPressed: () {
          Get.to(() => AddRegisterScreen(), transition: Transition.circularReveal);
        },
        child: Icon(Icons.add, size: 35, color: Colors.white),
        elevation: 8,
      ),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: _selectedIndex.value,
          onTap: (index) {
            _selectedIndex.value = index;
          },
          backgroundColor: Colors.white,
          selectedItemColor: Colors.deepOrange,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home, size: 28), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.preview, size: 28), label: "Previous"),
            BottomNavigationBarItem(
              icon: GestureDetector(
                onTap: () {
                  Get.to(() => SettingsPage(), transition: Transition.circularReveal);
                },
                child: Icon(Icons.settings, size: 28),
              ),
              label: "Settings",
            ),
          ],
        );
      }),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:untitled3/controller/register_controller.dart';
// import 'package:untitled3/helper/register_helper.dart';
// import 'package:untitled3/screen/add_register_screen.dart';
// import 'package:untitled3/screen/date_wise_screen.dart';
// import 'package:untitled3/screen/setting_page.dart';
//
//
// class MyRegisterScreen extends StatelessWidget {
//   MyRegisterScreen({super.key});
//
//   final RegisterController _controller = Get.find();
//   final RxString searchQuery = ''.obs;
//   final RxInt _selectedIndex = 0.obs;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.deepOrangeAccent.shade100,
//         title: const Text(
//           'My Register',
//           style: TextStyle(
//               color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//             child: TextField(
//               onChanged: (value) {
//                 searchQuery.value = value;
//               },
//               decoration: InputDecoration(
//                 hintText: "Search by name...",
//                 labelStyle: TextStyle(color: Colors.black),
//                 prefixIcon: Icon(Icons.search, color: Colors.deepOrange),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(15),
//                   borderSide: BorderSide(color: Colors.deepOrangeAccent.shade100),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.deepOrangeAccent.shade100),
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: Obx(() {
//               final filteredRegisters = searchQuery.value.isEmpty
//                   ? _controller.allRegister
//                   : _controller.allRegister
//                   .where((register) =>
//                   register[DbHelper.COLUMN_REGISTER_NAME]
//                       .toString()
//                       .toLowerCase()
//                       .contains(searchQuery.value.toLowerCase()))
//                   .toList();
//               if (filteredRegisters.isEmpty) {
//                 return const Center(
//                   child: Text(
//                     "No records found!",
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                 );
//               }
//               return ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: filteredRegisters.length,
//                 itemBuilder: (context, index) {
//                   final client = filteredRegisters[index];
//                   return ListTile(
//                     leading: CircleAvatar(
//                       backgroundColor: Colors.deepOrange.shade100,
//                       child: const Icon(Icons.person, color: Colors.black54),
//                     ),
//                     title: Text(client[DbHelper.COLUMN_REGISTER_NAME]),
//                     subtitle: Text(client[DbHelper.COLUMN_REGISTER_MOBILE]),
//                     trailing: Icon(Icons.arrow_forward_ios, color: Colors.deepOrange),
//                   );
//                 },
//               );
//             }),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.deepOrangeAccent.shade100,
//         onPressed: () {
//           Get.to(() => AddRegisterScreen(), transition: Transition.circularReveal);
//         },
//         child: const Icon(Icons.add, size: 35, color: Colors.white),
//       ),
//       bottomNavigationBar: Obx(() {
//         return BottomNavigationBar(
//           currentIndex: _selectedIndex.value,
//           onTap: (index) {
//             _selectedIndex.value = index;
//           },
//           backgroundColor: Colors.deepOrangeAccent.shade100,
//           selectedLabelStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
//           unselectedLabelStyle: TextStyle(fontSize: 15),
//           items: [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home, size: 25, color: _selectedIndex.value == 0 ? Colors.white : Colors.grey.shade100),
//               label: "Home",
//             ),
//             BottomNavigationBarItem(
//               icon: InkWell(onTap: () {
//                 Get.to(DateWiseRegisterScreen(), transition: Transition.circularReveal);
//               },child: InkWell(onTap: () {
//                 Get.to(DateWiseRegisterScreen(),transition: Transition.circularReveal);
//               },child: Icon(Icons.date_range, size: 25, color: _selectedIndex.value == 1 ? Colors.white : Colors.grey.shade100))),
//               label: "Date-wise",
//             ),
//             BottomNavigationBarItem(
//               icon: InkWell(onTap: () {
//                 Get.to(SettingsPage(),transition: Transition.circularReveal);
//               },child: Icon(Icons.settings, size: 25, color: _selectedIndex.value == 2 ? Colors.white : Colors.grey.shade100)),
//               label: "Settings",
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }
