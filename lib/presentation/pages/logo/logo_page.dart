import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LogoPage extends StatelessWidget {
  const LogoPage({super.key});

  @override
  Widget build(BuildContext context){
     return Scaffold(
      backgroundColor:Color(0xFFFFFFFF),
      body:Center(

        child:const Image(
          alignment: Alignment.center,
          width: 274,
          height:251,
          image: AssetImage('Images/PCNCLogo.png'), ),)
     );

  }
  
}