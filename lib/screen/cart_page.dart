import 'package:flutter/material.dart';
import '../utilslist/global.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {


  @override
  void initState() {
    super.initState();
    ProductData.ensureDefaultQuantities();
    ProductData.totalPrice();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('pdf_page');
            },
            icon: const Icon(
              Icons.list_alt_rounded,
              color: Colors.pink,
              size: 40,
            ),
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: ProductData.cartList.map((e) {
            return Container(
              margin: const EdgeInsets.all(10),
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey.shade200,
                  width: 3,
                ),
              ),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 130,
                        width: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: const EdgeInsets.all(10),
                        child: Image.network(
                          e['thumbnail'],
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          height: 350,
                          width: 150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              Text(
                                e['item'],
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "₹ ${e['price']}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.pink,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      IconButton(
                                        padding: const EdgeInsets.all(2),
                                        alignment: Alignment.center,
                                        icon: const Icon(Icons.remove, size: 18, color: Colors.pink),
                                        onPressed: () {
                                          setState(() {
                                            ProductData.decrementQuantity(e);
                                          });
                                        }

                                      ),
                                      Text(
                                        '${e['quantity']}',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      IconButton(
                                        padding: const EdgeInsets.all(2),
                                        alignment: Alignment.center,
                                        icon: const Icon(Icons.add, size: 18, color: Colors.pink),
                                        onPressed: (){
                                          setState(() {
                                            ProductData.incrementQuantity(e);
                                          });
                                        }
                                      ),

                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                "₹  ${e['quantity']*e['price']}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, bottom: 1),
                    child: FloatingActionButton.small(
                      heroTag: null,
                      backgroundColor: Colors.white,
                      onPressed: () {
                        setState(() {
                          ProductData.cartList.remove(e);
                          ProductData.totalPrice();
                        });
                      },
                      child: const Icon(Icons.remove, color: Colors.red),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          height: 45,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.pink,
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: Text(
            "TOTAL PRICE : ₹ ${ProductData.calculateTotalPrice}",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}
