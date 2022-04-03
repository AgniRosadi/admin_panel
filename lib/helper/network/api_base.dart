import '../constant/csi_settings.dart';
import '../utility/csi_log.dart';
import '../utility/csi_shared_prefs.dart';
import 'package:dio/dio.dart';

///API request service
class ApiBase {
  static const String _url = CsiSettings.apiBaseUrl;
  static final BaseOptions _opts = BaseOptions(
      baseUrl: _url,
      responseType: ResponseType.json,
      connectTimeout: 30000,
      receiveTimeout: 30000,
      followRedirects: false,
      validateStatus: (status) {
        if (status == null) {
          return false;
        } else {
          return status <= 500;
        }
      });
  static Map<String, dynamic>? _additionalHeader;

  ///Parameter 'baseUrl' for accessing other api url without changing so.apiBaseUrl
  ///Parameter 'addHeader' for adding more header
  ApiBase({String baseUrl = _url, Map<String, dynamic>? additionalHeader}) {
    _opts.baseUrl = baseUrl;
    if (additionalHeader != null) {
      _additionalHeader = additionalHeader;
    }
  }

  static Dio _createDio() {
    return Dio(_opts);
  }

  static Dio _addInterceptors(Dio dio) {
    return dio
      ..interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
        if(_additionalHeader != null){
          options.headers.addAll(_additionalHeader!);
        }

        CsiSharedPrefs.isLoggedIn().then((value) {
          if (value) {
            // Get saved JWT token
            CsiSharedPrefs.getToken().then((value) {
              options.headers.addAll({"Authorization": "Bearer $value", "X-Requested-With": "APIHttpRequest"});
            });
            // Set token to header
          }
        });

        return handler.next(options); //continue
      }, onResponse: (response, handler) async {
        if (response.data == null) {
          return handler.resolve(Response(requestOptions: response.requestOptions, statusCode: 901, statusMessage: "Err. Invalid Data. Failed to fetch."));
        } else {
          //Check if the server return new JWT token
          String token = response.headers.value("Authorization") ?? "";
          if (token.contains("Bearer ")) {
            //Save JWT token without bearer
            token = token.replaceAll("Bearer ", "");
            await CsiSharedPrefs.setToken(token);
          }
          return handler.next(response);
        }

        // continue
      }, onError: (DioError e, handler) {
        //log error to file
        CsiLog.logErrorException(e);
        //override status code and status message on error
        if (e.message.contains("errno = 101")) {
          return handler.resolve(Response(requestOptions: e.requestOptions, statusCode: -1, statusMessage: "Connection failed, please try again later."));
        } else if (e.message.contains("errno = 113")) {
          return handler
              .resolve(Response(requestOptions: e.requestOptions, statusCode: -1, statusMessage: "Sorry. Server busy or may be down, please try again later."));
        } else {
          // return handler
          //     .resolve(Response(requestOptions: e.requestOptions, statusCode: 999, statusMessage: "Error occurred: " + e.message));
          return handler.next(e);
        }
      }));
  }

  static final _dio = _createDio();
  static final _baseAPI = _addInterceptors(_dio);

  ///Get request
  Future<Response> getHTTP(String url) async {
    var response = await _baseAPI.get(url);
    return response;
  }

  ///Download request
  Future<Response> download(
    String urlPath,
    String savePath, {
    bool deleteOnError = true,
  }) async {
    var response = await _baseAPI.download(urlPath, savePath, deleteOnError: deleteOnError);
    return response;
  }

  ///Get request wtih map query parameter
  Future<Response> getHTTPMapParam(String url, Map<String, String> data) async {
    var response = await _baseAPI.get(url, queryParameters: data);
    return response;
  }

  ///Post request
  Future<Response> postHTTP(String url, dynamic data) async {
    var response = await _baseAPI.post(url, data: data);
    return response;
  }

  ///Post with multipart data
  Future<Response> multipartPostHTTP(String url, dynamic data) async {
    final formData = FormData.fromMap(data);
    var response = await _baseAPI.post(url, data: formData);
    return response;
  }

  ///Put request
  Future<Response> putHTTP(String url, dynamic data) async {
    var response = await _baseAPI.put(url, data: data);
    return response;
  }

  ///Delete request
  Future<Response> deleteHTTP(String url) async {
    var response = await _baseAPI.delete(url);
    return response;
  }
}
