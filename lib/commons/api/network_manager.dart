import 'package:hamrokhata/commons/api/api.dart';
import 'package:dio/dio.dart';
import 'package:hamrokhata/commons/api/config.dart';
import 'package:hamrokhata/commons/api/network_response.dart';

class ApiInterface {
  Api apiClient = Api();

  Future<NetworkResponse> getDefaulterList(
    username,
    password,
  ) async {
    apiClient.getClient();

    NetworkResponse rs = NetworkResponse();
    Map<String, dynamic> body = {
      "username": username,
      "password": password,
    };
    try {
      await apiClient.dio.post(Config.loginUrl, data: body).then((response) {
        rs.status = response.statusCode;
        rs.body = (response.data);
      });
    } on DioError catch (e) {
      rs.status = e.response!.statusCode ?? 500;
      rs.body = e.response!.data;
    }
    return rs;
  }

  Future<NetworkResponse> getUserDetails(staffid) async {
    apiClient.getClient();
    NetworkResponse rs = NetworkResponse();
    try {
      await apiClient.dio.get(Config.getSalesList, queryParameters: {
        'staffid': staffid,
      }).then((response) {
        rs.status = response.statusCode;
        rs.body = (response.data);
      });
    } on DioError catch (e) {
      rs.status = e.response!.statusCode;
      rs.body = e.response!.data;
    }
    return rs;
  }
}
