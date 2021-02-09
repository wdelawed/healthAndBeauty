
import 'package:HealthAndBeauty/model/component.dart';
import 'package:flutter/cupertino.dart';
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
    
    
    String presc_image;
    List<Component> components ;

    int get customers {
      return 1 ;
    }

    ImageProvider<dynamic> _image ;

    ImageProvider<dynamic> get image {
      return _image ;
    }

    

    Prescription({this.id, this.name, this.creation_date, this.notes, this.price, this.pivot, this.presc_image="", this.components}) ;

    factory Prescription.fromJson(Map<String, dynamic> json) {
      Prescription pres =  _$PrescriptionFromJson(json) ;
      pres._image = pres.presc_image != null ? NetworkImage(pres.presc_image) :  AssetImage("");
      return pres ;
    }

    Map<String, dynamic> toJson() {
      return _$PrescriptionToJson(this) ;
    }

    String _getSince(String date ) {
        DateTime now = DateTime.now() ;
        dynamic dd = date.split("T")[0].split("-") ;
        //dynamic dt = created_at.split("T")[1].split(":") ;

        
        int y =  int.parse(dd[0]) ;
        int m =  int.parse(dd[1]) ;
        int d =  int.parse(dd[2]) ;

        Duration duration = now.difference(DateTime(y, m, d)) ;

        if(duration.inDays > 0){
          if(duration.inDays > 365){
            int y =  (duration.inDays / 365).floor()  ;
            if(y * 365 < duration.inDays)
              return "$y+ YEARS" ;
            else 
              return "$y YEARS" ;
          }
          if(duration.inDays > 30){
            int m = (duration.inDays / 30).floor() ;
            if(m * 30 < duration.inDays)
              return "$m+ MONTHS" ;
            else 
              return "$m MONTHS" ;
          }
          else 
            return "${duration.inDays} DAYS" ;
        }
        return "${duration.inHours} HOURS" ;
      }
}

class Pivot {
  int customer_id;
  int prescription_id;
  String created_at;
  String updated_at;

  String get since {return _getSince(created_at) ;}

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

  String _getSince(String date ) {
        DateTime now = DateTime.now() ;
        dynamic dd = date.split("T")[0].split("-") ;
        dynamic dt = date.split("T")[1].split(":") ;

        
        int y =  int.parse(dd[0]) ;
        int m =  int.parse(dd[1]) ;
        int d =  int.parse(dd[2]) ;
        int h =  int.parse(dt[0]) ;
        int mi=  int.parse(dt[1]) ;
        //int s =  int.parse(dt[2]) ;

        Duration duration = now.difference(DateTime(y, m, d, h)) ;

        if(duration.inDays > 0){
          if(duration.inDays > 365){
            int y =  (duration.inDays / 365).floor()  ;
            if(y * 365 < duration.inDays)
              return "$y+\n YEARS" ;
            else 
              return "$y\n YEARS" ;
          }
          if(duration.inDays > 30){
            int m = (duration.inDays / 30).floor() ;
            if(m * 30 < duration.inDays)
              return "$m+\n MONTHS" ;
            else 
              return "$m\n MONTHS" ;
          }
          else 
            return "${duration.inDays}\n DAYS" ;
        }
        return "${duration.inHours}\n HOURS" ;
      }
}