import 'package:flutter/material.dart';
import 'package:rbocw/widgets/profileHeader.dart';
import 'package:rbocw/widgets/userInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/app_data.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        extendBody: true,
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        // ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(children: <Widget>[
                Container(
                  height: 200.0,
                  decoration: BoxDecoration(
//                    gradient: LinearGradient(colors: [
//                      Colors.indigo.shade300,
//                      Colors.indigo.shade500
//                    ]),
                    color: AppData.kPrimaryColor,
                  ),
                ),
                _buildHeader(context)
              ]),
              // ProfileHeader(
              //   avatar: NetworkImage(
              //       "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg"),
              //   coverImage: NetworkImage(
              //       "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg"),
              //   title: "Ramesh Mana",
              //   subtitle: "Manager",
              //   actions: <Widget>[
              //     MaterialButton(
              //       color: Colors.white,
              //       shape: CircleBorder(),
              //       elevation: 0,
              //       child: Icon(Icons.edit),
              //       onPressed: () {},
              //     )
              //   ],
              // ),
              const SizedBox(height: 10.0),
              UserInfo(),
              // UserInfo(),
            ],
          ),
        ));
  }

  Container _buildHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      height: 210.0,
      child: Stack(
        children: <Widget>[
          Container(
            padding:
                EdgeInsets.only(top: 40.0, left: 40.0, right: 40.0, bottom: .0),
            child: Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              elevation: 5.0,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50.0,
                  ),
                  Text(
                    "Sanjaya Jena",
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  //Text("UI/UX designer | Foodie | Kathmandu"),
                  //Text("Worker"),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text("(Verified Worker)"),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text("From Cuttack"),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      icon: Icon(Icons.exit_to_app),
                      onPressed: () {
                        _exitApp();
                      },
                      color: AppData.kPrimaryColor,
                      iconSize: 25.0,
                    ),
                  ),
                  Container(
                      // height: 20.0,
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      children: <Widget>[
//                        Expanded(
//                          child: ListTile(
//                            title: Text(
//                              "302",
//                              textAlign: TextAlign.center,
//                              style: TextStyle(fontWeight: FontWeight.bold),
//                            ),
//                            subtitle: Text("Posts".toUpperCase(),
//                                textAlign: TextAlign.center,
//                                style: TextStyle(fontSize: 12.0)),
//                          ),
//                        ),
//                        Expanded(
//                          child: ListTile(
//                            title: Text(
//                              "10.3K",
//                              textAlign: TextAlign.center,
//                              style: TextStyle(fontWeight: FontWeight.bold),
//                            ),
//                            subtitle: Text("Followers".toUpperCase(),
//                                textAlign: TextAlign.center,
//                                style: TextStyle(fontSize: 12.0)),
//                          ),
//                        ),
//                        Expanded(
//                          child: ListTile(
//                            title: Text(
//                              "120",
//                              textAlign: TextAlign.center,
//                              style: TextStyle(fontWeight: FontWeight.bold),
//                            ),
//                            subtitle: Text("Following".toUpperCase(),
//                                textAlign: TextAlign.center,
//                                style: TextStyle(fontSize: 12.0)),
//                          ),
//                        ),
//                      ],
//                    ),
                      )
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Material(
                elevation: 5.0,
                shape: CircleBorder(),
                child: CircleAvatar(
                  radius: 40.0,
                  backgroundImage: NetworkImage(
                      "https://pbs.twimg.com/profile_images/1063849898934595585/UufjhYvz_400x400.jpg"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _exitApp() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('IS_LOGINED', false);
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }
}
