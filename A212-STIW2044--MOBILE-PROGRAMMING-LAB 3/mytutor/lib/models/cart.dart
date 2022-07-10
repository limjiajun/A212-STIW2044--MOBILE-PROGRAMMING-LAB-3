class Cart {
  String? cartid;
  String? subjectname;
  String? price;
  String? cartqty;
  String? subjectId;
  String? pricetotal;

  Cart(
      {this.cartid,
      this.subjectname,
      this.price,
      this.cartqty,
      this.subjectId,
      this.pricetotal});

  Cart.fromJson(Map<String, dynamic> json) {
    cartid = json['cartid'];
    subjectname = json['subjectname'];
    price = json['price'];
    cartqty = json['cartqty'];
    subjectId= json['subjectid'];
    pricetotal = json['pricetotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cartid'] = cartid;
    data['subjectname'] = subjectname;
    data['price'] = price;
    data['cartqty'] = cartqty;
    data['subjectid'] = subjectId;
    data['pricetotal'] = pricetotal;
    return data;
  }
}