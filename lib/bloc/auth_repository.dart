import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final _firebaseAuth =FirebaseAuth.instance;

  Future<void> signIn({required String email, required String password}) async{
      try{
        FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: password);
      }on FirebaseAuthException catch(e){
        if (e.code == 'invalid-email' || e.code == 'wrong-password') {
          // Xử lý lỗi email hoặc password không hợp lệ
          throw Exception(" email hoặc password không hợp lệ");
        } else if (e.code == 'user-not-found') {
          // Xử lý lỗi tài khoản không tồn tại
          throw Exception(" email hoặc password không hợp lệ");
        } else if (e.code == 'user-disabled') {
          // Xử lý lỗi tài khoản đã bị khóa hoặc vô hiệu hóa
          throw Exception(" email hoặc password không hợp lệ");
        } else if (e.code == 'operation-not-allowed' || e.code == 'internal-error') {
          // Xử lý các lỗi khác
          throw Exception(" email hoặc password không hợp lệ");
        }
      }catch(e){
        throw Exception(e.toString());
      }
  }
}