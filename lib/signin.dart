import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:email_validator/email_validator.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({super.key});
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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
      caseSensitive: true);
  final GoogleSignIn googleSignIn = GoogleSignIn( clientId: '389452900824-dtmkkp96ahiq049cmovptcm1sruuesit.apps.googleusercontent.com',
    scopes: <String>[
      'email',
      'username',
      // Add additional scopes as needed for your app
    ],
  );
  Future<bool> isEmailAssociatedWithGoogle(String email) async {
    final GoogleSignInAccount? googleSignInAccount =
    await GoogleSignIn(scopes: ['email']).signInSilently();

    if (googleSignInAccount != null) {
      // The user is already signed in with Google.
      // You can access the user's Google account information here.
      return true;
    } else {
      // The email is not associated with a Google account.
      return false;
    }
  }
  Future<void> checkValidity(String val)
  async {
    if(await isEmailAssociatedWithGoogle(val)) {
      _errormsg = "";
    }
    else{
      _errormsg="Invalid SSN Email ID";
    }
  }
  void validateEmail(String val) {
    if(val.isEmpty){
      setState(() {
        _errormsg = "Email can not be empty";
      });
    }else if(!exp.hasMatch(val)){
      setState(() {
        _errormsg = "Please enter SSN Email ID";
      });
    }else{
      setState(() {
        _errormsg="";
      });
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Login for SSN virtual tour'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: 'Email'),
              onChanged: (val){
                validateEmail(val);
                checkValidity(val);
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  print("Sign in Clicked");
                },
                child: Text('Sign in'),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(_errormsg, style: TextStyle(color: Colors.red),),
            ),
          ],
        ),
      ),
    );
  }
}