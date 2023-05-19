import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future deleteFavourite(int i,List<dynamic> items) async {
    return await FirebaseFirestore.instance
        .collection('favorite')
        .doc(FirebaseAuth.instance.currentUser! .email) // replace with the actual document ID of the user
        .collection('items')
        .where('name',isEqualTo: items[i] ['name']) // replace with the actual name of the item
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();

        // delete the document reference
      });
    });
  }


  Future addToFavourite(int i,List<dynamic> items) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("favorite");
    return await _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc()
        .set({
      "name": items[i]['name'],
      "price": items[i]['price'],
      "images": items[i]['url'],
      "uid": items[i]['uid'],
      "description":items[i]['description'],
      "category":items[i]['category'],
    }).then((value) {
      print("Added to favourite");
    });
  }

