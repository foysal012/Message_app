import 'dart:math' as math;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:message_app/screen/authentication/sign_in_page_screen.dart';
import 'package:message_app/services/auth/auth_gate.dart';

class SpalashScreen extends StatefulWidget {
  const SpalashScreen({Key? key}) : super(key: key);

  @override
  State<SpalashScreen> createState() => _SpalashScreenState();
}

class _SpalashScreenState extends State<SpalashScreen> with SingleTickerProviderStateMixin {

  late AnimationController _animationController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this)..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(seconds: 3),(){
      //Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SignInPageScreen()));
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AuthGate()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          SizedBox(height: MediaQuery.of(context).size.height * 0.1,),




          AnimatedBuilder(
            animation: _animationController,
            child: Stack(
              children: [
                Transform.rotate(
                  // alignment: Alignment.topCenter,
                  angle: pi/4,
                  child: Container(
                    height: 250,
                    width: 250,
                    decoration: BoxDecoration(
                       // color: Colors.purple,
                      image: DecorationImage(image: AssetImage("images/w1.png"),fit: BoxFit.cover,),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(60),
                            bottomLeft: Radius.circular(60),
                            topRight: Radius.circular(60),
                            topLeft: Radius.circular(60)
                        )
                    ),
                  ),
                ),
    //             Positioned(
    //               top: 100,
    //               right: 50,
    //               left: 50,
    //               child:
    //
    //                   Container(
    //                   decoration: BoxDecoration(
    //                     image: DecorationImage(image: AssetImage("images/w1.png"),fit: BoxFit.cover,)
    //                   ),
    // ),
    //
    //               // Center(
    //               //   child: Image(image: AssetImage("images/w1.png"),fit: BoxFit.cover,)
    //               //   // Text("Message App",
    //               //   //   style: TextStyle(
    //               //   //     fontWeight: FontWeight.bold,
    //               //   //     fontSize: 22,
    //               //   //     color: Colors.white,
    //               //   //   ),
    //               //   // ),
    //               // ),
    //
    //             )
              ],
            ),
            builder: (BuildContext context, Widget? child){
              return Transform.rotate(
                angle: _animationController.value * 3.0 * math.pi,
                child: child,
              );
            }
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.2,),

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
          SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
          Container(
            alignment: Alignment.bottomCenter,
            child: Text("Developed by Foysal Joarder",
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
