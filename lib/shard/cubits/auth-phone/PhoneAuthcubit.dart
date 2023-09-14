import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ys/shard/cubits/auth-phone/PhoneAuthstate.dart';

class AuthCubit extends Cubit<AuthStates> {
  late String verifiactionId;
  AuthCubit() : super(AuthInitialState());


  static AuthCubit get(context) => BlocProvider.of(context);

  Future<void> submitPhoneNumber(String phoneNumber) async {
    emit(loading());
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+967$phoneNumber',
      timeout: const Duration(seconds:30),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  void verificationCompleted(PhoneAuthCredential credential) async {
    print("verifcation completed");
    await signIn(credential);
  }

  void verificationFailed(FirebaseAuthException error) {
    emit(ErrorOccurred(errorMsg: error.toString()));
    print("......................................faild : ${error.toString()}");
  }

  // to know code is send
  void codeSent(String verifiactionId, int? resendToken) {
    this.verifiactionId = verifiactionId;
    emit(PhoneNumSub());
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    print("      codeAutoRetrievalTimeout");
  }

  // to verify the code you get
  Future<void> submitOtp(String otpCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: this.verifiactionId, smsCode: otpCode);
    await signIn(credential);
  }

  // login fun
  Future<void> signIn(PhoneAuthCredential credential) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(PhoneOtpVerify());
    } catch (error) {
      emit(ErrorOccurred(errorMsg: error.toString()));
    }
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  // User is function from Firebase
  User getLoggedInUser() {
    User firebaseUser =  FirebaseAuth.instance.currentUser!;

    return firebaseUser;
  }
}
