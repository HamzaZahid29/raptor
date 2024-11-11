import 'package:firebase_auth/firebase_auth.dart';
import 'package:raptor/core/errors/exceptions.dart';
import 'package:raptor/features/auth/data/models/user_model.dart';

abstract interface class AuthFirebaseDataSource {
  Future<UserModel> signUpWithEmailPassword({
    required String email,
    required String password,
    required String name,
  });

  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthFirebaseDataSourceImpl extends AuthFirebaseDataSource {
  final FirebaseAuth firebaseAuth;

  AuthFirebaseDataSourceImpl(this.firebaseAuth);

  @override
  Future<UserModel> loginWithEmailPassword(
      {required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (firebaseAuth.currentUser == null) {
        throw ServerException('User is null');
      }
      return UserModel(
          firebaseAuth.currentUser?.uid ?? '',
          firebaseAuth.currentUser?.email ?? '',
          firebaseAuth.currentUser?.displayName ?? '');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        await firebaseAuth.currentUser?.updateDisplayName(name);
      });
      if (firebaseAuth.currentUser == null) {
        throw ServerException('User is null');
      }
      return UserModel(
          firebaseAuth.currentUser?.uid ?? '',
          firebaseAuth.currentUser?.email ?? '',
          firebaseAuth.currentUser?.displayName ?? '');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
