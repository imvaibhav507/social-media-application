class AppUrl {
  static const String baseUrl = 'http://172.23.128.1:8080/api/v1';

  static const String signupApi = '$baseUrl/users/register';
  static const String loginApi = '$baseUrl/users/login';
  static const String uploadImageApi = '$baseUrl/users/update-avatar';
  static const String addGenderApi = '$baseUrl/users/add-gender';
}