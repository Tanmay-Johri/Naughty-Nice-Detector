import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'DrawerScreen.dart';
import 'decodejson.dart';
import 'dart:convert';
import 'dart:core';
import 'dart:math';


class ChatScreen extends StatefulWidget {
  static const platform = const MethodChannel('ondeviceML');
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

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
              ChatScreenBuild()
            ],
          ),

        )
    );
  }
}

class ChatScreenBuild extends StatefulWidget {
  @override
  _ChatScreenBuildState createState() => _ChatScreenBuildState();
}

class _ChatScreenBuildState extends State<ChatScreenBuild> {

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;
  String reply = "Hello kid!";
  List<int> inp = [];
  String index_str = "500";
  int index = 500;
  var meta_responses = [];
  var convos = [];

  final passwordController = TextEditingController();
  ScrollController _scrollController = new ScrollController();
  // final passwordFocusNode = FocusNode();



  sendMessage(String mess, String sent, int dur){
    Map<String, String> messageMap = {
      "message" : mess,
      "sentBy" : sent,
    };
    convos.add(messageMap);

    // Future.delayed(Duration(milliseconds: dur), () {
    //
    //
    //   setState(() {
    //     // Here you can write your code for open new view
    //   });
    //
    // });
    setState(() {});
    print("This is all about convos");
    print(convos);
  }

  // Widget chatMessagesList(){
  //
  //   return (convos.length != 0)?ListView.builder(
  //     itemCount: convos.length,
  //     itemBuilder: (context, index) {
  //       print("convos[index][\"message\"]");
  //       print(convos[index]["message"]);
  //       print("convos[index][\"sentBy\"]");
  //       print(convos[index]["sentBy"]);
  //
  //       return MessageTile(convos[index]["message"], convos[index]["sentBy"]);
  //     },
  //   ): Container(
  //     child: Text("Length"),
  //   );
  // }

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


      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
            // Container(
            //   child: Text("Length2 above"),
            // ),

            // (convos.length==0)?Container(
            //
            //
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.all(4.0),
            //         child: Text("Talk to Santa Claus!", textScaleFactor: 2,),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(4.0),
            //         child: Text("Number of messages left before refill = 10", textScaleFactor: 1.2,),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(4.0),
            //         child: Text("Ask him about the elves", textScaleFactor: 1.2,),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(4.0),
            //         child: Text("Ask him where he lives", textScaleFactor: 1.2,),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(4.0),
            //         child: Text("Ask him if you're on the naughty list", textScaleFactor: 1.2,),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(4.0),
            //         child: Text("Ask him the names of his reindeers", textScaleFactor: 1.2,),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(4.0),
            //         child: Text("Ask him his age", textScaleFactor: 1.2,),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(4.0),
            //         child: Text("Ask him if about your wishlist!", textScaleFactor: 1.2,),
            //       ),
            //
            //       // Text("Number of messages left before refill = 10"),
            //     ],
            //   ),
            // ):Container(),
            //


            Flexible(
                child: ListView.builder(
                  controller: _scrollController,
                    // reverse: true,
                    shrinkWrap: true,
                    itemCount: convos.length,
                    itemBuilder: (context, index) => MessageTile(convos[index]["message"].toString(), convos[index]["sentBy"])
                )
            ),
            // chatMessagesList(),
            // (convos.length != 0)?ListView.builder(
            //   itemCount: convos.length,
            //   itemBuilder: (context, index) {
            //     print("convos[index][\"message\"]");
            //     print(convos[index]["message"]);
            //     print("convos[index][\"sentBy\"]");
            //     print(convos[index]["sentBy"]);
            //
            //     return Text("data");
            //     // return MessageTile(convos[index]["message"].toString(), convos[index]["sentBy"].toString());
            //   },
            // ): Container(
            //   child: Text("Length"),
            // ),
            // Flexible(child: Container()),
            // Flexible(child: Container()),
            Container(
              alignment: Alignment.bottomCenter,


              child: Container(
                width: 350,
                // color: Colors.grey[350],
                decoration: BoxDecoration(
                  color: Colors.grey[350],
                  borderRadius: BorderRadius.circular(40),
                  // boxShadow: [BoxShadow(blurRadius: 20, color: Color(0xff450000), spreadRadius: 10)],
                ),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  children: [
                    Flexible(
                      child: TextField(
                        controller: passwordController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Message Santa!",
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          border: InputBorder.none
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {

                        FocusScopeNode currentFocus = FocusScope.of(context);

                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }

                        _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent,
                          curve: Curves.easeOut,
                          duration: const Duration(milliseconds: 300),
                        );

                        if (passwordController.text.isNotEmpty) {

                          sendMessage(passwordController.text, "user", 0);
                          sendMessage("...typing...", "Santa", 0);
                          Tokenize ondevice = Tokenize(50, 'assets/buffer_chat.json');
                          ondevice.getTokenized(passwordController.text, tenseCorrection: false).then((value) {inp = value; print(inp);}).then((_) { _getPredictChat().then((data) {setState(() {});});});

                        }
                        else{
                          print("Empty message");
                        }
                        print(convos[0]["message"]);
                        print(convos[0]["sentBy"]);
                        print(convos.length);
                        passwordController.clear();
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0x36FFFFFF),
                              const Color(0x0FFFFFFF)
                            ]
                          ),
                          borderRadius: BorderRadius.circular(40)
                        ),
                        padding: EdgeInsets.all(12),
                        child: Icon(Icons.send_rounded, color: Color(0xFF550000),),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

