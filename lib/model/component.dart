/**
 * {
    "id": 1,
    "name": "Vaseline",
    "quantity": "100",
    "expiry_date": "2021-01-28",
    "created_at": "2021-01-19T00:00:00.000000Z",
    "updated_at": "2021-01-19T00:00:00.000000Z",
    "unit": "ml",
    "price": 200,
    "pivot": {
        "prescription_id": 2,
        "component_id": 1
    }
 */

class Component {
  int id;
  String name;
  String quantity;
  String expiry_date;
  String unit;
  String created_at;
  String updated_at;
  int price;
  Map<String, dynamic> pivot;
  Component(
      {this.id,
      this.name,
      this.quantity,
      this.expiry_date,
      this.created_at,
      this.unit,
      this.updated_at,
      this.price,
      this.pivot = const {"prescription_id": null, "component_id": null}
      });

  factory Component.fromJson(Map<String, dynamic> json) {
    return Component(
        id: json['id'] as int,
        name: json['name'] as String,
        quantity: json['quantity'] as String,
        expiry_date: json['expiry_date'] as String,
        created_at: json['created_at'] as String,
        updated_at: json['updated_at'] as String,
        price: json['price'] as int,
        pivot: json['pivot'] as Map<String, dynamic>,
        unit: json['unit'] as String);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "quantity": quantity,
      "expiry_date": expiry_date,
      "created_at": created_at,
      "updated_at": updated_at,
      "unit": unit,
      "price": price,
      "pivot": {
        "prescription_id": pivot['prescription_id'],
        "component_id": pivot['component_id']
      }
    };
  }
}
