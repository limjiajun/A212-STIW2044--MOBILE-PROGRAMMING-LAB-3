class User {
  String? id;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? homeaddress;
   String? cart;


  User({this.id, this.name, this.email, this.password,this.phone, this.homeaddress, this.cart});


 User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    homeaddress = json['homeaddress'];
    cart = json['cart'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['phone'] = phone;
    data['homeaddress'] = homeaddress;
    data['cart'] = cart.toString();
    return data;
  }
}
