import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: itDept(),
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      useMaterial3: true,
    ),
  ));
}

class Dept {
  String name;
  String location;
  String imageUrl;
  Dept({
    this.name="",
    this.location="",
    this.imageUrl="",
  });
  Map<String, dynamic> toJson() => {
    'name':name,
    'location':location,
    'imageUrl':imageUrl,
  };
  static Dept fromJson(Map<String,dynamic> json) => Dept(
    name: json['name'],
    location: json['location'],
    imageUrl: json['imageUrl'],
  );
}

class itDept extends StatefulWidget {
  @override
  State<itDept> createState() => _itDeptState();

}
Stream<List<Dept>> readData() => FirebaseFirestore.instance
    .collection('ssnvisitapp')
    .snapshots()
    .map((snapshot) => snapshot.docs.map(
        (doc) => Dept.fromJson(doc.data())).toList());

Widget buildData(Dept data) => Container(
                                decoration: BoxDecoration(
                                border: Border.all(color: Colors.blueAccent, width: 2.0),
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                color: Colors.white,
                                ),
                                child:ListTile(
                                  title: Text(data.name),
                                  subtitle: Text(data.location),
                                  trailing: InkWell(
                                    child: data.imageUrl.isNotEmpty
                                        ? Image.network(
                                      data.imageUrl,
                                      width: 148.0,
                                      height: 148.0,
                                      fit: BoxFit.cover,
                                    )
                                        : Container(width: 0.0, height: 0.0),
                                  ),
                                ),
);

class _itDeptState extends State<itDept>{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
          title: Text('Department of IT',style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.web_sharp,size: 50,),
            onPressed: () async{
              if(!await launchLinkedIn()){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('LinkedIn Could Not Open!')));
              }
            },
          )
        ],
      ),
      body: StreamBuilder<List<Dept>>(
            stream: readData(),
            builder: (context, snapshot) {
              if(snapshot.hasError) {
                return Text('Something went wrong! ${snapshot.error}');
              }
              else if (snapshot.hasData) {
                final data = snapshot.data!;
                return ListView(
                  children: data.map(buildData).toList(),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.assistant_direction_rounded),
        onPressed: () async{
            final Uri url = Uri.parse('https://www.ssn.edu.in/college-of-engineering/information-technology-department-ssn-institutions/');
            if (!await launchUrl(url)) {
            throw Exception('Could not launch $url');
            }
        },
      ),
    );
  }
  Future<bool> launchLinkedIn() async {
    final Uri url = Uri.parse('https://www.linkedin.com/company/procode-it-ssn/');
    return launchUrl(url);
  }

}