import 'package:dio/dio.dart';

// class AppInterceptors extends Interceptor {
//   @override
//   void onRequest(
//       RequestOptions options, RequestInterceptorHandler handler) async {
//     if (options.headers.containsKey("requiresToken")) {
//       //remove the auxiliary header
//       options.headers.remove("requiresToken");
//
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       var header = prefs.get("Header");
//       options.headers.addAll({"Header": "$header${DateTime.now()}"});
//       // return options;
//     }
//   }
//   @override
//   FutureOr<dynamic> onError(DioError dioError) {
//     if (dioError.message.contains("ERROR_001")) {
//       // this will push a new route and remove all the routes that were present
//       navigatorKey.currentState
//           .pushNamedAndRemoveUntil("/login", (Route<dynamic> route) => false);
//     }
//     return dioError;
//   }
//   @override
//   FutureOr<dynamic> onResponse(Response options) async {
//     if (options.headers.value("verifyToken") != null) {
//       //if the header is present, then compare it with the Shared Prefs key
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       var verifyToken = prefs.get("VerifyToken");
//       // if the value is the same as the header, continue with the request
//       if (options.headers.value("verifyToken") == verifyToken) {
//         return options;
//       }
//     }
//     return DioError(
//         request: options.request, message: "User is no longer active");
//   }
// }

class DioAuthInterceptor extends Interceptor {
  // final Dio _dio;
  // final _localStorage =
  //     LocalStorage.instance; // helper class to access your local storage

  // AuthInterceptor({required Dio client}) : _dio = client;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // if (options.headers["requiresToken"] == false) {
    //   // if the request doesn't need token, then just continue to the next interceptor
    //   options.headers.remove("requiresToken"); //remove the auxiliary header
    //   return handler.next(options);
    // }

    return handler.next(options);

    // get tokens from local storage, you can use Hive or flutter_secure_storage
    // final accessToken = _localStorage.getAccessToken();
    // final refreshToken = _localStorage.getRefreshToken();

    // if (accessToken == null || refreshToken == null) {
    //   _performLogout(_dio);

    //   // create custom dio error
    //   options.extra["tokenErrorType"] = TokenErrorType
    //       .tokenNotFound; // I use enum type, you can chage it to string
    //   final error = DioError(requestOptions: options, type: DioErrorType.other);
    //   return handler.reject(error);
    // }

    // check if tokens have already expired or not
    // I use jwt_decoder package
    // Note: ensure your tokens has "exp" claim
    // final accessTokenHasExpired = JwtDecoder.isExpired(accessToken);
    // final refreshTokenHasExpired = JwtDecoder.isExpired(refreshToken);

    // var _refreshed = true;

    // if (refreshTokenHasExpired) {
    // _performLogout(_dio);

    // create custom dio error
    // options.extra["tokenErrorType"] = TokenErrorType.refreshTokenHasExpired;
    // final error = DioError(requestOptions: options, type: DioErrorType.other);

    // return handler.reject(error);
    // } else if (accessTokenHasExpired) {
    // regenerate access token
    // _dio.interceptors.requestLock.lock();
    // _refreshed = await _regenerateAccessToken();
    // _dio.interceptors.requestLock.unlock();
    // }

    // if (_refreshed) {
    // add access token to the request header
    //   options.headers["Authorization"] = "Bearer $accessToken";
    //   return handler.next(options);
    // } else {
    // create custom dio error
    // options.extra["tokenErrorType"] =
    //     TokenErrorType.failedToRegenerateAccessToken;
    // final error = DioError(requestOptions: options, type: DioErrorType.other);
    // return handler.reject(error);
  }
}

@override
Future<dynamic> onResponse(Response options) async {
  if (options.headers.value("verifyToken") != null) {
    //if the header is present, then compare it wi
    // if the value is the same as the header, continue with the request
  }
  // return DioError(
  //     request: options.request, message: "User is no longer active");
}

@override
void onError(DioError err, ErrorInterceptorHandler handler) {
  if (err.response?.statusCode == 403 || err.response?.statusCode == 401) {
    // for some reasons the token can be invalidated before it is expired by the backend.
    // then we should navigate the user back to login page

    // _performLogout(_dio);

    // create custom dio error
    err.type = DioErrorType.other;
    // err.requestOptions.extra["tokenErrorType"] =
    //     TokenErrorType.invalidAccessToken;
  }

  return handler.next(err);
}

// void _performLogout(Dio dio) {
// dio.interceptors.clear();

// _localStorage.removeTokens(); // remove token from local storage

// back to login page without using context
// check this https://stackoverflow.com/a/53397266/9101876
// navigatorKey.currentState?.pushReplacementNamed(LoginPage.routeName);

// _dio.interceptors.requestLock.unlock();
// }

/// return true if it is successfully regenerate the access token
// Future<bool> _regenerateAccessToken() async {
// try {
// var dio =
//     Dio(); // should create new dio instance because the request interceptor is being locked

// get refresh token from local storage
// final refreshToken = _localStorage.getRefreshToken();

// make request to server to get the new access token from server using refresh token
// final response = await dio.post(
//   "https://yourDomain.com/api/refresh",
//   options: Options(headers: {"Authorization": "Bearer $refreshToken"}),
// );

// if (response.statusCode == 200 || response.statusCode == 201) {
//   final newAccessToken = response
//       .data["accessToken"]; // parse data based on your JSON structure
//   _localStorage.saveAccessToken(newAccessToken); // save to local storage
//   return true;
// } else if (response.statusCode == 401 || response.statusCode == 403) {
//   // it means your refresh token no longer valid now, it may be revoked by the backend
//   _performLogout(_dio);
//   return false;
// } else {
//   print(response.statusCode);
//   return false;
// }
// } on DioError {
//   return false;
// } catch (e) {
//   return false;
// }
// }
