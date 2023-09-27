import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
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
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
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

// const Loginpage({super.key, required this.title});
}
// This widget is the home page of your application. It is stateful, meaning
// that it has a State object (defined below) that contains fields that affect
// how it looks.

// This class is the configuration for the state. It holds the values (in this
// case the title) provided by the parent (in this case the App widget) and
// used by the build method of the State. Fields in a Widget subclass are
// always marked "final".

//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
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
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
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