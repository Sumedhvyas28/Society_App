class AppUrl {
  static var baseUrl = 'https://stagging.intouchsoftwaresolution.com/api';

  static var loginUrl = baseUrl + '/login';
  static var registerUrl = baseUrl + '/register';

  static String userDataUrl = "$baseUrl/user";

  static String getVisitorSocietyUrl =
      "https://stagging.intouchsoftwaresolution.com/api/society-buildings";
  static String getVisitorSocietyBuildingUrl =
      "https://stagging.intouchsoftwaresolution.com/api/building-users?building=A";

  static String postVisitorUrl =
      "https://stagging.intouchsoftwaresolution.com/api/visitor";
  static String getGuardNameUrl = baseUrl + '/guards';

  static String postGuardMessageUrl = baseUrl + '/guard-messages';
  static String updateDeviceTokenUrl = baseUrl + '/update-device-token';
}
