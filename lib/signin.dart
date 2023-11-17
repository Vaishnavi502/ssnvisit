import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ssnvisitapp/main.dart';
import 'package:ssnvisitapp/src/login_api.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
    clientId: '9821617792-nci5hr8mdg2mfukupju2upmkbacp9kts.apps.googleusercontent.com',
    scopes: <String>[
      'email',
      'profile',
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Login for SSN Virtual Tour'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/bck_img.png',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    width: 250,
                    height: 70,
                    child: ElevatedButton(
                      onPressed:  () async {
                        // proceed with Google Sign-In
                        _handleGoogleSignIn();
                      },
                      child: Text('Sign in with Google',style:TextStyle(fontSize: 20, fontFamily: 'Poppins',color: Colors.black45)),
                    ),
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
      var user = await LoginApi.login();
      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Google Sign-In Success: ${user.displayName}')));
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Maps()));
        // TODO: Navigate to Maps screen after successful sign-in
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Google Sign-In Failed :(')));
      }
    } catch (error) {
      print('Google Sign-In Error: $error');
    }
  }
}
