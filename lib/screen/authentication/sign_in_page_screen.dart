import 'dart:math';

import 'package:flutter/material.dart';
import 'package:message_app/screen/authentication/forget_password_page_screen.dart';
import 'package:message_app/screen/authentication/sign_up_page_screen.dart';
import 'package:message_app/services/auth/auth_services.dart';
import 'package:provider/provider.dart';

class SignInPageScreen extends StatefulWidget {
  const SignInPageScreen({Key? key}) : super(key: key);

  @override
  State<SignInPageScreen> createState() => _SignInPageScreenState();
}

class _SignInPageScreenState extends State<SignInPageScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey();

  bool obsecureText = true;

  void signIn()async{

    final firebaseAuth = Provider.of<AuthServices>(context, listen: false);

    try{
     await firebaseAuth.SignInWithEmailandPassword(
         emailController.text,
         passwordController.text
     );
    } catch (e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${e.toString()}"),),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        child:SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              //SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
              Stack(
                children: [
                  Transform.rotate(
                    // alignment: Alignment.topCenter,
                    angle: pi/4,
                    child: Container(
                      height: 250,
                      width: 250,
                      decoration: BoxDecoration(
                          color: Colors.purple,
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

                  Positioned(
                    top: 100,
                    right: 50,
                    left: 50,
                    child: Center(
                      child: Text("Message App",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                    ),)
                ],
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.04,),


              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value){
                  if(value!.isEmpty){
                    return "Your email field is empty";
                  } else if(value.length > 50){
                    return "Too large";
                  } else if(value.length < 18){
                    return "Too small";
                  } else if(!value.endsWith("@gmail.com")){
                    return "Invalid email";
                  }
                },

                decoration: InputDecoration(

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Colors.purple,
                      width: 3,
                    ),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Colors.purple,
                      width: 3,
                    ),
                  ),

                  hintText: "Enter your email...",

                  prefixIcon: Icon(Icons.email_outlined, color: Colors.purple,),
                ),

              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.02,),

              TextFormField(
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: obsecureText,
                obscuringCharacter: "*",
                validator: (value){
                  if(value!.isEmpty){
                    return "Your passwrd field is empty";
                  } else if(value.length > 20){
                    return "Too large";
                  } else if(value.length < 8){
                    return "Too small";
                  }
                },

                decoration: InputDecoration(

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Colors.purple,
                      width: 3,
                    ),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Colors.purple,
                      width: 3,
                    ),
                  ),

                  hintText: "Enter your password...",

                  prefixIcon: Icon(Icons.key, color: Colors.purple,),

                  suffixIcon: IconButton(
                    onPressed: (){
                      setState(() {
                        obsecureText = !obsecureText;
                      });
                    },
                    icon: Icon(obsecureText == true ? Icons.visibility_off : Icons.visibility),
                  )
                ),

              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.02,),

              InkWell(
                onTap: (){
                  //Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpPageScreen()));
                  signIn();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Signin Successfully")));
                },

                child: Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.purple,
                  ),
                  child: Center(
                    child: Text("Sign In",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.05,),

              Row(
                children: [

                  Text("Forget Password?"),

                  SizedBox(width: 10,),

                  InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgetPasswordPageScreen()));
                    },
                    child: Text("Click here",
                    style: TextStyle(
                      color: Colors.purple
                    ),
                    ),
                  )
                ],
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.02,),

              Row(
                children: [

                  Text("Don't have an account?"),

                  SizedBox(width: 10,),

                  InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpPageScreen()));
                    },
                    child: Text("Sign Up",
                      style: TextStyle(
                          color: Colors.purple
                      ),
                    ),
                  )
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
