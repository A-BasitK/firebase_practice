// To parse this JSON data, do
//
//     final invoiceData = invoiceDataFromMap(jsonString);


import 'dart:convert';

InvoiceData invoiceDataFromMap(String str) => InvoiceData.fromMap(json.decode(str));

String invoiceDataToMap(InvoiceData data) => json.encode(data.toMap());
class InvoiceModel{
  String id;
  InvoiceData invoiceData;
  InvoiceModel({required this.invoiceData,required this.id});
}

class InvoiceData {
  InvoiceData({
    required this.item,
    required this.price,
    required this.name,
  });

  final String item;
  final String price;
  final String name;

  factory InvoiceData.fromMap(Map<String, dynamic> json) => InvoiceData(
    item: json["Item"],
    price: json["Price"],
    name: json["Name"],
  );

  Map<String, dynamic> toMap() => {
    "Item": item,
    "Price": price,
    "Name": name,
  };
}
