import 'package:flutter/material.dart';
import 'package:flutter_application_1/m07/auth.dart';
import 'package:flutter_application_1/m07/myhome.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home7 extends StatefulWidget {
  const Home7({super.key});

  @override
  State<Home7> createState() => _Home7State();
}

class _Home7State extends State<Home7> {
  late AuthFirebase auth;

  @override
  void initState() {
    auth = AuthFirebase();
    auth.getUser().then((value) {
      MaterialPageRoute route;
      if (value != null) {
        route = MaterialPageRoute(builder: (context) => MyHome(wid: value.uid));
      }
    }).catchError((err) => print(err));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      onLogin: _loginUser,
      onRecoverPassword: _recoverPassword,
      onSignup: _onSignup,
      passwordValidator: (value) {
        if (value != null) {
          if (value.length < 6) {
            return "Password must be 6 characters";
          }
        }
      },
      loginProviders: [LoginProvider(callback: _onLoginGoogle, icon: FontAwesomeIcons.google, label: 'Google')],
      onSubmitAnimationCompleted: () {
        auth.getUser().then((value) {
          print(value);
          MaterialPageRoute route;
          if (value != null) {
            route = MaterialPageRoute(builder: (context) => MyHome(wid: value.uid));
          } else {
            route = MaterialPageRoute(builder: (context) => Home7());
          }
          Navigator.pushReplacement(context, route);
        }).catchError((err) => print(err));
      },
    );
  }

  Future<String?> _loginUser(LoginData data) {
    return auth.login(data.name, data.password).then((value) {
      if (value != null) {
        MaterialPageRoute(builder: (context) => MyHome(wid: value));
      } else {
        final snackBar = SnackBar(content: Text('Login Failed, User Not Found'), action: SnackBarAction(label: 'OK', onPressed: () {}));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home7()));
      }
    });
  }

  Future<String>? _recoverPassword(String name) {
    return null;
  }

  Future<String?> _onSignup(SignupData data) {
    return auth.signUp(data.name!, data.password!).then((value) {
      if (value != null) {
        final snackBar = SnackBar(
          content: Text('Sign Up Successful'),
          action: SnackBarAction(label: 'OK', onPressed: () {}),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  Future<String?> _onLoginGoogle() {
    return auth.googleLogin();
  }
}
