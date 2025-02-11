import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static ApiService apiService = ApiService._();

  ApiService._();

  String apiUrl =
      "http://103.217.85.133/api_visitor/";


  // Future<bool> postCalling(Map<String, dynamic> data) async {
  //   try {
  //     var request = http.MultipartRequest(
  //       'POST',
  //       Uri.parse('https://able-zebra-apparent.ngrok-free.app/api_visitor/post.php'),
  //     );
  //
  //     request.fields['name'] = data['name'];
  //     request.fields['mobile'] = data['mobile'];
  //     request.fields['address'] = data['address'];
  //     request.fields['visitor_name'] = data['visitor_name'];
  //     request.fields['date_time'] = data['date_time'];
  //     request.fields['purpose'] = data['purpose'];
  //
  //     // Attach image file
  //     File imageFile = data['image'];
  //     if (imageFile.existsSync()) {
  //       request.files.add(
  //         await http.MultipartFile.fromPath(
  //           'image', // Field name for the file in the API
  //           imageFile.path,
  //           filename: basename(imageFile.path), // Get filename from path
  //         ),
  //       );
  //     }
  //
  //     // Send request
  //     var response = await request.send();
  //
  //     // Read response
  //     final responseBody = await response.stream.bytesToString();
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       print("Success: $responseBody");
  //       return true;
  //     } else {
  //       print("Failed: ${response.statusCode} - $responseBody");
  //       return false;
  //
  //     }
  //   } catch (e) {
  //     print("Error: $e");
  //     rethrow;
  //   }
  // }

// calling
  Future<String?> getCalling() async {
    try {
      // Sending POST request
      final response = await http.get(
        Uri.parse("${apiUrl}get_visitor.php"),
      );

      // Check response
      if (response.statusCode == 200) {
        print("Success: ${response.body}");
        return response.body;
      } else {
        print("Failed: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }
}
class RegisterService {
  static const String apiUrl = "http://103.217.85.133/api_visitor/get_visitor.php";

  // Method to fetch data as a stream
  static Stream<List<Map<String, dynamic>>> fetchRegisters() async* {
    while (true) {
      try {
        final response = await http.get(Uri.parse(apiUrl));
        if (response.statusCode == 200) {
          List<Map<String, dynamic>> registers = List<Map<String, dynamic>>.from(jsonDecode(response.body));
          yield registers; // Emit the list of registers
        } else {
          throw Exception("Failed to load registers");
        }
      } catch (e) {

        yield [];
      }
      await Future.delayed(Duration(seconds: 5));
    }
  }
}