    //   child: SingleChildScrollView(
    //     child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: <Widget>[
    //
    //       SizedBox(
    //       height: 30,
    //       // width: 200,
    //       ),
    //
    //       //just for vertical spacing
    //
    //       Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         isDrawerOpen?IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.red[900],), onPressed: () {
    //         setState(() {
    //           xOffset = 0;
    //           yOffset = 0;
    //           scaleFactor = 1;
    //           isDrawerOpen = false;
    //         });
    //         }):
    //         IconButton(icon: Icon(Icons.menu , color: Colors.red[900]) , onPressed: () {
    //           setState(() {
    //             xOffset = 180;
    //             yOffset = 70;
    //             scaleFactor = 0.8;
    //             isDrawerOpen = true;
    //           });
    //         }),
    //         Text('Naughty or Nice?',
    //           textScaleFactor: 1.5,
    //           style: TextStyle(
    //           color: Colors.red[900],
    //           ),),
    //         SizedBox(
    //           height: 30,
    //           width: 30,
    //           ),
    //         ],
    //
    //       )    ,
    //
    //       SizedBox(
    //         height: 30,
    //       ),
    //
    //       Container(
    //         height: 180,
    //         width: 350,
    //         decoration: BoxDecoration(
    //           borderRadius: BorderRadius.all(Radius.circular(20)),
    //           color: Colors.grey[350],
    //           boxShadow: [BoxShadow(blurRadius: 30, color: Colors.grey, spreadRadius: 5)],
    //         ),
    //
    //         padding: EdgeInsets.all(20),
    //
    //         child: Text(
    //           reply,
    //           // obscureText: false,
    //           // decoration: InputDecoration(border: InputBorder.none, hintText: "Talk to Santa!", contentPadding: EdgeInsets.all(20)),
    //           // controller: passwordController,
    //           // focusNode: passwordFocusNode,
    //         ),
    //       ),
    //
    //       SizedBox(
    //         height: 30,
    //       ),
    //
    //       Container(
    //         height: 180,
    //         width: 350,
    //         decoration: BoxDecoration(
    //           borderRadius: BorderRadius.all(Radius.circular(20)),
    //           color: Colors.grey[350],
    //           boxShadow: [BoxShadow(blurRadius: 30, color: Colors.grey, spreadRadius: 5)],
    //         ),
    //
    //         child: TextFormField(
    //           obscureText: false,
    //           decoration: InputDecoration(border: InputBorder.none, hintText: "Talk to Santa!", contentPadding: EdgeInsets.all(20)),
    //           controller: passwordController,
    //           // focusNode: passwordFocusNode,
    //
    //         ),
    //       ),
    //
    //       Container(
    //         width: 350,
    //         height: 70,
    //         padding: EdgeInsets.only(top: 20),
    //         child: RaisedButton(
    //           color: Colors.red[900],
    //           child: Text("Send message!", style: TextStyle(color: Colors.white),),
    //
    //           shape: RoundedRectangleBorder(
    //             borderRadius: new BorderRadius.circular(30),
    //           ),
    //           onPressed: () {
    //             // if(passwordController.text.compareTo(pass) == 0){
    //             //   setState(() {
    //             //     animationType = "success";
    //             //   });
    //             //
    //             // }else{
    //             //   setState(() {
    //             //     animationType = "fail";
    //             //   });
    //             //
    //             // }
    //             Tokenize ondevice = Tokenize(50, 'assets/buffer_chat.json');
    //             // print(ondevice.getTokenized(passwordController.text, tenseCorrection: false).then((value) {
    //             //   List<int> inp = value;
    //             //   print("This is the then output (inp)");
    //             //   print(inp);
    //             //   // _getChatReply
    //             //   try {
    //             //     index_str = await ChatScreen.platform.invokeMethod('predictDataChat', {"arg": inp});
    //             //   }
    //             //   catch(e){
    //             //     print(e);
    //             //   }
    //             // }
    //             //   )
    //             // );
    //             ondevice.getTokenized(passwordController.text, tenseCorrection: false).then((value) {inp = value; print(inp);}).then((_) { _getPredictChat().then((data) {setState(() {});});});
    //
    //
    //           },
    //         ),
    //       ),
    //
    //       SizedBox(
    //         height: 600,
    //       )
    // ],
    // ),
    //   )
    );

  }

  Future<String> _loadCrosswordAsset() async {
    return await rootBundle.loadString('assets/intents.json');
  }

  Future loadCrossword() async {
    String jsonCrossword = await _loadCrosswordAsset();
    // print(jsonCrossword);
    _parseJsonForCrossword(jsonCrossword);
  }

  void _parseJsonForCrossword(String jsonString) {
    Map decoded = jsonDecode(jsonString);
    for (var structure in decoded['intents']) {
      print(structure['responses']);
      meta_responses.add(structure['responses']);
      // print(structure['word']);
    }

    print("meta responses");

    print(meta_responses);
  }



  Future<void> _getPredictChat() async {
    try {
      final String result =
      await ChatScreen.platform.invokeMethod('predictDataChat', {"arg": inp});

      await loadCrossword();

      index = int.parse(result);

      print("index");
      print(index);


      final _random = new Random();
      var list = meta_responses[index];

      print("list");
      print(list);

      // generate a random index based on the list length
      // and use it to retrieve the element
      var element = list[_random.nextInt(list.length)];
      print("element");
      print(element);

      reply = element;
      Future.delayed(const Duration(milliseconds: 1000), () {
        convos.removeLast();
        sendMessage(reply, "Santa", 5000);
      });



    } on PlatformException catch (e) {

      print(e.message);
    }
  }

  Widget MessageTile(String messageFun, String sentByFun){
    return (convos.length > 0) ?
        Container(

          padding: EdgeInsets.symmetric(horizontal: 15),
          margin: EdgeInsets.symmetric(vertical: 4),
          width: MediaQuery.of(context).size.width,
          alignment: (sentByFun == "user")? Alignment.centerRight : Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: (sentByFun == "user")?MainAxisAlignment.end:MainAxisAlignment.start,
            children: [

              (sentByFun != "user")?Container(
                padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/Santa.jpg'),
                ),
              ):Container(),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                    // boxShadow: [BoxShadow(blurRadius: 4, color: Colors.red, spreadRadius: 0.3)],
                  gradient: LinearGradient(
                    colors: (sentByFun == "user")?[
                      const Color(0xFFc00000),
                      const Color(0xFF300000)
                    ]:[
                      Colors.grey[900],
                      Colors.grey[600],
                    ],
                  ),
                  borderRadius: (sentByFun == "user")? BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft : Radius.circular(23),
                  ) :
                  BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight : Radius.circular(23),
                  )

                ),
                child: Text(messageFun, style: TextStyle(
                  color: Colors.white
                )),
              ),
              (sentByFun == "user")?Container(
                padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/anonymousDP.jpg'),
                ),
              ):Container(),
            ],
          )
      )
        :Container();
  }

}

// class MessageTile extends StatelessWidget {
//
//   final String messageFinal;
//   final String userFinal;
//   MessageTile(this.messageFinal, this.userFinal);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Text(messageFinal),
//     );
//   }
// }
