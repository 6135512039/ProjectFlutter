import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectflutter/models/Transactions.dart';
import 'package:projectflutter/providers/transaction_provider.dart';
import 'package:projectflutter/widgets/custom_btn.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import 'home_page.dart';

class FormScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  // controller 
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final telController = TextEditingController();
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Contact Form"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: new InputDecoration(labelText: "Name - Surname"),
                    autofocus: false,
                    controller: nameController,
                    validator: (String str){
                        if(str.isEmpty){
                            return "Please Enter Name - Surname";
                        }
                        return null;
                    },

                  ),
                  TextFormField(
                    decoration: new InputDecoration(labelText: "Email"),
                    autofocus: false,
                    controller: emailController,
                    validator: (String str){
                      if(str.isEmpty){
                        return "Please Enter Email";
                      }
                      return null;
                    },

                  ),
                  TextFormField(
                    decoration: new InputDecoration(labelText: "Telephone"),
                    autofocus: false,
                    controller: telController,
                    keyboardType: TextInputType.number,
                    validator: (String str){
                      if(str.isEmpty){
                        return "Please Enter Telephone Number";
                      }
                      return null;
                    },

                  ),
                  TextFormField(
                    decoration: new InputDecoration(labelText: "Address"),
                    autofocus: false,
                    controller: addressController,
                    validator: (String str){
                      if(str.isEmpty){
                        return "Please Enter Address";
                      }
                      return null;
                    },

                  ),
                  FlatButton(
                    child: CustomBtn(
                      text: "Create New Contact",
                      onPressed: (){
                        if(formKey.currentState.validate()){
                            var name = nameController.text;
                            var email = emailController.text;
                            var tel = telController.text;
                            var address = addressController.text;
                            //เตรียมข้อมูล
                            Transactions statement = Transactions(

                                name : name,
                                email: email,
                                tel: tel,
                                address: address

                            );//object

                            //เรียก Provider
                            var provider = Provider.of<TransactionProvider>(context,listen:false);
                            provider.addTransaction(statement);
                            Navigator.push(context, MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (context){
                                return MyHomePage();
                            }));
                        }
                      },
                    ),
                  ),
                  FlatButton(
                    child: CustomBtn(
                      text: "Sign Out Contact App",
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
