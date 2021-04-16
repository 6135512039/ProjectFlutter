import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectflutter/models/Transactions.dart';
import 'package:projectflutter/providers/transaction_provider.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';



class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final formKey = GlobalKey<FormState>();

  // controller
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final telController = TextEditingController();
  final addressController = TextEditingController();
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<TransactionProvider>(context,listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
        appBar: AppBar(
          title: Text("Contact App"),
          actions: [
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  var name;
                  var email;
                  var tel;
                  var address;
                  //เตรียมข้อมูล
                  Transactions statement = Transactions(

                      name : name,
                      email: email,
                      tel: tel,
                      address: address

                  );//object

                  //เรียก Provider
                  var provider = Provider.of<TransactionProvider>(context,listen:false);
                  provider.deleteTransaction(statement);
                  Navigator.push(context, MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context){
                        return HomeScreen();
                      }));
                }),
            IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                }),


          ],
        ),
        body: Consumer(
          builder: (context, TransactionProvider provider, Widget child) {
            var count = provider.transactions.length; //นับจำนวนข้อมูล
            if (count <= 0) {
              return Center(
                child: Text(
                  "No Data",
                  style: TextStyle(fontSize: 35),
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: count,
                  itemBuilder: (context, int index) {
                    Transactions data = provider.transactions[index];
                    return Card(
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 5
                      ),

                      child: ListTile(
                        title: Text(
                            "Name: ${data.name}\nEmail: ${data.email}\nTel: ${data.tel}\nAddress: ${data.address}\n"
                        ),

                      ),
                    );
                  });

            }
          },
        )
   );
  }
}