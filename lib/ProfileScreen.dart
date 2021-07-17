import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'DrawerScreen.dart';
// import 'SettingsPage.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

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
              ProfileScreenBuild()
            ],
          ),

        )
    );
  }
}

class ProfileScreenBuild extends StatefulWidget {
  @override
  _ProfileScreenBuildState createState() => _ProfileScreenBuildState();
}


class _ProfileScreenBuildState extends State<ProfileScreenBuild> {

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;

  bool showPassword = false;
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
              height: 30,
            ),

            Text(
              "Edit Profile",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0, 10))
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/anonymousDP.jpg'),
                        )),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          color: Color(0xff550000),
                        ),
                        child: IconButton(icon: Icon(Icons.edit, color: Colors.white), iconSize: 15 ,onPressed: null,),

                        ),
                      ),
                ],
              ),
            ),
            SizedBox(
              height: 35,
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(25,0,25,0),
              child: Text(
                "johndoe@gmail.com",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

            ),

            SizedBox(
              height: 35,
            ),

            Padding(padding: const EdgeInsets.fromLTRB(25,0,25,0) ,child: buildTextField("Full Name", "John Doe", false)),
            Padding(padding: const EdgeInsets.fromLTRB(25,0,25,0) ,child: buildTextField("Home Location", "Earth", false)),

            SizedBox(
              height: 65,
            ),

            Container(
              height: 50,
              child: Center(child: RaisedButton(
                onPressed: () {},
                color: Color(0xff5d0000),
                padding: EdgeInsets.symmetric(horizontal: 50),
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "LOG-OUT",
                  style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 2.2,
                      color: Colors.white),
                ),

              ),),
            ),

            Container(
              height: 50,
              child: Center(child: RaisedButton(
                onPressed: () {},
                color: Color(0xff5d0000),
                padding: EdgeInsets.symmetric(horizontal: 50),
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "CHANGE PASSWORD",
                  style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 2.2,
                      color: Colors.white),
                ),

              ),),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0,15, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RaisedButton(
                    color: Color(0xff550000),
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {},
                    child: Text("CANCEL",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.white)),
                  ),
                  RaisedButton(
                    onPressed: () {},
                    color: Color(0xff550000),
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
            ),

            SizedBox(
              height: 55,
            ),

          ],
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
              onPressed: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
              icon: Icon(
                Icons.remove_red_eye,
                color: Colors.grey,
              ),
            )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}