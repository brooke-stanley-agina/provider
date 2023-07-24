import 'package:flutter/material.dart';
import 'package:playground/models/play.dart';
import 'package:playground/providers/authentication_provider.dart';
import 'package:playground/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../utils/validators.dart';
import '../utils/widgets.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();

  String? _username, _password, _confirmPassword;

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    final usernameField = TextFormField(
      autofocus: false,
      validator: validateEmail,
      decoration: buildInputDecoration("Confirm Email", Icons.email),
      onSaved: (value) => _username = value,
    );

    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      validator: (value) => value!.isEmpty ? "Please enter password" : null,
      decoration: buildInputDecoration("Confirm Password", Icons.lock),
      onSaved: (value) => _password = value,
    );

    final confirmPassword = TextFormField(
      autofocus: false,
      obscureText: true,
      validator: (value) => value!.isEmpty ? "Please enter password" : null,
      decoration: buildInputDecoration("Confirm Password", Icons.lock),
      onSaved: (value) => _confirmPassword = value,
    );

    var loading = const Row(
      children: <Widget>[
        CircularProgressIndicator(),
        Text("Authenticating..... Please wait")
      ],
    );

    doRigester() {
      final form = formKey.currentState;
      if (form!.validate()) {
        form.save();
        auth
            .register(_username!, _password!, _confirmPassword!)
            .then((response) {
          if (response['status']) {
            User user = response['data'];
            Provider.of<UserProvider>(context, listen: false).setUser(user);
            Navigator.pushReplacementNamed(context, '');
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Failed to Register')));
          }
        });
      } else {
        print("form invalid");
      }
    }

    ;

    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: const EdgeInsets.all(40),
        child: Form(
            child: Column(
          children: [
            const SizedBox(height: 15),
            label("Email"),
            const SizedBox(height: 5),
            usernameField,
            const SizedBox(height: 5),
            label("Password"),
            passwordField,
            const SizedBox(height: 20),
            label("Confirm Password"),
            confirmPassword,
            const SizedBox(height: 20),
            auth.loggedInStatus == Status.Authenticating
                ? loading
                : longButtons("Register", doRigester),
          ],
        )),
      ),
    ));
  }
}
