import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'DrawerScreen.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.blueGrey[800]
        ),
        home: Scaffold(
          resizeToAvoidBottomInset: true,
          // backgroundColor: Colors.blueGrey[900],
          // appBar: AppBar(
          //     title: Text("Naughty or Nice?"),
          //     centerTitle: true,
          //     elevation: 0.0,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(25.0),
          //     )
          // ),
          body: Stack(
            children: [
              DrawerScreen(),
              SettingsPageBuild(),
            ],
          ),

        )
    );
  }
}

class SettingsPageBuild extends StatefulWidget {
  @override
  _SettingsPageBuildState createState() => _SettingsPageBuildState();
}

class _SettingsPageBuildState extends State<SettingsPageBuild> {

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;
  int _index = 1;
  int prevIndex = -1;

  List<bool> _selections = List.generate(3, (_) => false);

  @override
  void initState() {
    getSettingsPreference().then(_updateSettings);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)..scale(scaleFactor),

      duration: Duration(milliseconds: 250),


      decoration: BoxDecoration(
        color: Colors.grey[350],
        borderRadius: BorderRadius.circular(isDrawerOpen?40:0.0),
        boxShadow: [BoxShadow(blurRadius: 20, color: Color(0xff450000), spreadRadius: 10)],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: <Widget>[
          SizedBox(
            height: 30,
            // width: 200,
          ),

          //just for vertical spacing

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isDrawerOpen?IconButton(icon: Icon(Icons.arrow_back_ios, color: Color(0xFF600000),), onPressed: () {
                setState(() {
                  xOffset = 0;
                  yOffset = 0;
                  scaleFactor = 1;
                  isDrawerOpen = false;
                });
              }):
              IconButton(icon: Icon(Icons.menu , color: Color(0xFF600000)) , onPressed: () {
                setState(() {
                  xOffset = 180;
                  yOffset = 70;
                  scaleFactor = 0.8;
                  isDrawerOpen = true;
                });
              }),
              Text('My Santa!',
                  textScaleFactor: 2.5,
                  style: GoogleFonts.caveat(
                      textStyle: TextStyle(color: Color(0xFF600000))
                  )
                // style: TextStyle(
                //   color: Colors.red[900],
              ),
              SizedBox(
                height: 30,
                width: 30,
              ),
            ],

          )    ,

          SizedBox(
            height: 30,
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(25,0,25,0),
            child: Text(
              "Settings",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
          ),
          
          Flexible(
            child: SizedBox(
              height: 25,
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Divider(
              height: 15,
              thickness: 2,
            ),
          ),
          
          SizedBox(
            height: 25,
          ),

          ToggleButtons(
            renderBorder: true,
              selectedColor: Color(0xff550000),
              fillColor: Color((0x77800000)),
              children: [
                Container(
                    child: Padding(
                      padding: const EdgeInsets.all(15) ,
                      child: Column(
                          children: [
                            (_index == 0)?Icon(Icons.child_care, color: Color(0xff550000),size: 75,):Icon(Icons.child_care, size: 75,),
                            Text("CHILD"),
                          ],
                        ),
                    )
                    ),

                Container(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          (_index == 1)?Icon(Icons.airport_shuttle, color: Color(0xff550000),size: 75,):Icon(Icons.airport_shuttle, size: 75,),
                          Center(child: Text("SILENT AI")),
                        ],
                      ),
                    )
                ),

                // Icon(Icons.airport_shuttle),

                Container(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          (_index == 2)?Icon(Icons.airplanemode_active, color: Color(0xff550000),size: 75,):Icon(Icons.airplanemode_active, size: 75,),
                          Center(child: Text("FULL AI")),
                        ],
                      ),
                    )
                ),

                // Icon(Icons.airplanemode_active)
              ],
              isSelected: _selections,
              onPressed: (int index) {
                if (index != prevIndex) {
                  _index = index;
                  prevIndex = index;
                  saveSettingsPreference(index);
                  setState(() {
                    _selections[index] = !_selections[index];
                    print("In storage");
                    getSettingsPreference().then((value) {print(value);});
                    print("value of _index");
                    print(_index);

                    if(_selections[index] == true){
                      _selections[((index+1)%3)] = false;
                      _selections[((index+2)%3)] = false;
                    }


                  });
                }
              },
          ),

          SizedBox(
            height: 10,
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.info),
                Text("  CHILD MODE - \tSanta always thinks you are nice!"),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.info),
                Text("  "),
                Flexible(child: Text("SILENT AI MODE - \tAI is used but Santa does not \t comment")),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.info),
                Text("  "),
                Text("FULL AI MODE - \tAI is used and Santa comments!"),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Divider(
              height: 40,
              thickness: 2,
            ),
          ),

          SizedBox(
            height: 55,
          ),

        ],
      ),


    );
  }

  void _updateSettings(int value) {
    setState(() {
      if(this._index == null){
        value = 2;
      }
      else {
        this._index = value;
      }
    });
  }
}

Future<void> saveSettingsPreference(int setting) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt("setting", setting);
}

Future<int> getSettingsPreference() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int storedSetting = prefs.getInt("setting");
  return storedSetting;
}