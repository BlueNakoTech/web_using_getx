import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class RulesController extends GetxController {

  FirebaseFirestore firestore = FirebaseFirestore.instance;  

  Future<QuerySnapshot<Object?>>getData()  {

    CollectionReference rules = firestore.collection('Rules');

    return rules.get();


  }


}
