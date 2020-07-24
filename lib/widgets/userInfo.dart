import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
            alignment: Alignment.topLeft,
            child: Text(
              "User Information",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Card(
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      ...ListTile.divideTiles(
                        color: Colors.grey,
                        tiles: [
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            leading: Icon(Icons.contact_mail),
                            title: Text("First Name"),
                            subtitle: Text("Sanjaya"),
                          ),
                          ListTile(
                            leading: Icon(Icons.contact_mail),
                            title: Text("Last Name"),
                            subtitle: Text("Jena"),
                          ),
                          ListTile(
                            leading: Icon(Icons.assignment_ind),
                            title: Text("Gender"),
                            subtitle: Text("Male"),
                          ),
                          ListTile(
                            leading: Icon(Icons.fiber_smart_record),
                            title: Text("Maritial Status"),
                            subtitle: Text("Non-Married"),
                          ),
                          ListTile(
                            leading: Icon(Icons.person),
                            title: Text("Father Name"),
                            subtitle: Text("S. Jena"),
                          ),
                          ListTile(
                            leading: Icon(Icons.date_range),
                            title: Text("Date of birth"),
                            subtitle: Text("15th May 1997"),
                          ),
                          ListTile(
                            leading: Icon(Icons.phone),
                            title: Text("Phone"),
                            subtitle: Text("99--99876-56"),
                          ),
                          ListTile(
                            leading: Icon(Icons.keyboard_hide),
                            title: Text("Adhar Number"),
                            subtitle: Text("1234-5678-9012"),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
