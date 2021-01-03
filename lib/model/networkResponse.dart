import 'package:json_annotation/json_annotation.dart';

/**
 * "{
 *    "data" : null , 
 *    'msg' : 'could not add customer', 
 *    'error' : true
 * }"
 */

part 'networkResponse.g.dart' ;

@JsonSerializable(genericArgumentFactories: true)
class NetworkResponse<T> {
    T data ; 
    String msg ; 
    bool error ; 
    
    NetworkResponse({this.msg, this.error, this.data});
    
    factory NetworkResponse.fromJson(Map<String, dynamic> json, Function dataFromJson){
      return _$NetworkResponseFromJson<T>(json, dataFromJson) ;
    }

    Map<String, dynamic> toJson(Function dataToJson){
      return _$NetworkResponseToJson<T>(this, dataToJson) ;
    }

}
