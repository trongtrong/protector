




import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_protector/flutter_protector.dart';
import 'package:flutter_protector_example/security/info_device.dart';
import 'package:flutter_protector_example/security/info_result.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  Color colorPrime = Colors.blueGrey;
  final ptx = FlutterProtector();
  int countProblem = 0;
  Color private = Colors.red;


  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _homeView());

  }


  Widget _homeView(){
    return 
       Column(
        children: [
          _header(),
          Expanded(child: _content())
        ],
      );
  }


  Widget _header(){
    return Container(
      width: double.maxFinite,
      height: MediaQuery.sizeOf(context).height * .35,
      padding: EdgeInsets.only(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width * .25,
            height: MediaQuery.sizeOf(context).width * .25,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(150)
            ),
            child: Stack(
              children: [
                Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  decoration: BoxDecoration(
                      color:  colorPrime.withAlpha(40),
                      borderRadius: BorderRadius.circular(150)
                  ),
                  child: Icon(Icons.shield,size: 65,color: colorPrime,),
                ),
                Container(width: double.maxFinite,height: double.maxFinite,
                child: (colorPrime == Colors.blueGrey) ? CircularProgressIndicator(
                  strokeWidth: 1.8,
                  color: colorPrime,
                ) : SizedBox.shrink(),
                )
              ],
            )
          ),
          SizedBox(height: 15,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "PuzzleTak Protector",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              if(countProblem >= 2) Text(
                " $countProblem",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: colorPrime
                ),
              )
            ],
          ),
          SizedBox(height: 5),
          Text(
            (colorPrime == Colors.blueGrey) ? "Loading..." : (colorPrime == Colors.red)
                ? "This is an emulator. Please use a real device."
                : "Device is Real :)",
            style: TextStyle(
              fontSize: 13,
            ),
          ),

          SizedBox(height: 5,),
          TextButton(
              style: TextButton.styleFrom(
                backgroundColor: colorPrime,
                padding: EdgeInsets.symmetric(horizontal: 20),
                foregroundColor: Colors.white

              ),
              onPressed: (){
                setState(() {
                  colorPrime  = Colors.blueGrey;
                  countProblem= 0;
                });
                Timer(Durations.extralong4, () => init.call(),);
              }, child: Text("Check Security",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),))
        ],
      ),
    );
  }
  Widget _content(){
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 30,),
        _button(
          call: () {Navigator.push(context, MaterialPageRoute(builder: (context) => InfoResult(),));},
          color: colorPrime,
          content: (colorPrime == Colors.red)
              ? "This is an emulator. Please use a real device."
              : "Real device detected. Proceeding with the operation.",
          title: (colorPrime == Colors.blueGrey)
              ? "Checking device status..."
              : "Check device status",
        ),


          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 18,vertical: 10),
            child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: private,width: 0.5),
                    padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                    shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10))
                ),
                onPressed: () async {
                  if(private == Colors.red) {
                    private = Colors.green;
                  } else {
                    private = Colors.red;
                  }
                  print((private == Colors.green));
                  await ptx.screenshotSecurity((private == Colors.green));
                  setState(() {});
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.maxFinite,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Security: Disable Screenshot",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: private
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text("Private Screen ${(private == Colors.green)}",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 30,child: Icon(Icons.arrow_forward_ios,color: Colors.blueGrey.shade200,),)
                  ],
                )),
          ),

          _button(
            call: () {Navigator.push(context, MaterialPageRoute(builder: (context) => InfoDevice(),));},
            color: Colors.black,
            content: "Show All Device Information",
            title: "Device Info",
          ),

        ],
      ),
    );
  }

  Widget _button({String? title,String? content,required VoidCallback call,required Color color }){
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 18,vertical: 10),
      child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.white,
            side: BorderSide(color: color,width: 0.5),
            padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
            shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10))
          ),
          onPressed: call,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          color: color
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text(content!,
                        style: TextStyle(
                            fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w300
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 30,child: Icon(Icons.arrow_forward_ios,color: Colors.blueGrey.shade200,),)
            ],
          )),
    );
  }


  @override
  void initState() {
    super.initState();
    init();
  }


  init() async {
    final checkEmulaturs = await ptx.screenshotSecurity(false);
    final checkEmulatur = await ptx.isEmulatorSuper();
    colorPrime = checkEmulatur! ? Colors.red : Colors.green;
    final _countProblem = await ptx.checkResultSecurity();
    countProblem = _countProblem!;
    setState(() {

    });
  }


}
