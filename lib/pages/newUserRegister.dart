import 'package:flutter/material.dart';
import 'package:rbocw/models/UserPersonalFormModel.dart';
import 'package:rbocw/pages/OtherForm.dart';
import 'package:rbocw/pages/personalFormPage.dart';
import 'package:rbocw/providers/SharedPref.dart';
import 'package:rbocw/scoped-model/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:rbocw/pages/addressForm.dart';
import 'package:rbocw/pages/familyMember.dart';

import '../providers/app_data.dart';

class NewUserRegister extends StatefulWidget {
  final MainModel model;

  const NewUserRegister({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  _NewUserRegisterState createState() => _NewUserRegisterState();
}

class _NewUserRegisterState extends State<NewUserRegister>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  int _selectedTab = 0;
  List<String> _isDisabled = ["false", "true", "true", "true"];
  SharedPref sharedPref = SharedPref();
  UserPersonalFormModel userPersonalForm = UserPersonalFormModel();
  @override
  void initState() {
    super.initState();
    // sharedPref.clear();
    _tabController = TabController(vsync: this, length: 4);

    _tabController.addListener(() {
      tabDisable();
      // if (!_tabController.indexIsChanging) {
      //   setState(() {
      //     _selectedTab = _tabController.index;
      //   });
      // }
    });
  }

  tabDisable() async {
    var tab = await sharedPref.readList("registerTabDisaled");
    //
    print(tab.toString());
    if (tab != null) {
      _isDisabled = tab;
      print("nnnnnnnnnnnn" + _tabController.indexIsChanging.toString());
      if (_isDisabled[_tabController.index] == "true") {
        int index = _tabController.previousIndex;
        setState(() {
          _tabController.index = index;
        });
      }
    } else {
      print("not set tab disable");
      if (_isDisabled[_tabController.index] == "true") {
        int index = _tabController.previousIndex;
        setState(() {
          _tabController.index = index;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register User"),
        backgroundColor: AppData.kPrimaryColor,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DefaultTabController(
            length: 4,
            child: Column(
              children: <Widget>[
                TabBar(
                  // unselectedLabelColor: Colors.blue,
                  // labelColor: Colors.blue,
                  // indicatorColor: Colors.white,
                  controller: _tabController,
                  labelPadding:
                      EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                  //unselectedLabelColor: Color(0xFF255E55),
                  unselectedLabelColor:
                      (_isDisabled[_tabController.index] == "false")
                          ? Color(0xFF255E55)
                          : Color(0xFF000000),
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                    color: Color(0xFF255E55),
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(10.0)),
                  ),

                  tabs: [
                    _getTab(0, "Personal"),
                    _getTab(1, "Address"),
                    _getTab(2, "Work Experience"),
                    _getTab(3, "Others"),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _tabController,
                    children: [
                      PersonalForm(
                        updateTab: updateTab,
                      ),
                      AddressForm(updateTab: updateTab),
                      // Icon(Icons.directions_bike),
                      //
                      FamilyMemberForm(updateTab: updateTab),
                      OtherForm(updateTab: updateTab)
                      //Icon(Icons.directions_bike),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  _getTab(index, text) {
    // return Tab(
    //   child: SizedBox.expand(
    //     child: Container(
    //       child: child,
    //       decoration: BoxDecoration(
    //           color:
    //               (_selectedTab == index ? Colors.white : Colors.grey.shade300),
    //           borderRadius: _generateBorderRadius(index)),
    //     ),
    //   ),
    // );
    return Tab(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: (_isDisabled[_tabController.index] == "false")
                    ? Color(0xFF255E55)
                    : Color(0xFFED3833),
                width: 1)),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
          ),
        ),
      ),
    );
  }

  _generateBorderRadius(index) {
    if ((index + 1) == _selectedTab)
      return BorderRadius.only(bottomRight: Radius.circular(10.0));
    else if ((index - 1) == _selectedTab)
      return BorderRadius.only(bottomLeft: Radius.circular(10.0));
    else
      return BorderRadius.zero;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  updateTab(int index, bool formValidation) {
    print("call>>>" + index.toString() + formValidation.toString());
    if (formValidation) {
      setState(() {
        _isDisabled[index + 1] = "false";
        _saveList();
        if (index < 3) _tabController.index = index + 1;
      });
      print(_isDisabled);
    }
  }

  getUserPersonalFormData() async {
    UserPersonalFormModel userPersonalForm =
        UserPersonalFormModel.fromJson(await sharedPref.read("userForm"));
    print(userPersonalForm.firstName);
  }

  _saveList() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setStringList("registerTabDisaled", _isDisabled);
  }
}
