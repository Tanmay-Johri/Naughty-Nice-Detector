// // import 'dart:html';
//
// import 'package:flutter/material.dart';
//
// class DrawerScreen extends StatefulWidget {
//   @override
//   _DrawerScreenState createState() => _DrawerScreenState();
// }
//
// class _DrawerScreenState extends State<DrawerScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: const Color(0xff5d0000),
//       padding: EdgeInsets.only(top: 40, left: 20),
//
//       child: Column(
//
//         children: [
//           Row(
//             children : [
//               Text('HO HO HO!',
//               textScaleFactor: 2,
//               style: TextStyle(
//                 color: Colors.grey[400],
//               )
//             ),],
//           ),
//
//         ],
//       ),
//
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:ondevice/ChatScreen.dart';
import 'package:ondevice/ProfileScreen.dart';
import 'package:ondevice/SettingsPage.dart';
// import 'package:ondevice/GameScreen.dart';
import 'package:ondevice/main.dart';
// import 'configuration.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff500000),
      padding: EdgeInsets.only(top:40,bottom: 30,left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: AssetImage('assets/anonymousDP.jpg'),
              ),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('John Doe', textScaleFactor: 1.8 ,style: TextStyle(color: Colors.grey[350]),),
                  Row(
                    children: [
                      Icon(Icons.circle, color: Colors.green[800], size: 15,),
                      Text(' Online',style: TextStyle(color: Colors.grey[350])),
                    ],
                  )
                ],
              )
            ],
          ),

          Column(
            // children: drawerItems.map((element) => Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Row(
            //     children: [
            //       Icon(element['icon'],color: Colors.white,size: 30,),
            //       SizedBox(width: 10,),
            //       Text(element['title'],style: TextStyle(color: Colors.white,fontSize: 20))
            //     ],
            //
            //   ),
            // )).toList(),
            children: [
              Row(
                children: [
                  IconButton(icon: Icon(Icons.account_circle_rounded, color: Colors.grey,), iconSize: 50 ,onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()),);
                  }, ),
                  Text('Profile',
                  textScaleFactor: 1.4,
                  style: TextStyle(color: Colors.grey[350]),),
                ],
              ),

              Row(
                children: [
                  IconButton(icon: Icon(Icons.settings, color: Colors.grey,), iconSize: 50 ,onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SettingsPage()),);
                  }, ),
                  Text('Settings',
                    textScaleFactor: 1.4,
                    style: TextStyle(color: Colors.grey[350]),),
                ],
              ),

              Row(
                children: [
                  IconButton(icon: Icon(Icons.info_outline_rounded, color: Colors.grey,), iconSize: 50 ,onPressed: null, ),
                  Text('Tips',
                    textScaleFactor: 1.4,
                    style: TextStyle(color: Colors.grey[350]),),
                ],
              ),

              Row(
                children: [
                  IconButton(icon: Icon(Icons.assignment_ind, color: Colors.grey,), iconSize: 50 ,onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Home()),);
                  }, ),
                  Text('Naughty/Nice',
                    textScaleFactor: 1.4,
                    style: TextStyle(color: Colors.grey[350]),),
                ],
              ),

              // Row(
              //   children: [
              //     IconButton(icon: Icon(Icons.gamepad, color: Colors.grey,), iconSize: 50 ,onPressed: () {
              //       Navigator.of(context).pop();
              //       Navigator.push(context,
              //         MaterialPageRoute(builder: (context) => GameScreen()),);
              //     }, ),
              //     Text('Mini-Game',
              //       textScaleFactor: 1.4,
              //       style: TextStyle(color: Colors.grey[350]),),
              //   ],
              // ),

              Row(
                children: [
                  IconButton(icon: Icon(Icons.chat_rounded, color: Colors.grey,), iconSize: 50 ,onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChatScreen()),);
                  } ),
                  Text('Chat with Santa',
                    textScaleFactor: 1.4,
                    style: TextStyle(color: Colors.grey[350]),),
                ],
              ),

            ],
          ),

          Row(
            children: [
              IconButton(icon: Icon(Icons.ac_unit_sharp, color: Colors.grey,), iconSize: 50, onPressed: null,),
              // SizedBox(width: 10,),
              // Text('Settings',style:TextStyle(color: Colors.white),),
              // SizedBox(width: 10,),
              // Container(width: 2,height: 20,color: Colors.white,),
              // SizedBox(width: 10,),
              Text('About', textScaleFactor: 1.4 ,style:TextStyle(color: Colors.grey[350]),)


            ],

          )


        ],
      ),

    );
  }
}