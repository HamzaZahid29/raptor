import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthFirebaseDataSource {
  Future<String> signUpWithEmailPassword({
    required String email,
    required String password,
  });

  Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthFirebaseDataSourceImpl extends AuthFirebaseDataSource {
  final FirebaseAuth firebaseAuth;

  AuthFirebaseDataSourceImpl(this.firebaseAuth);

  @override
  Future<String> loginWithEmailPassword(
      {required String email, required String password}) async {
    throw UnimplementedError();
  }

  @override
  Future<String> signUpWithEmailPassword(
      {required String email, required String password}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return firebaseAuth.currentUser?.uid ?? '';
    } catch (e) {

      return '';
    }
  }
}
