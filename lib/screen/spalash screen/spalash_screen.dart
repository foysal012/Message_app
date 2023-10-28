import 'package:flutter/material.dart';
import 'package:message_app/screen/authentication/sign_in_page_screen.dart';

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
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SignInPageScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          Container(
            alignment: Alignment.center,
            child: Text("Message App",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.pink
            ),
            ),
          ),


          Container(
            alignment: Alignment.bottomCenter,
            child: Text("Sponsored by Neuflo Solutions",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink
              ),
            ),
          ),
        ],
      ),
    );
  }
}
