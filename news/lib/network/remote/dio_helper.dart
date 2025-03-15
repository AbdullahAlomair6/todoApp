import 'package:dio/dio.dart';

class DioHelper{

  static late Dio dio; // Dio dio = Dio(); --object
  late int x;
 static init(){
   dio=Dio(
     BaseOptions(
       baseUrl: 'https://newsapi.org/',
       receiveDataWhenStatusError: true,
     )
   );
 }

// can not use void bec get return Future<Response> ;)
  static Future<Response> getData({
    required String url,
    required Map<String,dynamic> query,
  }) async
  {
    return await dio.get(url,queryParameters: query,);

  }

}