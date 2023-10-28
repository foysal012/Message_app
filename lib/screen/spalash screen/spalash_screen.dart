import 'package:flutter/material.dart';
import 'package:message_app/screen/authentication/sign_in_page_screen.dart';
import 'package:message_app/services/auth/auth_gate.dart';

class SpalashScreen extends StatefulWidget {
  const SpalashScreen({Key? key}) : super(key: key);

  @override
  State<SpalashScreen> createState() => _SpalashScreenState();
}

class _SpalashScreenState extends State<SpalashScreen> {


  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(seconds: 2),(){
      //Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SignInPageScreen()));
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AuthGate()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [

          SizedBox(height: MediaQuery.of(context).size.height * 0.4,),


          Container(
            alignment: Alignment.center,
            child: Text("Message App",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.purple
            ),
            ),
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.4,),


          Container(
            alignment: Alignment.bottomCenter,
            child: Text("Powered by Neuflo Solutions",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple
              ),
            ),
          ),
        ],
      ),
    );
  }
}
