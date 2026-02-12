import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDocumentService {
  DocumentReference get userDocRef {
    final uid = currentUid;
    return FirebaseFirestore.instance.collection('users').doc(uid);
  }

  String get currentUid => FirebaseAuth.instance.currentUser!.uid;

  String? get currentEmail => FirebaseAuth.instance.currentUser?.email;

  User? get currentUser => FirebaseAuth.instance.currentUser;

  Future<void> ensureUserDocument() async {
    final doc = await userDocRef.get();
    if (!doc.exists) {
      await userDocRef.set({
        'name': '',
        'email': currentEmail ?? '',
        'phone': '',
        'birthday': null,
        'favoriteIds': <String>[],
      });
    }
  }
}
