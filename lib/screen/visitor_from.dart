import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../controller/register_controller.dart';
import 'my_register_screen.dart';

class VisitorForm extends StatefulWidget {
  @override
  _VisitorFormState createState() => _VisitorFormState();
}

class _VisitorFormState extends State<VisitorForm> {
  List<String> persons = ['Mihir', 'Naren', 'Suraj', 'Shiva', 'Others'];
   TextEditingController _mobileController = TextEditingController();
   TextEditingController _addressController = TextEditingController();
   TextEditingController _visitorNameController = TextEditingController();
   TextEditingController _nameController = TextEditingController();
   TextEditingController _purposeController = TextEditingController();
   TextEditingController _dateTimeController = TextEditingController();
  File? _image;
  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitForm() async {
    if (_visitorNameController.text.isEmpty ||
        _mobileController.text.isEmpty ||
        _addressController.text.isEmpty ||
        _purposeController.text.isEmpty ||
        _nameController.text.isEmpty ||
        _image == null) {
      Get.snackbar('Error', 'All fields and image are required!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://103.217.85.133/api_visitor/post.php'),
    );

    request.fields['visitor_name'] = _nameController.text;
    request.fields['name'] = _visitorNameController.text;
    request.fields['mobile'] = _mobileController.text;
    request.fields['address'] = _addressController.text;
    request.fields['purpose'] = _purposeController.text;
    request.fields['date_time'] = DateTime.now().toString();

    var pic = await http.MultipartFile.fromPath('image', _image!.path);
    request.files.add(pic);

    var response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await http.Response.fromStream(response);
      final data = jsonDecode(responseData.body);
      if (data['status'] == 'Record insertion successful!') {
        Get.snackbar('Success', 'Visitor added successfully!',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        Get.to(() => MyRegisterScreen());
      }
    }
  }

  bool isCondition = true;

  @override
  Widget build(BuildContext context) {
    RegisterController controller = Get.find();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Add Visitor',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 23)),
        centerTitle: true,
        elevation: 5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 15),

              TextField(
                controller: _visitorNameController,
                keyboardType: TextInputType.text,
                onChanged: (value) => controller.filterRegisterNames(value),
                decoration: InputDecoration(
                  labelText: 'Visitor Name',
                  prefixIcon: Icon(Icons.person, color: Colors.red),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),

              Visibility(
                visible: isCondition,
                child: SizedBox(
                  height: 100,
                  width: 350,
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (controller.filteredVisitorsName.isEmpty) {
                      return Center(child: Text('No visitors found!'));
                    }
                    return ListView.builder(
                      itemCount: controller.filteredVisitorsName.length,
                      itemBuilder: (context, index) {
                        final visitor = controller.filteredVisitorsName[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            title: Text(visitor.name, style: TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text(visitor.mobile),
                            trailing: Icon(Icons.arrow_forward_ios, size: 18),
                            onTap: () {
                             setState(() {
                               _visitorNameController = TextEditingController(text: visitor.name);
                               _mobileController = TextEditingController(text: visitor.mobile);
                               _addressController = TextEditingController(text: visitor.address);
                               controller.filteredVisitorsName.clear();
                               setState(() {
                                 isCondition = true;
                               });
                             });
                            },
                          ),
                        );
                      },
                    );
                  }),
                ),
              ),

              SizedBox(height: 15),
              _buildTextField(_mobileController, 'Mobile', Icons.phone, isNumber: true,),
              SizedBox(height: 15),
              _buildTextField(_addressController, 'Address', Icons.home),
              SizedBox(height: 15),
              TextField(
                controller: _nameController,
                readOnly: true,
                onTap: _showPersonList,
                decoration: InputDecoration(
                  labelText: 'Whom to Meet',
                    prefixIcon: Icon(Icons.person, color: Colors.red),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    filled: true,
                    fillColor: Colors.white,
                  labelStyle: TextStyle(color: Colors.black),
                  suffixIcon: Icon(Icons.arrow_drop_down),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(height: 15),

              _buildTextField(_purposeController, 'Purpose', Icons.assignment),
              SizedBox(height: 15),
              //SizedBox(height: 15),
              _buildImagePicker(),
              SizedBox(height: 15),
              _buildButtons(),
            ],
          ),
        ),
      ),
    );
  }

  /// Custom TextField Widget
  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool isNumber = false}) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.phone : TextInputType.text,
      inputFormatters: isNumber?[
      FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
        ]:[],onSubmitted: (value) {
      if (value.length != 10) {
        Get.snackbar(
          "Invalid Number",
          "Please enter a valid 10-digit mobile number!",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.red),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        hintText: label == 'DateTime' ? 'ex..${DateTime
            .now()
            .day}/${DateTime
            .now()
            .month}/${DateTime
            .now()
            .year}-${TimeOfDay
            .now()
            .hour}:${TimeOfDay
            .now()
            .minute} ' : '',
        fillColor: Colors.white,
      ),
    );
  }

  /// Image Picker Widget
  Widget _buildImagePicker() {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: _pickImage,
          icon: Icon(Icons.camera_alt, color: Colors.white),
          label: Text('Capture Image', style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        ),
        SizedBox(height: 16),
        _image == null
            ? Icon(Icons.camera_alt, size: 50, color: Colors.grey)
            : ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.file(_image!, height: 150, width: 150, fit: BoxFit.cover),
        ),
      ],
    );
  }

  /// Buttons (Submit & Cancel)
  Widget _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: _submitForm,
          child: Text('Submit', style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          ),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel', style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          ),
        ),
      ],
    );
  }
  void _showPersonList() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.add, color: Colors.green),
              title: Text("Add New Meet person "),
              onTap: () {
                Navigator.pop(context);
                _showAddPersonDialog();
              },
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: persons.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(persons[index]),
                    onTap: () {
                      setState(() {
                        _nameController.text = persons[index];
                      });
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void _showAddPersonDialog() {
    TextEditingController _newPersonController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(backgroundColor: Colors.white,
          title: Text("Add New Person",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
          content: TextField(cursorColor: Colors.black,
            controller: _newPersonController,
            decoration: InputDecoration(hintText: "Enter person name",
              filled: true,
              fillColor: Colors.white,
              labelStyle: TextStyle(color: Colors.black),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(15),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel",style: TextStyle(color: Colors.black,fontSize: 18),),
            ),
            TextButton(
              onPressed: () {
                String newPerson = _newPersonController.text.trim();
                if (newPerson.isNotEmpty) {
                  setState(() {
                    persons.add(newPerson);
                    _visitorNameController.text = newPerson;
                  });
                  Navigator.pop(context);
                }
              },
              child: Text("Add",style: TextStyle(color: Colors.black,fontSize: 18),),
            ),
          ],
        );
      },
    );
  }
}
