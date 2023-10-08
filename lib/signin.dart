import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SSN Virtual Visit App with Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Loginpage(),
    );
  }
}

class Loginpage extends StatefulWidget {
  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  String _errormsg = '';
  RegExp exp = RegExp(
    r"^[a-zA-Z0-9._]+@ssn.edu.in$",
    caseSensitive: true,
  );
  final GoogleSignIn googleSignIn = GoogleSignIn(
    clientId: '389452900824-dtmkkp96ahiq049cmovptcm1sruuesit.apps.googleusercontent.com',
    scopes: <String>[
      'email',
      'profile',
    ],
  );

  Future<bool> isEmailAssociatedWithGoogle(String email) async {
    final GoogleSignInAccount? googleSignInAccount =
    await GoogleSignIn(scopes: ['email']).signInSilently();

    if (googleSignInAccount != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> checkValidity(String val) async {
    if (exp.hasMatch(val)) {
      if (await isEmailAssociatedWithGoogle(val)) {
        setState(() {
          _errormsg = "";
        });
      } else {
        setState(() {
          _errormsg = "Valid SSN Email ID, but please sign in with Google";
        });
      }
    } else {
      setState(() {
        _errormsg = "Invalid SSN Email ID";
      });
    }
  }

  void validateEmail(String val) {
    if (val.isEmpty) {
      setState(() {
        _errormsg = "Email can not be empty";
      });
    } else {
      checkValidity(val);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login for SSN Virtual Tour'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/bck_img.png',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(labelText: 'Email'),
                        onChanged: (val) {
                          validateEmail(val);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_errormsg.isEmpty) {
                              // If there are no errors, proceed with Google Sign-In
                              _handleGoogleSignIn();
                            }
                          },
                          child: Text('Sign in with Google'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _errormsg,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        print('Google Sign-In Success: ${googleSignInAccount.displayName}');
        // TODO: Navigate to main.dart after successful sign-in
      } else {
        print('Google Sign-In Canceled');
      }
    } catch (error) {
      print('Google Sign-In Error: $error');
    }
  }
}
