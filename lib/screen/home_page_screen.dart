import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:message_app/services/auth/auth_services.dart';
import 'package:provider/provider.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {

  void signOut() async{
    final authServices = Provider.of<AuthServices>(context, listen: false);

    try{
      await authServices.signOut();

    } catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${e.toString()}"),),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("HomePage"),

          actions: [
            IconButton(
                onPressed: (){
              signOut();
            },
                icon: Icon(Icons.logout)
            )
          ],
        ),
      body: Container(
        color: Colors.pink,
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
