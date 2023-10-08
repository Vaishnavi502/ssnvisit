import 'package:flutter/material.dart';
import 'package:ssnvisitapp/home.dart';

class Splash extends StatefulWidget {
  const Splash({ Key?key}) : super(key: key);
  @override
  _SplashState createState()=>_SplashState();
}

class _SplashState extends State<Splash>{
  @override
  void initState(){
    super.initState();
    _navigatetoHome();
  }

  _navigatetoHome() async{
    await Future.delayed(Duration(milliseconds: 1500), (){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icon.png',
              height: 100,
              width: 100,
            ),
            SizedBox(height: 20),
            Container(
              child: Text(
                'SSN Visual Tour App',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}