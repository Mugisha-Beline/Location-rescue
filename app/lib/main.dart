
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:app/pages/home_page.dart' as HomePage;
import 'package:app/pages/description.dart';
import 'package:app/pages/maps.dart';
import 'package:app/pages/feedback_page.dart';
import 'package:app/services/auth_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'firebase_options.dart';
import 'pages/signup_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(authService: _authService),
        '/signup': (context) => SignupPage(authService: _authService),
        '/home': (context) => HomePage.HomeScreen(),
        '/description': (context) => DescriptionPage(
              province: 'Kigali City', // Replace with the actual province
              district: 'Gasabo', // Replace with the actual district
              category: 'Hotel', // Replace with the actual category
            ),
        '/map': (context) => MapPage(locationItems: []),
        '/feedback': (context) => FeedbackPage(),
      },
    );
  }
}

class LoginPage extends StatelessWidget {
  final AuthService authService;

  LoginPage({required this.authService, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width > 500
              ? 500.0
              : MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height > 500
              ? 500.0
              : MediaQuery.of(context).size.height,
          child: Card(
            elevation: 15.0,
            child: LoginForm(authService: authService),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  final AuthService authService;

  LoginForm({required this.authService, Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _key = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _key,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: () => AuthService().googleSignInMethod(),
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: const Color(0xFFe6aa07),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.login_sharp,
                          
                          size: 20,
                        ),
                        SizedBox(width: 10),
                        
                        ElevatedButton(
                          onPressed: () async {
                            if (_key.currentState!.validate()) {
                              GoogleSignIn.standard();
                              await Navigator.pushReplacementNamed(context, '/home');

                            }
                          },
                          child: Text(
                            "Sign in with Google",
                            style: TextStyle(
                              color: Colors.teal,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Email cannot be empty';
                }
                return null;
              },
            ),
            const SizedBox(height: 15.0),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Password cannot be empty';
                }
                return null;
              },
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () {
                if (_key.currentState!.validate()) {
                  signInUser();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFe6aa07),
                minimumSize: const Size(double.infinity, 50.0),
              ),
              child: const Text('Login'),
            ),
            const SizedBox(height: 10.0),
            TextButton(
              onPressed: () {
                print('forgot password');
                // Add forgot password logic here
              },
              child: const Text(
                'Forgot Password?',
                style: TextStyle(
                  color: Colors.teal,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Don\'t have an account?',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            TextButton(
              onPressed: () async {
                await Navigator.of(context).pushReplacementNamed('/signup');
              },
              child: const Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.teal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

 void signInUser() async {
  try {
    dynamic authResult = await widget.authService.loginWithUserNameandPassword(
        _emailController.text, _passwordController.text);
    if (authResult == null) {
      print('Sign in error. Could not be able to login');
    } else {
      _emailController.clear();
      _passwordController.clear();
      await Navigator.pushReplacementNamed(context, '/home');
    }
  } catch (e) {
    print('Error during sign-in: $e');
  }
}

void signInWithGoogle() async {
  try {
    dynamic authResult = await widget.authService.googleSignInMethod();
    if (authResult == null) {
      print('Google Sign-in error. Could not be able to login');
    } else {
      await Navigator.pushReplacementNamed(context, '/home');
    }
  } catch (e) {
    print('Error during Google sign-in: $e');
  }
}}