import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoice_generator/utilslist/global.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfPage extends StatefulWidget {
  const PdfPage({super.key});

  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  final pdf = pw.Document();

  Future<void> generateAndSavePdf() async {
    final Uint8List imageBytes = await _loadAsset('assets/images/food-delivery.jpg');
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.all(15),
                child: pw.Column(
                  children: [
                    pw.Row(
                      children: [
                        pw.Image(
                          pw.MemoryImage(imageBytes),
                          height: 100,
                          width: 100,
                        ),
                        pw.SizedBox(width: 8),
                        pw.Container(
                          alignment: pw.Alignment.bottomCenter,
                          height: 100,
                          child: pw.Text(
                            'Food Delivery',
                            style: pw.TextStyle(
                              fontSize: 20,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    pw.Divider(
                      height: 20,
                      thickness: 4,
                      color: PdfColors.black,
                    ),
                    pw.Row(
                      children: [
                        pw.Padding(
                          padding: pw.EdgeInsets.only(left: 8.0),
                          child: pw.Text(
                            '${ProductData.name}',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.normal,
                              fontSize: 13,
                              wordSpacing: 5,
                            ),
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 3),
                    pw.Row(
                      children: [
                        pw.Padding(
                          padding: pw.EdgeInsets.only(left: 8.0),
                          child: pw.Text(
                            '${ProductData.email}',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.normal,
                              fontSize: 13,
                              wordSpacing: 5,
                            ),
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 3),
                    pw.Row(
                      children: [
                        pw.Padding(
                          padding: pw.EdgeInsets.only(left: 8.0),
                          child: pw.Text(
                            '${ProductData.phone}',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.normal,
                              fontSize: 13,
                              wordSpacing: 5,
                            ),
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 3),
                    pw.Row(
                      children: [
                        pw.Padding(
                          padding: pw.EdgeInsets.only(left: 8.0),
                          child: pw.Text(
                            '${ProductData.address}',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.normal,
                              fontSize: 13,
                              wordSpacing: 5,
                            ),
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 5),
                    pw.Container(
                      height: 20,
                      width: 350,
                      child: pw.Row(
                        children: [
                          pw.Expanded(
                            flex: 5,
                            child: pw.Center(
                              child: pw.Text('Product Name'),
                            ),
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              child: pw.Text('Price'),
                            ),
                          ),
                          pw.Expanded(
                            flex: 3,
                            child: pw.Container(
                              child: pw.Text('Quantity'),
                            ),
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              child: pw.Text('Total'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    pw.Column(
                      children: ProductData.cartList.map((e) {
                        return pw.Container(
                          height: 20,
                          width: 350,
                          child: pw.Row(
                            children: [
                              pw.Expanded(
                                flex: 5,
                                child: pw.Container(
                                  alignment: pw.Alignment.topLeft,
                                  child: pw.Text(e['item']),
                                ),
                              ),
                              pw.Expanded(
                                flex: 2,
                                child: pw.Container(
                                  child: pw.Text("Rs. ${e['price']}"),
                                ),
                              ),
                              pw.Expanded(
                                flex: 3,
                                child: pw.Container(
                                  child: pw.Text('${e['quantity']}'),
                                ),
                              ),
                              pw.Expanded(
                                flex: 2,
                                child: pw.Container(
                                  child: pw.Text(
                                      "Rs. ${e['quantity'] * e['price']}"),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    pw.SizedBox(height: 10),
                    pw.Divider(),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      children: [
                        pw.Expanded(
                          flex: 15,
                          child: pw.Padding(
                            padding: pw.EdgeInsets.only(right: 8),
                            child: pw.Container(
                              alignment: pw.Alignment.bottomRight,
                              child: pw.Text(
                                "TOTAL PRICE : Rs. ${ProductData.calculateTotalPrice}",
                                style: pw.TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      children: [
                        pw.Container(
                          child: pw.Text('___________________________'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    // Save PDF
    Directory? folder = await getDownloadsDirectory();
    File pdfFile = File('${folder!.path}/invoice.pdf');
    await pdfFile.writeAsBytes(await pdf.save());

    // Print PDF
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  Future<Uint8List> _loadAsset(String path) async {
    final ByteData data = await rootBundle.load(path);
    return data.buffer.asUint8List();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () async {
              await generateAndSavePdf();
            },
            icon: Icon(
              Icons.picture_as_pdf_outlined,
              color: Colors.pink,
              size: 40,
            ),
          ),
        ],
      ),
      body: Container(
        child: (ProductData.name != null)
            ? Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/food-delivery.jpg',
                        height: 100,
                        width: 100,
                      ),
                      SizedBox(width: 8),
                      Container(
                        alignment: Alignment.bottomCenter,
                        height: 100,
                        child: Text(
                          'Food Delivery',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 20,
                    thickness: 4,
                    color: Colors.black,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          '${ProductData.name}',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            wordSpacing: 5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          '${ProductData.email}',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            wordSpacing: 5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          '${ProductData.phone}',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            wordSpacing: 5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          '${ProductData.address}',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            wordSpacing: 5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: 20,
                    width: 350,
                    decoration: BoxDecoration(color: Colors.black26),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Center(
                            child: Text(
                              'Product Name',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: Text(
                              'Price',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            child: Text(
                              'Quantity',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: Text(
                              'Total',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: ProductData.cartList.map((e) {
                      return Container(
                        height: 20,
                        width: 350,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  e['item'],
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Text(
                                  "Rs. ${e['price']}",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                child: Text(
                                  '${e['quantity']}',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Text(
                                  "Rs. ${e['quantity'] * e['price']}",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 10),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 15,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Container(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "TOTAL PRICE : Rs. ${ProductData.calculateTotalPrice}",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        child: Text('___________________________'),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.picture_as_pdf_outlined,
              color: Colors.red,
              size: 300,
            ),
            SizedBox(height: 20),
            Text(
              'Fill form first...',
              style: TextStyle(
                color: Colors.red,
                fontSize: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
