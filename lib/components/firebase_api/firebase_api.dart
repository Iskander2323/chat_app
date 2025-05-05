import 'dart:developer';

import 'package:chat_app/components/data/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseApi {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  Future<UserCredential> register({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _firebaseFirestore
          .collection('users')
          .doc(userCredential.user?.uid)
          .set({'email': email, 'createdAt': DateTime.now()});
      log('User registered successfully', name: 'FIREBASE AUTH');

      return userCredential;
    } on Exception catch (e) {
      log(e.toString(), name: 'SIGNUP EXCEPTION');
      rethrow;
    }
  }

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return user;
    } on Exception catch (e) {
      log(e.toString(), name: 'LOGIN EXCEPTION');
      rethrow;
    }
  }

  Future<List<UserModel>> getUsers() async {
    try {
      final users = await _firebaseFirestore.collection('users').get();
      final userList =
          users.docs.map((doc) {
            return UserModel.fromJson(doc.data());
          }).toList();
      return userList;
    } on Exception catch (e) {
      log(e.toString(), name: 'GET USERS EXCEPTION');
      rethrow;
    }
  }

  // Future<UserCredential?> signInWithGoogle() async {
  //   try {
  //     final googleUser = await GoogleSignIn().signIn();
  //     final googleAuth = await googleUser?.authentication;
  //     final credentials = GoogleAuthProvider.credential(
  //       idToken: googleAuth?.idToken,
  //       accessToken: googleAuth?.accessToken,
  //     );
  //     final user = await _firebaseAuth.signInWithCredential(credentials);
  //     return user;
  //   } catch (e) {
  //     log(e.toString());
  //     throw FirebaseAuthException(code: e.toString());
  //   }
  // }

  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
      log('User logged out successfully', name: 'FIREBASE AUTH');
    } on Exception catch (e) {
      log('Logout failed: $e', name: 'FIREBASE AUTH');
      rethrow;
    }
  }
}
