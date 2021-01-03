import 'package:HealthAndBeauty/model/prescription.dart';

/***
 *  {
        "id": 1,
        "name": "mohamed",
        "age": 24,
        "before_img": "placeholder.jpg",
        "after_img": "",
        "notes": "this is test",
        "created_at": "2020-09-16T18:11:56.000000Z",
        "updated_at": "2020-09-16T18:11:56.000000Z"
    },
 */

class Customer {
  int id ; 
  String name ; 
  int age ; 
  String before_img ; 
  String after_img ;
  String notes ;
  String created_at;
  String updated_at;
  List<Prescription> prescriptions ;

  String since ;


  Customer({this.id, this.name, this.age, this.before_img, this.after_img, this.notes, this.created_at, this.updated_at, this.prescriptions}){
    this.since = _since(created_at) ;
      }
    
      factory Customer.fromJson(Map<String, dynamic> json){
        List<Prescription> prescriptions = List<Prescription>.from(json['prescriptions'].map((e)=> Prescription.fromJson(e as Map<String, dynamic>)));
        return Customer(id: json['id'], name : json['name'], age: json['age'], before_img: json['before_img'],after_img: json['after_img'],notes: json['notes'], created_at: json['created_at'], updated_at: json['updated_at'], prescriptions: prescriptions);
      }
    
      Map<String, dynamic> toJson() => {
            "id": id,
            "name": name,
            "age": age,
            "before_img": before_img,
            "after_img": after_img,
            "notes": notes,
            "created_at": created_at,
            "updated_at": updated_at,
            "prescription" : prescriptions.map((e) => e.toJson()) as Map<String, dynamic>
        } ;
    
      String _since(String created_at) {

      }
}