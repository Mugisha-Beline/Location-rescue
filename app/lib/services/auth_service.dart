import 'package:app/helper/helper_function.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final String? uid;

  AuthService({this.uid});

  // Initialize Firebase
  static Future<void> initialize() async {
    await Firebase.initializeApp();
  }

  // Login with email and password
  Future<dynamic> loginWithUserNameAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      return user;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Google Sign-In
  Future<dynamic> googleSignInMethod() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

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

      UserCredential authResult = await _firebaseAuth.signInWithCredential(credential);
      User? user = authResult.user;

      return user;
    } catch (e) {
      return e.toString();
    }
  }

  // Register user with email and password
  Future<dynamic> registerUserWithEmailandPassword(
      String fullName, String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      // Call our database service to update the user data.
      await savingUserData(fullName, email);

      return user;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await HelperFunctions.saveUserLoggedInStatus(false);
      await HelperFunctions.saveUserEmailSF("");
      await HelperFunctions.saveUserNameSF("");
      await _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  // Saving user data method
  Future<void> savingUserData(String fullName, String email) async {
    try {
      // Implement your logic to save user data to the database
      // You can use this.uid to access the uid parameter
    } catch (e) {
      print(e.toString());
    }
  }
}
