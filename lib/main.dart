import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoice_generator/screen/cart_page.dart';
import 'package:invoice_generator/screen/home_page.dart';
import 'package:invoice_generator/screen/pdf_page.dart';
import 'package:invoice_generator/screen/screen.dart';


void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
     systemNavigationBarColor: Colors.black54,
    statusBarBrightness: Brightness.dark,
     statusBarColor: Colors.black54,

  ),);
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);



  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'splash_screen',
        routes: {
          'splash_screen':(context){return Screen();},
          '/':(context){return HomePage();},
           'cart_page':(context){return CartPage();},
            'pdf_page':(context){return PdfPage(); }

        },
      )
  );
}

