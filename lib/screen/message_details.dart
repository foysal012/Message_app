import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:message_app/services/message/message_services.dart';

class MessageDetails extends StatefulWidget {
   MessageDetails({Key? key, required this.receiverUserId, required this.receiverUserEmail}) : super(key: key);

  final String receiverUserEmail;
  final String receiverUserId;
  @override
  State<MessageDetails> createState() => _MessageDetailsState();
}

class _MessageDetailsState extends State<MessageDetails> {

  final TextEditingController messageController = TextEditingController();
  final MessageServices messageServices = MessageServices();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async{
    if(messageController.text.toString().isNotEmpty){
      await messageServices.sendMessage(widget.receiverUserId, messageController.text);
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: Text("${widget.receiverUserEmail.toString()}"),
      ),

      body: Column(
        children: [

          //message
          Expanded(
              child: _buildMessageList(),
          ),

          // user input
          _buildMessageInput(),

          SizedBox(height: 10,),
        ],
      ),

    );
  }
  //build message list
  Widget _buildMessageList() {
    return StreamBuilder(
        stream: messageServices.getMessages(widget.receiverUserId, _firebaseAuth.currentUser!.uid),
        builder: (context, snapshot){
          if(snapshot.hasError){
            return Text("Something error");
          } else if(snapshot.data == null){
            return Text("No Data Found");
          } else if(snapshot.connectionState == ConnectionState.waiting){
            return Text("Loading...");
          }
          return ListView(
            children: snapshot.data!.docs.map((document) => _buildMessageItem(document)).toList(),
          );
        }
    );
  }


  //build message item
  Widget _buildMessageItem(DocumentSnapshot document){
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    //align the message to the right side if the send is current user, otherwise to the left side
    var alignment = (data["senderId"] == _firebaseAuth.currentUser!.uid) ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(

          children: [
            Text(data["senderEmail"],
              style: TextStyle(
                  color: Colors.purple,
                  fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),

            SizedBox(height: 8,),

            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 300,
                maxWidth: 200,
              ),
              child: Container(
                  padding: EdgeInsets.only(
                    left: 3,
                    right: 3,
                    top: 3,
                    bottom: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: (data["senderId"] == _firebaseAuth.currentUser!.uid) ?
                    BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                      //bottomRight: Radius.circular(12),
                    ) :

                    BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                      //bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),

                  ),
                  child: Text(data["message"],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16
                  ),
                  ),
              ),
            ),

            SizedBox(height: 5,),

            //Text(data["timestamp"].toDate().toString()),

           Text(
               // "${Jiffy.parseFromDateTime(data["timestamp"].toDate()).year.toString() as String}"
               //     + " : " +
               //     "${Jiffy.parseFromDateTime(data["timestamp"].toDate()).month.toString() as String}"
               //     + " : " +
               //     "${Jiffy.parseFromDateTime(data["timestamp"].toDate()).date.toString() as String}"
               //     + " , " +
               //     "${Jiffy.parseFromDateTime(data["timestamp"].toDate()).hour.toString() as String}"
               //     + " : " +
               //     "${Jiffy.parseFromDateTime(data["timestamp"].toDate()).minute.toString() as String}"
               //     + " : " +
               //     "${Jiffy.parseFromDateTime(data["timestamp"].toDate()).second.toString() as String}"
               //         + "  " +
                       "${Jiffy.parseFromDateTime(data["timestamp"].toDate()).yMMMMdjm.toString() as String}"
           ),


          ],
        ),
      ),
    );
  }

  //build message input
 Widget _buildMessageInput(){

    return Row(

      children: [

        Expanded(

            child: TextFormField(

              controller: messageController,
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

                hintText: "Write something here...",

                //prefixIcon: Icon(Icons.email_outlined, color: Colors.purple,),
              ),

            ),
        ),

        IconButton(
            // onPressed: (){
            //   sendMessage();
            // },
          onPressed: sendMessage,
            icon: Icon(Icons.send, color: Colors.purple, size: 40,)
        )
      ],
    );
 }

}
