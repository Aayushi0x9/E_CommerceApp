import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.of(context).pushReplacementNamed('homePage');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/hpbg.jpeg'),
                fit: BoxFit.cover),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Container(
              margin:
                  EdgeInsets.only(top: 150, right: 20, left: 20, bottom: 150),
              padding: EdgeInsets.all(50),
              decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.only(
                      bottomEnd: Radius.circular(120),
                      topStart: Radius.circular(120)),
                  color: Colors.white.withOpacity(0.2),
                  border: Border.all(color: Colors.white)),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'LogIn Here...!!',
                      style: TextStyle(
                        shadows: [
                          Shadow(
                              color: Colors.black,
                              offset: Offset(3, 3),
                              blurRadius: 2),
                        ],
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        color: Colors.white,
                        fontSize: 32,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Colors.white,
                      cursorErrorColor: Colors.red,
                      showCursor: true,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.white,
                        ),
                        labelText: 'Email',
                      ),
                      validator: (value) {
                        if (value == null || !value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _email = value!;
                      },
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                      cursorColor: Colors.white,
                      cursorErrorColor: Colors.red,
                      showCursor: true,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.white,
                        ),
                        labelText: 'Password',
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _password = value!;
                      },
                    ),
                    SizedBox(height: size.height * 0.1),
                    CupertinoButton(
                        color: Colors.white,
                        pressedOpacity: 0.4,
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: _submit),
                    // ElevatedButton(
                    //   onPressed: _submit,
                    //   child: Text('Login'),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
