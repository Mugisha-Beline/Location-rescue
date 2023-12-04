import 'package:app/helper/helper_function.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  final String? uid; // Add uid parameter

  AuthService({this.uid}); // Constructor

  // login
  Future loginWithUserNameandPassword(String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;

      return true;
        } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Google Sign-In
  Future googleSignInMethod() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount == null) {
        // The user canceled the sign-in process
        return null;
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult =
          await firebaseAuth.signInWithCredential(credential);
      final User? user = authResult.user;

      return user;
    } catch (e) {
      return e.toString();
    }
  }

  // register
  Future registerUserWithEmailandPassword(
      String fullName, String email, String password) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;

      // call our database service to update the user data.
      await savingUserData(fullName, email);
      return true;
        } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // signout
  Future signOut() async {
    try {
      await HelperFunctions.saveUserLoggedInStatus(false);
      await HelperFunctions.saveUserEmailSF("");
      await HelperFunctions.saveUserNameSF("");
      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }

  // savingUserData method
  Future<void> savingUserData(String fullName, String email) async {
    try {
      // Implement your logic to save user data to the database
      // You can use this.uid to access the uid parameter

    } catch (e) {
      print(e.toString());
    }
  }
}
