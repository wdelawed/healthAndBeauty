import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget{
  AssetImage leading = AssetImage("assets/icons/home.png");
  String title ="Home" ;
  bool back ;
  bool dialog ;
  CustomAppBar({this.leading, this.title, this.back, this.dialog}){
    if(leading == null)
      leading = AssetImage("assets/icons/home.png");
    if(title == null)
      title ="Home";
    if(dialog == null)
      dialog = false ;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: dialog == false ? 100 : 64,
      color: Colors.white,
      child: Container(
        margin: EdgeInsets.only(top: dialog ==false ? 36 : 8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: EdgeInsets.only(left: 22, right: 21),
              child: GestureDetector(
                onTap: (){if(back != null && back == true )Navigator.pop(context);},
                child: Image(image: leading, width: 22, height: 15, fit: BoxFit.cover,))) , 
              Text("$title", style: TextStyle(color: Color(0xff8834D0), fontSize: 20, fontWeight: FontWeight.w500),) 
          ],
        ),
      ),
    ) ;

  }

}