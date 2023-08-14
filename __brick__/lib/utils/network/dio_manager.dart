// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:dio/dio.dart';

enum Method { get, post }

typedef Success<T> = Function(T data); // 定义一个函数 请求成功回调
typedef Error = Function(ErrorRes errorRes); // 请求失败统一回调
typedef SuccessList<T> = Function(List<T> data); // 请求数据data为[]集合

class ErrorRes {
  int? code;
  String? message;

  ErrorRes({
    this.code,
    this.message,
  });

  @override
  String toString() => 'Error (code: $code, message: $message)';
}

/// dio配置类
class DioManager {
  static const baseUrl = "https://xxx"; // 正式环境

  static DioManager instance = DioManager._internal();
  Dio? _dio;
  final Map<String, dynamic> _headers = {};

  // 单例 私有化构造初始化dio
  DioManager._internal() {
    if (_dio == null) {
      BaseOptions options = BaseOptions(
          baseUrl: baseUrl,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          receiveDataWhenStatusError: false,
          //connectTimeout: _connectTimeout,
          //receiveTimeout: _receiveTimeout,
          headers: _headers);
      _dio = Dio(options);
    }

    /// 正式环境拦截日志打印
    if (!const bool.fromEnvironment("dart.vm.product")) {
      _dio?.interceptors
          .add(LogInterceptor(requestBody: true, responseBody: true));
    }
  }

  Future<Uint8List> imageToBytes(String imageUrl) async {
    var response = await _dio?.get(imageUrl,
        options: Options(responseType: ResponseType.bytes));
    return Uint8List.fromList(response?.data);
  }

  get header => _headers;

  /// 更新header
  updateHeader() {
    _dio?.options.headers = _headers;
  }

  /// 请求，返回的渲染数据 T
  /// method：请求方法，NWMethod.GET等
  /// path：请求地址
  /// params：请求参数
  /// success：请求成功回调
  /// error：请求失败回调
  Future request<T>(Method method, String path,
      {String? baseUrl,
      Map<String, dynamic>? params,
      data,
      ProgressCallback? onSendProgress, // 上传数据进度
      ProgressCallback? onReceiveProgress, // 接受数据进度
      Success<T>? success,
      Error? error}) async {
    try {
      // var connectivityResult = await (Connectivity().checkConnectivity());

      // if (connectivityResult == ConnectivityResult.none) {
      //   if (error != null) {
      //     error(ErrorRes(code: -9, message: "网络异常~,请检查您的网络状态!"));
      //   }
      //   return;
      // }
      //_setBaseUrl(baseUrl); // 动态设置baseUrl
      Response? response = await _dio?.request(
        path,
        queryParameters: params,
        data: data,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        // TODO: fix method
        options: Options(method: 'get'),
      );
      if (response != null) {
        BaseRes entity = BaseRes<T>.fromJson(response.data);
        // 对象数据结构
        if (entity.code == 200 && entity.data != null) {
          if (success != null) success(entity.data);
          return response;
        } else {
          if (error != null) {
            error(ErrorRes(code: entity.code, message: entity.message));
          }
        }
      } else {
        if (error != null) error(ErrorRes(code: -1, message: "未知错误"));
        return response;
      }
    } on DioError {
      if (error != null) error(ErrorRes(code: -1, message: 'DioError'));
    }
  }
}

/// 响应数据头数据统一管理
class BaseRes<T> {
  int? code; // 状态码
  String? message; // 状态码说明
  T? data; // 渲染数据

  BaseRes({this.code, this.message, this.data});

  factory BaseRes.fromJson(json) {
    int code;
    // json 渲染json数据
    try {
      if (json["code"] != null) {
        try {
          code = json["code"];
        } catch (e) {
          code = -1;
        }
      } else {
        return BaseRes(code: -1, message: "服务器开小差了~", data: null);
      }
      return BaseRes(
          code: code,
          message: json["message"],
          data: BeanFactory.generateOBJ<T>(json["data"]));
    } catch (e) {
      return BaseRes(code: -1, message: "服务器开小差了~", data: null);
    }
  }
}

/// 实体bean转化工厂类
class BeanFactory {
  static T? generateOBJ<T>(json) {
    //T.toString() 类名
    try {
      switch (T.toString()) {
        case "int":
          return json;
        case "bool":
          return json;
        case "String":
          return json;
        default:
          // 实体类序列化
          return TestBean.fromJson(json) as T;
      }
    } catch (e) {
      return null;
    }
  }
}

/// 测试bean
class TestBean {
  String? msg;
  bool? isSelector;
  TestBean(this.msg, this.isSelector);

  TestBean.fromJson(dynamic json) {
    msg = json["msg"];
    isSelector = json["isSelector"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["msg"] = msg;
    map["isSelector"] = isSelector;
    return map;
  }
}
