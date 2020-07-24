import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rbocw/models/nomineeModel.dart';
import 'package:rbocw/providers/SharedPref.dart';
import 'package:rbocw/providers/app_data.dart';
import 'package:rbocw/ui/addBeniModal.dart';

import 'ConfirmPages.dart';

class BenificiaryPage extends StatefulWidget {
  BenificiaryPage({Key key}) : super(key: key);

  @override
  _BenificiaryPageState createState() => _BenificiaryPageState();
}

class _BenificiaryPageState extends State<BenificiaryPage> {
  // var names = <NomineeModel>[
  //   NomineeModel(
  //       name: "Manoranjan",
  //       gender: "M",
  //       age: "28",
  //       relation: "Brother",
  //       share: "75"),
  //   NomineeModel(
  //       name: "Abc", gender: "M", age: "28", relation: "Father", share: "20"),
  //   NomineeModel(
  //       name: "Xyz", gender: "F", age: "28", relation: "Mother", share: "5"),
  // ];
  List<NomineeModel> beniList = [];
  SharedPref sharedPref = SharedPref();

  @override
  void initState() {
    setBeniData();
    super.initState();
  }

  setBeniData() async {
    var beni = await sharedPref.getKey("beniList");
    if (beni != null) {
      List bList = await sharedPref.read("beniList");
      bList = bList.map((i) => NomineeModel.fromJson(i)).toList();

      print(bList.toString());
      setState(() {
        beniList = bList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppData.kPrimaryColor,
        title: Text(
          //"Benificiary list",
          "Step 2/3: Add Nominee",
        ),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            beniList.length > 0
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.all(8),
                    child: _dataTable())
                : Container(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("No Benificiary"),
                        ),
                        continueButton()
                      ],
                    ),
                  ),
            nextButton(),

          ],
        ),
      ),
    );
  }

  // Widget bodyData() => SingleChildScrollView(
  //       scrollDirection: Axis.horizontal,
  //       padding: EdgeInsets.all(8),
  //       child: beniList.length > 0
  //           ? _dataTable()
  //           : Container(
  //               child: Column(
  //                 children: <Widget>[
  //                   Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: Text("No Benificiary"),
  //                   ),
  //                   continueButton()
  //                 ],
  //               ),
  //             ),
  //     );

  Widget continueButton() {
    return InkWell(
      child: Center(
        child: CircleAvatar(
          radius: 20.0,
          //backgroundColor: Colors.amber.shade600,
          backgroundColor: AppData.kPrimaryColor,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      onTap: () {
        _addBeniDialogBox();
      },
    );
  }

  DataTable _dataTable() {
    return DataTable(
        onSelectAll: (b) {},
        // dataRowHeight: 10,
        columnSpacing: 18,
        horizontalMargin: 0,
        // sortColumnIndex: 1,
        sortAscending: true,
        columns: <DataColumn>[
          DataColumn(
              label: Container(
                  width: 30,
                  child: Text(
                    'Sl No.',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ))),
          DataColumn(
            label: Text(
              "Name",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            numeric: false,
            onSort: (i, b) {
              print("$i $b");
              setState(() {
                beniList.sort((a, b) => a.name.compareTo(b.name));
              });
            },
            tooltip: "To display first name of the Name",
          ),
          DataColumn(
            label: Text(
              "Sex",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            numeric: false,
            onSort: (i, b) {
              print("$i $b");
              setState(() {
                // names.sort((a, b) => a.lastName.compareTo(b.lastName));
              });
            },
            tooltip: "Sex",
          ),
          DataColumn(
            label: Text(
              "Age",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              "Relation",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              "Share(%)",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Row(
              children: <Widget>[
                Text(
                  "Action",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Container(
                    height: 20,
                    width: 2,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _addBeniDialogBox();
                  },
                  child: Icon(
                    Icons.add,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          )
        ],
        rows: beniList
            .asMap()
            .map((i, data) => MapEntry(
                  i,
                  DataRow(
                    // selected: true,
                    cells: [
                      DataCell(Container(
                          width: 10, //SET width
                          child: Text('${i + 1}'))),
                      DataCell(
                        Container(width: 50, child: Text(data.name)),
                        // showEditIcon: true,
                        // placeholder: true,
                      ),
                      DataCell(
                        Text(data.gender),
                        showEditIcon: false,
                        placeholder: false,
                      ),
                      DataCell(
                        Text(data.age),
                      ),
                      DataCell(
                        Text(data.relation),
                        showEditIcon: false,
                        placeholder: false,
                      ),
                      DataCell(
                        Text(data.share,textAlign: TextAlign.center,),
                        showEditIcon: false,
                        placeholder: false,
                        onTap: (){
                          print("hey");
                        }
                      ),
                      DataCell(
                        Row(
                          children: <Widget>[
                            InkWell(
                              child: Icon(
                                Icons.edit,
                                color: Colors.blue,
                              ),
                              onTap: () {
                                _editBeniDialogBox(i);
                              },
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                _deleteBeni(i);
                              },
                              child: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            )
                          ],
                        ),
                        showEditIcon: false,
                        placeholder: false,
                      )
                    ],
                  ),
                ))
            .values
            .toList());

  }

  Widget nextButton() {
    return new InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          //builder: (BuildContext context) => NomineePage(),
          builder: (BuildContext context) => ConfirmPages(),
        ),
      ),
      child: Padding(
        padding:
        const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0, right: 8.0),
        child: new Container(
          //width: 100.0,
          height: 45.0,
          decoration: new BoxDecoration(
            color: AppData.kPrimaryColor,
            //border: new Border.all(color: Colors.white, width: 2.0),
            borderRadius: new BorderRadius.circular(17.0),
          ),
          child: new Center(
            child: new Text(
              'Next Step',
              style: new TextStyle(fontSize: 18.0, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  void _deleteBeni(int index) {
    beniList.removeAt(index);
    sharedPref.save("beniList", beniList);
    setState(() {});
  }

  void _editBeniDialogBox(int index) async {
    int share = 0;
    if (beniList.length > 0) {
      beniList.forEach((element) {
        share += int.parse(element.share);
      });
    }
    NomineeModel nomineeModel = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: AddBenificiaryModal(
              nomineeModel: beniList[index],
              title: "Edit Benificiary",
              share: share,
            ),
          );
        });
    if (nomineeModel != null) {
      print("nomineeModel>>>>>>>>>>" + nomineeModel.name.toString());
      beniList.removeAt(index);
      beniList.insert(index, nomineeModel);
      sharedPref.save("beniList", beniList);
      setState(() {});
    }
  }

  void _addBeniDialogBox() async {
    int share = 0;
    if (beniList.length > 0) {
      beniList.forEach((element) {
        share += int.parse(element.share);
      });
    }
    print("share" + share.toString());
    NomineeModel nomineeModel = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: AddBenificiaryModal(
              nomineeModel: NomineeModel(),
              title: "Add Benificiary",
              share: share,
            ),
          );
        });

    if (nomineeModel != null) {
      print("nomineeModel>>>>>>>>>>" + nomineeModel.name.toString());
      beniList.add(nomineeModel);
      sharedPref.save("beniList", beniList);
      setState(() {});
    }
  }
}
