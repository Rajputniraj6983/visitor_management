import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled3/controller/register_controller.dart';
import 'package:untitled3/helper/register_helper.dart';

class DateWiseRegisterScreen extends StatelessWidget {
  DateWiseRegisterScreen({super.key});

  final RegisterController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    Map<String, List<Map<String, dynamic>>> groupedData = {};

    for (var register in _controller.allRegister) {
      String date = register[DbHelper.COLUMN_REGISTER_DATETIME].toString().split(" ")[0];
      if (!groupedData.containsKey(date)) {
        groupedData[date] = [];
      }
      groupedData[date]!.add(register);
    }

    List<String> sortedDates = groupedData.keys.toList()
      ..sort((a, b) => b.compareTo(a));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent.shade100,
        title: const Text(
          'Date-wise Register',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: sortedDates.length,
        itemBuilder: (context, index) {
          String date = sortedDates[index];
          return Card(
            margin: EdgeInsets.all(10),
            elevation: 4,
            child: ExpansionTile(
              title: Text(
                "$date - ${groupedData[date]!.length} Entries",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              children: groupedData[date]!.map((entry) {
                return ListTile(
                  title: Text(entry[DbHelper.COLUMN_REGISTER_NAME]),
                  subtitle: Text("Mobile: ${entry[DbHelper.COLUMN_REGISTER_MOBILE]}"),
                  trailing: Icon(Icons.person, color: Colors.deepOrange),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
