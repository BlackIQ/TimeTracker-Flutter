import 'package:flutter/material.dart';
import 'package:flutter_time_tracker/app/services/flutterfire.dart';
import 'package:flutter_time_tracker/app/widgets/w-button.dart';
import 'package:flutter_time_tracker/app/widgets/w-field.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool login = true;

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text('Login to your account'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            FullField(
              controller: _email,
              label: 'Email',
              hint: 'amir@gmail.com',
              password: false,
            ),
            const SizedBox(height: 10),
            FullField(
              controller: _password,
              label: 'Password',
              hint: '********',
              password: true,
            ),
            const SizedBox(height: 15),
            login
                ? FullButton(
                    text: 'Login',
                    color: Colors.indigo,
                    onClick: () async {
                      try {
                        await loginAuth(_email.text, _password.text, context);
                        Navigator.pop(context);
                      } catch (error) {}
                    },
                  )
                : FullButton(
                    text: 'Create',
                    color: Colors.indigo,
                    onClick: () async {
                      await registerAuth(_email.text, _password.text, context);
                    },
                  ),
            const SizedBox(height: 10),
            login
                ? TextButton(
                    child: const Text(
                      'I do not have an account',
                      style: TextStyle(
                        color: Colors.indigo,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        login = false;
                      });
                    },
                  )
                : TextButton(
                    child: const Text(
                      'I have an account',
                      style: TextStyle(
                        color: Colors.indigo,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        login = true;
                      });
                    },
                  ),
            const SizedBox(height: 20),
            const Center(child: Text('Or')),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FullButton(
                  text: 'Google',
                  color: Colors.red,
                  onClick: () async {
                    await googleAuth(context);
                  },
                ),
                FullButton(
                  text: 'Facebook',
                  color: Colors.blue,
                  onClick: () async {},
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FullButton(
                  text: 'Twitter',
                  color: Colors.lightBlueAccent,
                  onClick: () async {},
                ),
                FullButton(
                  text: 'Yahoo',
                  color: Colors.purple,
                  onClick: () async {},
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FullButton(
                  text: 'Github',
                  color: Colors.black87,
                  onClick: () async {},
                ),
                FullButton(
                  text: 'Anonymously',
                  color: Colors.grey,
                  onClick: () async {
                    await anonAuth(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
