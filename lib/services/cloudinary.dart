// import 'dart:convert';
// import 'dart:io';
// // ignore: depend_on_referenced_packages
// import 'package:http/http.dart' as http;

// Future<void> uploadImage(File? imageFile) async {
//   final url = Uri.parse('https://api.cloudinary.com/v1_1/dpsqzjmqw/upload');
//   final request = http.MultipartRequest('POST', url)
//     ..fields['upload_preset'] = 'dpsqzjmqw'
//     ..files.add(await http.MultipartFile.fromPath(
//       'file',
//       imageFile!.path,
//     ));

//   final responce = await request.send();
//   if (responce.statusCode == 200) {
//     final responseData = await responce.stream.toBytes();
//     final responseString = String.fromCharCodes(responseData);
//     final jsonMap = jsonDecode(responseString);
//   } 
// }
