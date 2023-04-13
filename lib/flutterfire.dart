import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<String> register(String email, String password, String name) async {
  try {
    UserCredential result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    FirebaseAuth.instance.currentUser!;
    User use = result.user!;
    if (!use.emailVerified) {
      var actionCodeSettings = ActionCodeSettings(
        url: 'https://productin-b70f8.firebaseapp.com/',
        dynamicLinkDomain: 'https://productin-b70f8.firebaseapp.com/',
        androidPackageName: 'com.example.my_first_app',
        androidInstallApp: true,
        //  androidMinimumVersion: '10',
        //   iOSBundleId: 'com.example.ios',
        handleCodeInApp: true,
      );

      await use.sendEmailVerification();
    }
    use.updateDisplayName(name);
    String fac = use.uid;
    FirebaseFirestore.instance
        .collection('Auth_Users')
        .doc(fac)
        .set({'name': name, 'uid': fac, 'follow': [], 'photourl': ''});
    return "True";
  } catch (e) {
    // print(e.toString());
    return e.toString();
  }
}

Future<String> signin(String email, String password, String name) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    if (!FirebaseAuth.instance.currentUser!.emailVerified) {
      FirebaseAuth.instance.signOut();
      return "False";
    }
    return "True";
  } catch (e) {
    return e.toString();
  }
}

Future<void> Follow(String uid) async {
  String fac = FirebaseAuth.instance.currentUser!.uid;
  FirebaseFirestore.instance.collection('Auth_Users').doc(uid).update({
    'follow': FieldValue.arrayUnion([fac])
  });
}

Future<bool> update_profile(String a, String b, String c, String d) async {
  String fac = FirebaseAuth.instance.currentUser!.uid;

  DocumentReference users_data_1 =
      FirebaseFirestore.instance.collection('Users_data').doc(fac);
  try {
    users_data_1
        .set({'Github': d, 'Codechef': c, 'Leetcode': b, 'Linkedin': a});
    return true;
  } catch (e) {
    return false;
  }
}

// Future<bool>liked(var doc){

//   return false;
// }
Future<bool> photo(String url) async {
  try {
    String fac = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection('Auth_Users')
        .doc(fac)
        .update({'photourl': url});
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> contribute(String id, String amount, String title_text,
    String summary, List images) async {
  var months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "June",
    "July",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  var mon = new DateTime.now().month;
  var time = months[mon - 1] +
      " " +
      DateTime.now().day.toString() +
      "/" +
      DateTime.now().year.toString();
  var timestamp = DateTime.now().toString();

  String name = FirebaseAuth.instance.currentUser!.displayName!;
  String fac = FirebaseAuth.instance.currentUser!.uid;
  DocumentReference users =
      FirebaseFirestore.instance.collection('Users').doc(name + timestamp);
  DocumentReference users1 = FirebaseFirestore.instance
      .collection('Contributed')
      .doc(fac)
      .collection(fac)
      .doc(name + timestamp);
  ;
  DocumentReference users2 = FirebaseFirestore.instance
      .collection('Users_data')
      .doc(id)
      .collection(id)
      .doc(name + timestamp);

  try {
    users.set({
      'text': amount,
      'user': name,
      'timestamp': timestamp,
      'format': time,
      'summary': summary,
      'titletext': title_text,
      'title': id,
      'liked': [],
      'imageurl': images,
      'contributed': fac
    });
    users1.set({
      'text': amount,
      'user': name,
      'timestamp': timestamp,
      'format': time,
      'summary': summary,
      'titletext': title_text,
      'title': id,
      'liked': [],
      'imageurl': images,
      'contributed': fac
    });
    users2.set({
      'text': amount,
      'user': name,
      'timestamp': timestamp,
      'format': time,
      'summary': summary,
      'titletext': title_text,
      'title': id,
      'liked': [],
      'imageurl': images,
      'contributed': fac
    });
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> liked(DocumentSnapshot document) async {
  var timestamp = DateTime.now().toString();
  Map<String, dynamic> data = document.data() as Map<String, dynamic>;
  data['liked'] = timestamp;
  String name = FirebaseAuth.instance.currentUser!.displayName!;
  String fac = FirebaseAuth.instance.currentUser!.uid;
  DocumentReference users1 = FirebaseFirestore.instance
      .collection('Contributed')
      .doc(fac)
      .collection(fac)
      .doc(document['user'] + document['timestamp']);
  ;
  DocumentReference users_data_2 = FirebaseFirestore.instance
      .collection('Users_data')
      .doc(document['title'])
      .collection(document['title'])
      .doc(document['user'] + document['timestamp']);
  DocumentReference users_data_3 = FirebaseFirestore.instance
      .collection('Users')
      .doc(document['user'] + document['timestamp']);
  DocumentReference usersliked = FirebaseFirestore.instance
      .collection('Users_liked')
      .doc(fac)
      .collection(fac)
      .doc(document['user'] + document['timestamp']);

  try {
    users_data_2.update({
      'liked': FieldValue.arrayUnion([fac])
    });
    users_data_3.update({
      'liked': FieldValue.arrayUnion([fac])
    });
    users1.update({
      'liked': FieldValue.arrayUnion([fac])
    });
    usersliked.set(data);
    return true;
  } catch (e) {
    return false;
  }
}

/*
try {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    var timestamp = new DateTime.now();

    var value = double.parse(amount);
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Articles')
        .doc(id);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      if (!snapshot.exists) {
        documentReference.set({'Amount': value, 'timestamp': timestamp});
        return true;
      }
      return true;
    });
    return true;
  } catch (e) {
    return false;
  }
  */

void logout() {
  FirebaseAuth.instance.signOut();
  FirebaseAuth.instance.currentUser!.delete();
}
