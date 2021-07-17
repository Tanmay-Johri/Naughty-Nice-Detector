import 'package:flutter/material.dart';
import 'package:ondevice/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstTime extends StatefulWidget {
  @override
  _FirstTimeState createState() => _FirstTimeState();
}

class _FirstTimeState extends State<FirstTime> {
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
          body: FirstTimeBuild()

        )
    );
  }
}


class FirstTimeBuild extends StatefulWidget {
  @override
  _FirstTimeBuildState createState() => _FirstTimeBuildState();
}

class _FirstTimeBuildState extends State<FirstTimeBuild> {

  List<bool> _selections = List.generate(3, (_) => false);
  bool madeChoice = false;
  int prevIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        color: Colors.grey[350],
        // borderRadius: BorderRadius.circular(isDrawerOpen?40:0.0),
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
              SizedBox(
                height: 30,
                width: 30,
              ),

              Text('Naughty or Nice?',
                textScaleFactor: 1.5,
                style: TextStyle(
                  color: Colors.red[900],
                ),),
              SizedBox(
                height: 30,
                width: 30,
              ),
            ],

          )    ,

          Flexible(
            child: SizedBox(
              height: 30,
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(25,0,25,0),
            child: Container(
              height: 35,
              alignment: Alignment.center,
              child: Text(
                "Just choose a mode and",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(25,0,25,0),
            child: Container(
              height: 35,
              alignment: Alignment.center,
              child: Text(
                "you'll be all set to interact",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(25,0,25,0),
            child: Container(
              height: 35,
              alignment: Alignment.center,
              child: Text(
                "with Santa!",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(25,0,25,0),
            child: Container(
              height: 25,
              alignment: Alignment.center,
              child: Text(
                "You can always change it later",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
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

          Flexible(
            child: SizedBox(
              height: 25,
            ),
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
                        Icon(Icons.child_care, size: 75,),
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
                        Icon(Icons.airport_shuttle, size: 75,),
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
                        Icon(Icons.airplanemode_active, size: 75,),
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
                madeChoice = true;
                saveSettingsPreference(index);
                prevIndex = index;
                setState(() {
                  _selections[index] = !_selections[index];
                  print("In storage");
                  getSettingsPreference().then((value) {print(value);});
                  // print("value of _index");
                  // print(_index);

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

          Flexible(
            child: SizedBox(
            height: 55,
            ),
          ),


          RaisedButton(
            color: Colors.red[900],
            child: Text("Choose mode!", style: TextStyle(color: Colors.white),),

            shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30),),
            onPressed: () {
              if(madeChoice){
                Navigator.of(context).pop();
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Home()),);
              }
              else{
                print("User isn\'t choosing anything");
              }

            },
          )

        ],
      ),
    );
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