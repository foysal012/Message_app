import 'package:flutter/material.dart';

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
        child:Column(
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

              },

              child: Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.purple,
                ),
                child: Text("Reset",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}

