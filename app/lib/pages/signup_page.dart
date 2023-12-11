// signup_page.dart
import 'package:flutter/material.dart';
import 'package:app/helper/helper_function.dart';
import 'package:app/services/auth_service.dart';

class SignupPage extends StatelessWidget {
  final AuthService authService;

  SignupPage({required this.authService, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Sign Up Page'),
          backgroundColor: Colors.teal,
        ),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width > 500 ? 500.0 : MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height > 500 ? 500.0 : MediaQuery.of(context).size.height,
            child: Card(
              elevation: 15.0,
              child: SignupForm(authService: authService),
            ),
          ),
        ),
      ),
    );
  }
}

class SignupForm extends StatefulWidget {
  final AuthService authService;

  const SignupForm({required this.authService, Key? key}) : super(key: key);

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _loading = false;

  _signUp() async {
    setState(() {
      _loading = true;
    });

    try {
      String fullName = _fullNameController.text.trim();
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      if (fullName.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
        dynamic result = await widget.authService.registerUserWithEmailandPassword(
          fullName,
          email,
          password,
        );

        if (result is bool && result) {
          // User registration successful
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(email);
          await HelperFunctions.saveUserNameSF(fullName);

          // Navigate to login page
          Navigator.pushReplacementNamed(context, '/login');
        } else {
          // Handle registration failure
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Registration failed. Please try again.'),
            duration: Duration(seconds: 2),
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please enter all the fields.'),
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      print('Error during signup: $e');
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Center(
            child: Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 28.0,
                color: Colors.green,
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            controller: _fullNameController,
            decoration: const InputDecoration(
              labelText: 'Full Name',
            ),
            keyboardType: TextInputType.name,
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 15.0),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 30.0),
          ElevatedButton(
            onPressed: _loading ? null : _signUp,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFe6aa07),
              minimumSize: const Size(double.infinity, 50.0),
              

            ),
            child: _loading ? const CircularProgressIndicator() : const Text('Sign Up'),
          ),
          const SizedBox(height: 20.0),
          const Text(
            'Already have an account?',
            style: TextStyle(
              color: Colors.teal,
            ),
          ),
          TextButton(
             onPressed: () async {
                await Navigator.of(context).pushReplacementNamed('/login');
              },
              child: const Text(
                'login ',
                style: TextStyle(
                  color: Colors.teal,
                ),
              ),
           
          ),
        ],
      ),
    );
  }
}
