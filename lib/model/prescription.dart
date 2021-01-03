
import 'package:json_annotation/json_annotation.dart';

part 'prescription.g.dart';


/**
 * {
      "id": 2,
      "name": "Baby Hair",
      "notes": "24",
      "creation_date": "2020-09-17",
      "price": 250,
      "created_at": "2020-09-17T19:38:50.000000Z",
      "updated_at": "2020-09-17T19:38:50.000000Z",
      "pivot": {
                "customer_id": 2,
                "prescription_id": 2,
                "created_at": "2021-01-20T00:00:00.000000Z",
                "updated_at": "2021-01-06T00:00:00.000000Z"
            }
  }
 */

@JsonSerializable(explicitToJson: true)
class Prescription {
    int id ; 
    String name ;
    String notes ;
    String creation_date ;
    int price ;
    Pivot pivot;


    Prescription({this.id, this.name, this.creation_date, this.notes, this.price, this.pivot}) ;

    factory Prescription.fromJson(Map<String, dynamic> json) {
      return _$PrescriptionFromJson(json) ;
    }

    Map<String, dynamic> toJson() {
      return _$PrescriptionToJson(this) ;
    }
}

class Pivot {
  int customer_id;
  int prescription_id;
  String created_at;
  String updated_at;
  Pivot(this.customer_id, this.prescription_id, this.created_at, this.updated_at) ;

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(json['customer_id'], json['prescription_id'], json['created_at'], json['updated_at']) ;
  }

  Map<String, dynamic> toJson() => {
    "customer_id" : customer_id ,
    "prescription_id" : prescription_id,
    "created_at": created_at, 
    "updated_at": updated_at
  };
}