import 'package:flutter/material.dart';

class ProductData {

  static List<Map<String, dynamic>> cartList = [];


  static String? name;
  static String? email;
  static String? phone;
  static String? address;

  static double calculateTotalPrice = 0;

  static incrementQuantity(Map<String, dynamic> item) {

    item['quantity']++;
    totalPrice();

  }

  static ensureDefaultQuantities() {
    for (int i = 0; i < ProductData.cartList.length; i++) {
      if (ProductData.cartList[i]['quantity'] == null || ProductData.cartList[i]['quantity'] is! int || ProductData.cartList[i]['quantity'] < 1) {
        ProductData.cartList[i]['quantity'] = 1;
      }
    }
  }


  static decrementQuantity(Map<String, dynamic> item) {

    if (item['quantity'] > 1) {
      item['quantity']--;
      totalPrice();
    }

  }

  static totalPrice() {
    double newTotalPrice = 0.0;

    for (int i = 0; i < ProductData.cartList.length; i++) {
      var item = ProductData.cartList[i];
      double itemPrice = (item['price'] ?? 0.0).toDouble();
      int itemQuantity = item['quantity'] ?? 1;
      newTotalPrice += itemPrice * itemQuantity;
    }

    calculateTotalPrice = newTotalPrice;

  }

  static double totalsum = 0.0;
    static sum()
    {
      double TotalPrice=0.0;
      for (int i = 0; i < ProductData.cartList.length; i++){
        var item = ProductData.cartList[i];
        TotalPrice =  item['quantity']*item['quantity'];
      }
      totalsum = TotalPrice;
    }








}
