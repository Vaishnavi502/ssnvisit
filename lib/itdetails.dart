import 'package:flutter/material.dart';

main() {
  runApp(MaterialApp(
    home: itDept(),
  ));
}

class itDept extends StatefulWidget {
  @override
  State<itDept> createState() => _itDeptState();
}

class _itDeptState extends State<itDept>{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text('IT Department')
      ),
      body: FirebaseAnimatedList(

      ),
    );
  }
}