import 'package:flutter/material.dart';
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

        _errormsg = "";
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