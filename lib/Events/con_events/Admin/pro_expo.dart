import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled/firestore/registerpage.dart';
import 'package:untitled/firestore/youtube_player.dart';

// ignore: camel_case_types
class ProjectExpo_Admin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Color(0xff96da45),
        title: new Text(
          'Project Expo',
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[],
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      floatingActionButton: null,
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection("ProjectExpo").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.all(0.0),
            scrollDirection: Axis.vertical,
            primary: true,
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              print(document.data());
              return new AwesomeListItem(
                title: document['name'],
                content: document['rollno'],
                clg: document['college'],
                branch: document['branch'],
                phone: document['phone'],
                color: Color(0xFFEF7A85),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = new Path();
    p.lineTo(size.width, 0.0);
    p.lineTo(size.width, size.height / 4.75);
    p.lineTo(0.0, size.height / 3.75);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

// ignore: must_be_immutable
class AwesomeListItem extends StatefulWidget {
  var title;
  var content;
  var color;
  var phone;
  var branch;
  var clg;

  AwesomeListItem(
      {required this.title,
      required this.content,
      required this.color,
      required this.branch,
      required this.phone,
      required this.clg});

  @override
  _AwesomeListItemState createState() => new _AwesomeListItemState();
}

class _AwesomeListItemState extends State<AwesomeListItem> {
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(4.0),
      // ignore: deprecated_member_use
      child: RaisedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RegisterPage(
                name: widget.title,
                rollno: widget.content,
                college: widget.clg,
                phone: widget.phone,
                branch: widget.branch,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Row(
            children: <Widget>[
              new Container(width: 10.0, height: 190.0, color: widget.color),
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 40.0, horizontal: 20.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        widget.title,
                        style: TextStyle(
                            color: Colors.grey.shade800,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: new Text(
                          widget.branch,
                          style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: new Text(
                          widget.phone,
                          style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              new Container(
                height: 150.0,
                width: 150.0,
                color: Colors.white,
                child: Stack(
                  children: <Widget>[
                    new Transform.translate(
                      offset: new Offset(50.0, 0.0),
                      child: new Container(
                        height: 100.0,
                        width: 100.0,
                        color: widget.color,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
