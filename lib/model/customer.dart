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
  int id;
  String name;
  int age;
  String before_img;
  String after_img;
  String notes;
  String created_at;
  String updated_at;
  String diagnosis;
  List<Prescription> prescriptions = List<Prescription>();

  int get customerValue {
    int price = 0;
    if (prescriptions != null) {
      for (Prescription prescription in prescriptions) {
        price = price + prescription.price;
      }
    }
    return price;
  }

  Map<int, dynamic> get since => _since;

  Map<int, dynamic> _since;

  Customer(
      {this.id,
      this.name,
      this.age,
      this.before_img,
      this.after_img,
      this.notes,
      this.created_at,
      this.updated_at,
      this.prescriptions,
      this.diagnosis}) {
    if (this.created_at != null) this._since = getSince(this.created_at);
    if (this.prescriptions == null) this.prescriptions = List<Prescription>();
  }

  factory Customer.fromJson(Map<String, dynamic> json) {
    
    List<Prescription> prescriptions = json['prescriptions'] != null ?List<Prescription>.from(
        json['prescriptions']
            .map((e) => Prescription.fromJson(e as Map<String, dynamic>))): List<Prescription>();
    return Customer(
        id: json['id'],
        name: json['name'],
        age: json['age'],
        before_img: json['before_img'],
        after_img: json['after_img'],
        notes: json['notes'],
        created_at: json['created_at'],
        updated_at: json['updated_at'],
        prescriptions: prescriptions,
        diagnosis: json['diagnosis']);
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
        "prescriptions": prescriptions?.map((e) => e?.toJson())?.toList(),
        "diagnosis": diagnosis,
      };

  Map<int, dynamic> getSince(String created_at) {
    DateTime now = DateTime.now();
    dynamic dd = created_at.split("T")[0].split("-");
    //dynamic dt = created_at.split("T")[1].split(":") ;

    int y = int.parse(dd[0]);
    int m = int.parse(dd[1]);
    int d = int.parse(dd[2]);

    Duration duration = now.difference(DateTime(y, m, d));

    if (duration.inDays > 0) {
      if (duration.inDays > 365) {
        int y = (duration.inDays / 365).floor();
        if (y * 365 < duration.inDays)
          return {0: "$y+", 1: "YEARS"};
        else
          return {0: y, 1: "YEARS"};
      }
      if (duration.inDays > 30) {
        int m = (duration.inDays / 30).floor();
        if (m * 30 < duration.inDays)
          return {0: "$m+", 1: "MONTHS"};
        else
          return {0: m, 1: "MONTHS"};
      } else
        return {0: duration.inDays, 1: "DAYS"};
    }
    return {0: duration.inHours, 1: "HOURS"};
  }
}
