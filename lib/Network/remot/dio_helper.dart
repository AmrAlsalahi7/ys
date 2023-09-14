import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ys/Network/endpoint.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        headers: {
          'Access-Control-Allow-Origin': '*',
          'accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  Future<List<dynamic>> getData({
    required String url,
    required  Map<String,dynamic> query
  }) async {
    try {
      dio.options.headers = {
        'Access-Control-Allow-Origin': '*',
        'accept': 'application/json',
        'Content-Type': 'application/json',
      };
      Response response = await dio.get(url,queryParameters: query);
      return response.data;

      //print(response.data);
      //return await dio.get(url);
    } on DioError catch (e) {
      // print(e);
      return [];
    }
  }

  static Future<Response> postData({
    required String  url,
    Map<String, dynamic>? data,
  }) async {

    return dio.post(url,data: data);

  }
}
