import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart'; // Required for MediaType
import 'package:society_app/constant/api_constants/routes/app_url.dart';
import 'package:society_app/models/guard/message/post_guard_note.dart';
import 'package:society_app/view_model/user_session.dart';

class GuardNoteRepository {
  Future<postGuardNote> postGuardNoteRepo(
      Data guardNote, File imageFile) async {
    try {
      final uri = Uri.parse(AppUrl.postGuardNote);

      // Create multipart request
      final request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          "authorization": "Bearer ${GlobalData().token}",
          "Content-Type": "multipart/form-data",
        })
        ..fields
            .addAll(guardNote.toJson()) // This now returns Map<String, String>
        ..files.add(await http.MultipartFile.fromPath(
          'image',
          imageFile.path,
          contentType: MediaType('image', 'jpeg'),
        ));

      final response = await request.send();
      if (response.statusCode == 201) {
        final responseBody = await response.stream.bytesToString();
        final decodedResponse = json.decode(responseBody);

        print('ffff');
        print(responseBody);
        print('fqfqff');

        return postGuardNote.fromJson(decodedResponse);
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error posting guard note: $e');
    }
  }
}
