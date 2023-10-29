import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:message_app/model/message_model.dart';

class MessageServices with ChangeNotifier{

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

 final  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // send message
  Future<void> sendMessage(String receiverId, String message) async{

    //current user info
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    //create a new message
    MessageModel newMessage = MessageModel(
        senderId: currentUserId,
        senderEmail: currentUserEmail,
        receiverId: receiverId,
        message: message,
        timestamp: timestamp);

    //constact chat room id from current user id and receiver id(sorted to ensure uniqueness)
      List<String> ids = [currentUserId, receiverId];

      //sort the ids (this ensures the message Details Id is always the same for any pair of people)
      ids.sort();
      
      String messageDetailsId = ids.join("_");
      
    //add new message to database
    await _firebaseFirestore.collection("messageDetails").doc(messageDetailsId).collection("messages").add(newMessage.toMap());


  }


  //get message
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId){

    // construct message Details Id from user ids (sorted to ensure it matches the is used when sending message))
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String messageDetailsId = ids.join("_");

    return _firebaseFirestore.collection("messageDetails").doc(messageDetailsId).collection("messages").orderBy("timestamp", descending: false).snapshots();
  }



}