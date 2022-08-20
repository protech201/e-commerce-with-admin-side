
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/userModel.dart';

class UserFirestoreHelper{
  UserFirestoreHelper._();
  static UserFirestoreHelper firestoreHelper = UserFirestoreHelper._();

  //خاص بال User
  CollectionReference<Map<String, dynamic>> firestoreinstance = FirebaseFirestore.instance.collection("users");
  addUserToFirestore(UserModel UserModel)async{
     await firestoreinstance.doc(UserModel.id).set(UserModel.toMap());
  }
  Future<UserModel> getUserFromFirestore(String id)async{
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await firestoreinstance.doc(id).get();
    Map<String, dynamic>? dataMap = documentSnapshot.data();
    return UserModel.fromeMap(dataMap!);

  }
  Future<List<UserModel>>   getAllUserFromFirestore1()async{
    QuerySnapshot<Map<String, dynamic>> documentSnapshots = await firestoreinstance.get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> data = documentSnapshots.docs;
    List<Map<String, dynamic>> listData =  data.map((e) => e.data()).toList();
    print(listData);
    UserModel userModel = UserModel.fromeMap(listData[0]);
    List<UserModel> users = List<UserModel>.filled(listData.length, userModel);
    for(int i = 0;i<listData.length;i++){
     users[i]  =  UserModel.fromeMap(listData[i]) ;
     print(users[i].toMap());
    }

   return users;


  }
  Future<List> getAllUserFromFirestore2()async{
    QuerySnapshot<Map<String, dynamic>> documentSnapshots = await firestoreinstance.get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> data = documentSnapshots.docs;
    List<Map<String, dynamic>> listData =  data.map((e) => e.data()).toList();

    Map<int,dynamic> mapuser = Map();

    for(int i = 0;i<listData.length;i++){
      mapuser[i] = {i, UserModel.fromeMap(listData[0])};
    }

    List users = mapuser.values.toList();
    return users;
  }

  upDateImage(UserModel userModel)async{
    await firestoreinstance.doc(userModel.id).update(userModel.toMap());
  }

  upDateUser(UserModel userModel)async{
    await firestoreinstance.doc(userModel.id).update(userModel.toMap());

  }

  








}