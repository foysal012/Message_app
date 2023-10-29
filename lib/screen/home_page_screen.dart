import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:message_app/screen/message_details.dart';
import 'package:message_app/services/auth/auth_services.dart';
import 'package:provider/provider.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

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
          backgroundColor: Colors.purple,
          leading: Icon(Icons.menu, color: Colors.white,),
          centerTitle: true,
          title: Text("HomePage",
          style: TextStyle(
            color: Colors.white
          ),
          ),

          actions: [
            IconButton(
                onPressed: (){
              signOut();
            },
                icon: Icon(Icons.logout, color: Colors.white,)
            )
          ],
        ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList(){
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (context, snapshot){
          if(snapshot.data == null){
            return Text("No data Found");
          } else if(snapshot.hasError){
            return Text("Something went Wrong");
          } else if(snapshot.connectionState == ConnectionState.waiting){
            return Text("Loading....");
          }
          return ListView(
            children: snapshot.data!.docs.map<Widget>((e) => _buildUserListItem(e)).toList(),
          );
        }
        );
  }


  // build individual user list items

  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    // display all users except current user
    if(_firebaseAuth.currentUser!.email != data["email"]){
      return ListTile(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => MessageDetails(
            receiverUserEmail: data["email"],
            receiverUserId: data["uid"],
          )));
        },
        title: Text(data["email"],
        style: TextStyle(
          color: Colors.purple,
        ),
        ),

      );
    } else {
      return Container();
    }
  }
}
