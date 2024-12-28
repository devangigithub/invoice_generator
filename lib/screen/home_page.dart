import 'package:flutter/material.dart';
import 'package:invoice_generator/utilslist/global.dart';
import 'package:invoice_generator/utilslist/list.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {

  final TextEditingController nameController =TextEditingController();
  final TextEditingController emailController =TextEditingController();
  final TextEditingController phoneController =TextEditingController();
  final TextEditingController addressController =TextEditingController();

  final GlobalKey<FormState> formKey =GlobalKey<FormState>();

  File? imageFile;
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).pushNamed("cart_page");

          }, icon: const Icon(Icons.shopping_cart,color: Colors.pink,))
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            Column(
              children: [
                Column(
                  children: [

                    DrawerHeader(
                      child: CircleAvatar(
                        radius: 80,
                        child: (imageFile == null) ? Text("ADD") : Container(),
                        backgroundImage:
                        (imageFile == null) ? null : FileImage(imageFile!),
                      ),
                    ),
                    FloatingActionButton(
                        mini: true,
                        child: Icon(Icons.add),
                        elevation: 0,
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: CircleBorder(),
                        onPressed: () async {
                          XFile? xFile = await picker.pickImage(
                              source: ImageSource.camera);
                          imageFile = File(xFile!.path);
                          setState(() {});
                        }),
                  ],
                ),
                
               Form(
                 key: formKey,
                 child: Column(
                   children: [
                     Padding(
                       padding: const EdgeInsets.only(right: 10,left: 10),
                       child: TextFormField(
                         controller: nameController,
                         onSaved: (e){
                           ProductData.name =e;
                         },
                         validator: (e){
                            if(e!.isEmpty){
                                return 'Please enter your name first...';
                            }
                            else{
                              return null;
                            }
                         },

                         keyboardType: TextInputType.text,
                         textInputAction: TextInputAction.next,
                         decoration: InputDecoration(
                              labelText: 'Name',
                           hintText: ' Enter Your Name',
                           prefixIcon: Icon(Icons.person),
                           suffixIcon: IconButton(onPressed: (){
                             nameController.clear();
                           }, icon: Icon(Icons.highlight_remove_outlined,color: Colors.red,)),
                         ),
                       ),
                     ),

                     Padding(
                       padding: const EdgeInsets.only(right: 10,left: 10),
                       child: TextFormField(
                         controller: emailController,
                         onSaved: (e){
                           ProductData.email=e;
                         },
                         validator: (e){
                           if(e!.isEmpty){
                             return 'Please enter your email first...';
                           }
                           else{
                             return null;
                           }
                         },
                         keyboardType: TextInputType.emailAddress,
                         textInputAction: TextInputAction.next,
                         decoration: InputDecoration(
                           labelText: 'Email',
                           hintText: ' Enter Your Emailid',
                           prefixIcon: Icon(Icons.email_outlined),
                           suffixIcon: IconButton(onPressed: (){
                             emailController.clear();
                           }, icon: Icon(Icons.highlight_remove_outlined,color: Colors.red,)),
                         ),
                       ),
                     ),
                     Padding(
                       padding: const EdgeInsets.only(right: 10,left: 10),
                       child: TextFormField(
                         controller: phoneController,
                         onSaved: (e){
                           ProductData.phone=e;
                         },
                         validator: (e){
                           if(e!.isEmpty){
                             return 'Please enter your phone no. first...';
                           } else if(e.length<10 || e.length>10){
                              return 'Contact no. must be 10 digits...';
                           }
                           else{
                             return null;
                           }
                         },
                         keyboardType: TextInputType.number,
                         textInputAction: TextInputAction.next,
                         decoration: InputDecoration(
                           labelText: 'Phone',
                           hintText: ' Enter Your Phone no.',
                           prefixIcon: Icon(Icons.phone),
                           suffixIcon: IconButton(onPressed: (){
                             phoneController.clear();
                           }, icon: Icon(Icons.highlight_remove_outlined,color: Colors.red,)),
                         ),
                       ),
                     ),
                     Padding(
                       padding: const EdgeInsets.only(right: 10,left: 10),
                       child: TextFormField(
                       controller: addressController,
                         onSaved: (e){
                           ProductData.address=e;
                         },
                         validator: (e){
                           if(e!.isEmpty){
                             return 'Please enter your address first...';
                           }
                           else{
                             return null;
                           }
                         },
                         keyboardType: TextInputType.text,
                         textInputAction: TextInputAction.done,
                         maxLength: 50,
                         decoration: InputDecoration(
                           labelText: 'Address',
                           hintText: ' Enter Your Address',
                           prefixIcon: Icon(Icons.home),
                           suffixIcon: IconButton(onPressed: (){
                             addressController.clear();
                           }, icon: Icon(Icons.highlight_remove_outlined,color: Colors.red,)),
                         ),
                       ),
                     ),
                   ],
                 ),
               ),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(child: Text("SAVE"),onPressed: (){
                        if(formKey.currentState!.validate()){
                          formKey.currentState!.save();
                        }
                    }, ),

                    TextButton(child: Text('RESET'),onPressed: (){
                      formKey.currentState!.reset();

                      ProductData.name=null;
                      ProductData.email=null;
                      ProductData.address=null;
                      ProductData.phone=null;

                      nameController.clear();
                      emailController.clear();
                      addressController.clear();
                      phoneController.clear();
                    }, )
                  ],
                ),


              ],
            )

          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 63,
                      ),
                      Text(
                        'OUR MENU',
                        style: TextStyle(
                          letterSpacing: 5,
                          wordSpacing: 5,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Colors.pink,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: allFoods.map((e) {
                return InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(blurRadius: 8, offset: Offset(3, 5))
                        ],
                      ),
                      child: Column(
                        children: [
                          Expanded(
                              flex: 10,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            e['thumbnail']),
                                        fit: BoxFit.cover)),
                              )),
                          SizedBox(
                            height: 5,
                          ),
                          Expanded(
                            flex:4,
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        e['item'],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 23,
                                            letterSpacing: 2,
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w600),
                                      ),

                                      Container(
                                        alignment: Alignment.center,
                                        height: 30,
                                        width: 55,
                                        decoration: BoxDecoration(
                                          color: Colors.green.shade900,
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [

                                            Text(
                                              '${e['rating']} ',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                 // Text('-------------------------------------------------------'),
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(width: 35,),
                                      Text(
                                        'Pure Vage ~ ',
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(width: 10,),
                                      Text(
                                        ' ₹ ${e['price']}',
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(width: 60,),
                                      TextButton(
                                        onPressed: () {
                                          ProductData.cartList.add(e);
                                          setState(() {});
                                        },
                                        child: Text(
                                        'ADD',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 20
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
