import 'dart:core';
import 'package:flutter/material.dart';
import 'package:ondevice/FirstTime.dart';
import 'DrawerScreen.dart';
import 'decodejson.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
// import 'package:flare_flutter/flare_actor.dart';
import 'package:rive/rive.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(Home());

class Home extends StatefulWidget {
  static const platform = const MethodChannel('ondeviceML');

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // TextEditingController texts = new TextEditingController();
  // List<int> inp = List();
  // bool offensive = false;
  // Color offensive_color = Colors.black;
  // String animationType = "haha";



  @override
  Widget build(BuildContext context) {
    // Here we initialize the class to convert text to amtrix in dart

    // Tokenize ondevice = Tokenize(5731, 'assets/buffer.json');


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
                LoginScreen(),
                // FirstTime(),
              ],
            ),

        )
    );
  }
}


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {



  // String pass = "admin";
  final riveFileName = 'assets/santa.riv';
  Artboard _artboard;
  String animationType = "idle";
  List<int> inp = List();
  SimpleAnimation _animation_idle;
  SimpleAnimation _animation_test;
  SimpleAnimation _animation_success;
  SimpleAnimation _animation_fail;

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;
  int setting = 2;

  void _playAnimation_idle(){
    try {
      _artboard.removeController(_animation_fail);
    }
    catch(e){
      print(e);
    }
    try {
      _artboard.removeController(_animation_success);
    }
    catch(e){
      print(e);
    }
    try {
      _artboard.removeController(_animation_test);
    }
    catch(e){
      print(e);
    }
    try {
      _artboard.addController(_animation_idle);
    }
    catch(e){
      print(e);
    }
  }

  void _playAnimation_test(){
    try {
      _artboard.removeController(_animation_fail);
    }
    catch(e){
      print(e);
    }
    try {
      _artboard.removeController(_animation_success);
    }
    catch(e){
      print(e);
    }
    try {
      _artboard.removeController(_animation_idle);
    }
    catch(e){
      print(e);
    }
    try {
      _artboard.addController(_animation_test);
    }
    catch(e){
      print(e);
    }
  }

  void _playAnimation_success(){
    // _artboard.removeController(_animation_fail);
    // _artboard.removeController(_animation_idle);
    // _artboard.removeController(_animation_test);
    // _artboard.addController(_animation_success);
    try {
      _artboard.removeController(_animation_fail);
    }
    catch(e){
      print(e);
    }
    try {
      _artboard.removeController(_animation_idle);
    }
    catch(e){
      print(e);
    }
    try {
      _artboard.removeController(_animation_test);
    }
    catch(e){
      print(e);
    }
    try {
      _artboard.addController(_animation_success);
    }
    catch(e){
      print(e);
    }
  }

  void _playAnimation_fail(){
    // _artboard.removeController(_animation_idle);
    // _artboard.removeController(_animation_success);
    // _artboard.removeController(_animation_test);
    // _artboard.addController(_animation_fail);
    try {
      _artboard.removeController(_animation_idle);
    }
    catch(e){
      print(e);
    }
    try {
      _artboard.removeController(_animation_success);
    }
    catch(e){
      print(e);
    }
    try {
      _artboard.removeController(_animation_test);
    }
    catch(e){
      print(e);
    }
    try {
      _artboard.addController(_animation_fail);
    }
    catch(e){
      print(e);
    }
  }
  // RiveAnimationController _idleController;
  // RiveAnimationController _testController;
  // RiveAnimationController _successController;
  // RiveAnimationController _failController;
  // RiveAnimationController _controller;

  final passwordController = TextEditingController();
  final passwordFocusNode = FocusNode();


  @override
  void initState() {
    // TODO: implement initState

    print("At the beginning");

    getSettingsPreference().then((value) {
      print(value);
      setting = value;
      print("settings variable is now");
      print(setting);
    });

    getFirstTimePreference().then((value) {
      if(value != 0){

        Navigator.of(context).pop();
        Navigator.push(context,
          MaterialPageRoute(builder: (context) => FirstTime()),);

        saveFirstTimePreference(0);

        print("saved FirstTime is now");
        print(value);

      }
      else{
        print("Not the first time");
      }
    });

    passwordFocusNode.addListener((){
      if(passwordFocusNode.hasFocus){
        setState(() {
          animationType="test";
          // _idleController.isActive = false;
          // _testController.isActive = true;
          // _successController.isActive = false;
          // _failController.isActive = false;
          // _controller = SimpleAnimation('test');

        });
        _playAnimation_test();
      }else{
        setState(() {
          animationType="idle";
          // _idleController.isActive = true;
          // _testController.isActive = false;
          // _successController.isActive = false;
          // _failController.isActive = false;
          // _controller = SimpleAnimation('idle');

        });
        _playAnimation_idle();
      }


    });

    print("About to call load Rive");

    _loadRiveFile();


    super.initState();
  }

  void _loadRiveFile() async {
    final bytes = await rootBundle.load(riveFileName);
    final file = RiveFile();

    print("File has loaded");

    if (file.import(bytes)) {
      // Select an animation by its name
      final artboard = file.mainArtboard;

      _animation_idle = SimpleAnimation('idle');
      _animation_test = SimpleAnimation('test');
      _animation_success = SimpleAnimation('success');
      _animation_fail = SimpleAnimation('fail');

      // artboard.addController(_idleController = SimpleAnimation('idle'));
      // artboard.addController(_testController = SimpleAnimation('test'));
      // artboard.addController(_successController = SimpleAnimation('success'));
      // artboard.addController(_failController = SimpleAnimation('fail'));
      artboard.addController(SimpleAnimation('idle'));
      // artboard.addController(SimpleAnimation('test'));
      // artboard.addController(SimpleAnimation('success'));
      // artboard.addController(SimpleAnimation('fail'));

      print(artboard.animations);
      //
      _playAnimation_idle();

      setState(() => _artboard = artboard);
    }
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


      child: SingleChildScrollView(
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
            height: 10,
          ),


          //space for teddy actor
          Center(
            child: Container(
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(blurRadius: 20, color: Colors.grey[600], spreadRadius: 5)],
                ),

                child: CircleAvatar(

                  radius: 125,
                  backgroundColor: Color(0xff5d0000),

                  child: CircleAvatar(
                    radius: 120,
                    child: ClipOval(
                      child: Rive(artboard: _artboard, alignment: Alignment.center, fit: BoxFit.contain,),
                    ),
                    backgroundColor: Colors.white,
                    ),


                ),

            ),
          ),


          //just for vertical spacing
          SizedBox(
            height: 30,
            width: 10,
          )    ,


          //container for textfields user name and password
          Container(
            height: 180,
            width: 350,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.grey[350],
                boxShadow: [BoxShadow(blurRadius: 30, color: Colors.grey, spreadRadius: 5)],
            ),

            child: Column(
              children: <Widget>[

                // TextFormField(
                //   decoration: InputDecoration(border: InputBorder.none, hintText: "User name", contentPadding: EdgeInsets.all(20)),
                // ),
                //
                // Divider(),

                TextFormField(
                  obscureText: false,
                  onChanged: (text) {
                    if(text ==""){
                      animationType = "idle";
                      _playAnimation_idle();
                      // setState(() {
                      //   _controller = SimpleAnimation('idle');
                      // });
                    }
                    else{
                      animationType = "test";
                      _playAnimation_test();
                      // setState(() {
                      //   _controller = SimpleAnimation('test');
                      // });
                    }
                  },
                  decoration: InputDecoration(border: InputBorder.none, hintText: "Ho ho ho! What did you do this year?", contentPadding: EdgeInsets.all(20)),
                  controller: passwordController,
                  focusNode: passwordFocusNode,
                ),

              ],
            ),
          ),

          //container for raised button
          Container(
            width: 350,
            height: 70,
            padding: EdgeInsets.only(top: 20),
            child: RaisedButton(
                color: Color(0xff600000),
                child: Text("Post letter!", style: TextStyle(color: Colors.white),),

                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30),
                ),
                onPressed: () {
                  // if(passwordController.text.compareTo(pass) == 0){
                  //   setState(() {
                  //     animationType = "success";
                  //   });
                  //
                  // }else{
                  //   setState(() {
                  //     animationType = "fail";
                  //   });
                  //
                  // }

                  getSettingsPreference().then((value) {
                    print(value);
                    setting = value;
                    print("settings variable is now");
                    print(setting);
                  });


                  if (setting != 0) {
                    print("Reached here and the value of setting was");
                    print(setting);
                    Tokenize ondevice = Tokenize(5731, 'assets/buffer.json');
                    ondevice.getTokenized(passwordController.text).then((value) {inp = value; print(inp);}).then((_) { _getPredictData().then((data) {setState(() {});});});
                  }
                  else{
                    print("Reached here and the value of setting was");
                    print(setting);
                    animationType = "success";
                    _playAnimation_success();
                    setState(() {});
                  }

                },
            ),
          ),
            Container(
              width: 350,
              height: 100,
            )


        ],
      )
      ),
    );
  }

  Future<void> _getPredictData() async {
    try {
      final String result =
      await Home.platform.invokeMethod('predictData', {"arg": inp});
      if (result == "1") {
        // offensive_color = Colors.green;
        animationType = "success";
        // _idleController.isActive = false;
        // _testController.isActive = false;
        // _successController.isActive = true;
        // _failController.isActive = false;
        // setState(() {
        //   _controller = SimpleAnimation('success');
        // });
        _playAnimation_success();

      } else {
        // offensive_color = Colors.red;
        animationType = "fail";
        // _idleController.isActive = false;
        // _testController.isActive = false;
        // _successController.isActive = false;
        // _failController.isActive = true;
        // setState(() {
        //   _controller = SimpleAnimation('fail');
        // });
        _playAnimation_fail();
      }
    } on PlatformException catch (e) {

      print(e.message);
    }
  }

}

Future<int> getSettingsPreference() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int storedSetting = prefs.getInt("setting");
  return storedSetting;
}

Future<int> getFirstTimePreference() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int storedSetting = prefs.getInt("FirstTime");
  return storedSetting;
}

Future<void> saveFirstTimePreference(int setting) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt("FirstTime", setting);
}
