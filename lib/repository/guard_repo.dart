import 'dart:convert';
import 'package:society_app/network/BaseApiService.dart';
import 'package:society_app/network/NetworkApiService.dart';
import 'package:society_app/constant/api_constants/routes/app_url.dart';

class GuardRepo {
  final BaseApiServices _apiServices = NetworkApiService();

  // Fetch building data
  Future<List<String>> getVisitorSocietyData() async {
    try {
      Map<String, String> headers = {
        "authorization":
            "Bearer 103|BpPFh7aDKQtvRLWDlSNV7uVsCEIRR5sZ7lNlztPq3f8cb130",
        "Content-Type": "application/json",
      };

      dynamic response = await _apiServices.getGetApiWithHeaderResponse(
        AppUrl.getVisitorSocietyUrl,
        headers,
      );

      if (response != null && response['buildings'] != null) {
        print('gjqjgjgqjqg');
        return List<String>.from(response['buildings']);
      } else {
        throw Exception('No buildings data found');
      }
    } catch (e) {
      throw Exception('Error fetching buildings: $e');
    }
  }

  // Fetch visitors for the selected building
  Future<List<String>> getVisitorNames(String building) async {
    try {
      Map<String, String> headers = {
        "authorization":
            "Bearer 103|BpPFh7aDKQtvRLWDlSNV7uVsCEIRR5sZ7lNlztPq3f8cb130",
        "Content-Type": "application/json",
      };

      dynamic response = await _apiServices.getGetApiWithHeaderResponse(
        '${AppUrl.getVisitorSocietyBuildingUrl}?building=$building',
        headers,
      );

      if (response != null && response['users'] != null) {
        print(response.body);
        return List<String>.from(
          response['users'].map((user) => user['name'].toString()),
        );
      } else {
        print(building);
        throw Exception('No users found for the selected building');
      }
    } catch (e) {
      throw Exception('Error fetching visitor names: $e');
    }
  }
}
