import 'package:firebase_auth/firebase_auth.dart';
import 'package:raptor/core/errors/exceptions.dart';

abstract interface class AuthFirebaseDataSource {
  Future<String> signUpWithEmailPassword({
    required String email,
    required String password,
    required String name,
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
      { required String email,
        required String password,
        required String name,}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password).then((value) async{
         await firebaseAuth.currentUser?.updateDisplayName(name);
      });
      if(firebaseAuth.currentUser == null){
        throw ServerException('User is null');
      }
      return firebaseAuth.currentUser?.uid ?? '';
    } catch (e) {
      throw ServerException(e.toString());
      return '';
    }
  }
}
