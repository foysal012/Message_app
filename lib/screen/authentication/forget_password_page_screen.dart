import 'package:flutter/material.dart';
import 'package:message_app/screen/authentication/sign_in_page_screen.dart';

class ForgetPasswordPageScreen extends StatefulWidget {
  const ForgetPasswordPageScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPageScreen> createState() => _ForgetPasswordPageScreenState();
}

class _ForgetPasswordPageScreenState extends State<ForgetPasswordPageScreen> {

  TextEditingController emailController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [

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

            InkWell(
              onTap: (){
                //Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpPageScreen()));
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sent a rest link in your email")));
              },

              child: Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.purple,
                ),
                child: Center(
                  child: Text("Reset",
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text("Remember password?"),

                SizedBox(width: 10,),

                InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignInPageScreen()));
                  },
                  child: Text("Sign In",
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
    );
  }
}

