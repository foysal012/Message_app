import 'package:flutter/material.dart';
import 'package:message_app/screen/authentication/sign_in_page_screen.dart';
import 'package:message_app/services/auth/auth_services.dart';
import 'package:provider/provider.dart';

class SignUpPageScreen extends StatefulWidget {
  const SignUpPageScreen({Key? key}) : super(key: key);

  @override
  State<SignUpPageScreen> createState() => _SignUpPageScreenState();
}

class _SignUpPageScreenState extends State<SignUpPageScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey();

  bool obsecureText = true;

  void signUp() async{


    if(passwordController.text != confirmPasswordController.text){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("password do not match"),),);
      return ;
    }

    final authServices = Provider.of<AuthServices>(context, listen: false);

    try{

      await authServices.signUpWithEmailandPassword(
          emailController.text,
          passwordController.text,
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
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,

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

                  hintText: "Enter password...",

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

            TextFormField(
              controller: confirmPasswordController,
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

                  hintText: "Enter confirm password...",

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
                //Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignInPageScreen()));
                signUp();
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignInPageScreen()));
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Signup Successfully")));
              },

              child: Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.purple,
                ),
                child: Center(
                  child: Text("Sign Up",
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

                Text("Already have an account?"),

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
