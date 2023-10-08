import 'package:flutter/material.dart';

void main() {
  runApp(LoginPage());
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Login Page'),
          backgroundColor: Colors.teal,
        ),
        body: Center(
          child: Container(
            width: screenWidth > 500 ? 500.0 : screenWidth,
            height: screenHeight > 500 ? 500.0 : screenHeight,
            child: Card(
              elevation: 15.0,
              child: LoginForm(),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Center(
            // Center the title text
            child: Text(
              'Login',
              style: TextStyle(
                fontSize: 28.0,
                color: Colors.green,
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 15.0),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 30.0),
          ElevatedButton(
            onPressed: () {
              // Add login logic here
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
            onPressed: () {
              // Add signup logic here
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
    );
  }
}
