import 'package:HealthAndBeauty/helpers/uitilities.dart';
import 'package:HealthAndBeauty/model/customer.dart';
import 'package:HealthAndBeauty/model/networkResponse.dart';
import 'package:HealthAndBeauty/model/prescription.dart';
import 'package:dio/dio.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class DioClient {
  Dio _dio;
  DioClient() {
    if (_dio == null) _dio = Dio(BaseOptions(baseUrl: Utils.baseUrl));
  }

  Future<NetworkResponse<Prescription>> addPrescription(
      Prescription prescription) async {
    dynamic _value = "";
    if (prescription.presc_image != null &&
        prescription.presc_image.isNotEmpty) {
      final mimeTypeData =
          lookupMimeType(prescription.presc_image, headerBytes: [0xFF, 0xD8])
              .split('/');
      _value = await MultipartFile.fromFile(prescription.presc_image,
          contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
    }
    Map<String, dynamic> data = prescription.toJson();
    data.update("presc_image",
        (value) => value != null && value.isNotEmpty ? _value : value);
    FormData formData = FormData.fromMap(data);

    final _result = await _dio.request<Map<String, dynamic>>('/prescription/',
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            baseUrl: Utils.baseUrl),
        data: formData);
    final value = NetworkResponse<Prescription>.fromJson(
      _result.data,
      (json) => Prescription.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  Future<NetworkResponse<Customer>> addCustomer(Customer customer) async {
    dynamic _value = "";
    if (customer.before_img != null && customer.before_img.isNotEmpty) {
      final mimeTypeData =
          lookupMimeType(customer.before_img, headerBytes: [0xFF, 0xD8])
              .split('/');
      _value = await MultipartFile.fromFile(customer.before_img,
          contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
    }
    Map<String, dynamic> data = customer.toJson();
    data.update("before_img",
        (value) => value != null && value.isNotEmpty ? _value : value);
    FormData formData = FormData.fromMap(data);

    final _result = await _dio.request<Map<String, dynamic>>('/customer/',
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            baseUrl: Utils.baseUrl),
        data: formData);
    final value = NetworkResponse<Customer>.fromJson(
      _result.data,
      (json) => Customer.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  Future<NetworkResponse<Customer>> updateCustomerImage(
      String image, int customerId) async {
    dynamic _value = "";

    final mimeTypeData =
        lookupMimeType(image, headerBytes: [0xFF, 0xD8]).split('/');
    _value = await MultipartFile.fromFile(image,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));

    FormData formData =
        FormData.fromMap({"after_img": _value, "id": customerId});

    final _result = await _dio.request<Map<String, dynamic>>('/customer/updateImage',
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            baseUrl: Utils.baseUrl),
        data: formData);
    final value = NetworkResponse<Customer>.fromJson(
      _result.data,
      (json) => Customer.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }
}
