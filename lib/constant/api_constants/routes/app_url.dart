class AppUrl {
  static var baseUrl = 'https://stagging.intouchsoftwaresolution.com/api';

  static var loginUrl = baseUrl + '/login';
  static var registerUrl = baseUrl + '/register';

  static String userDataUrl = "$baseUrl/user";

  static String getVisitorSocietyUrl =
      "https://stagging.intouchsoftwaresolution.com/api/society-buildings";
  static String getVisitorSocietyBuildingUrl =
      "https://stagging.intouchsoftwaresolution.com/api/building-users?building=A";
}
