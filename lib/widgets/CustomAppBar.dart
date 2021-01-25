import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget{
  final AssetImage leading ;
  final String title  ;
  final bool back ;
  final bool dialog ;
  CustomAppBar({this.leading = const AssetImage("assets/icons/home.png"), this.title ="Home", this.back = false, this.dialog = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: dialog == false ? 100 : 64,
      color: Colors.white.withOpacity(.8),
      child: Container(
        margin: EdgeInsets.only(top: dialog ==false ? 36 : 8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              padding: dialog? EdgeInsets.only(left: 22, right: 22):EdgeInsets.only(top:25, right: 21, left: 22, bottom: 25),
              child: GestureDetector(
                onTap: (){
                  if(back != null && back == true )
                    Navigator.pop(context);
                  },
                child: Image(image: leading, width: 22, height: 15, fit: BoxFit.cover,))) ,
              Text("$title", style: TextStyle(color: Color(0xff8834D0), fontSize: 20, fontWeight: FontWeight.w500),)
          ],
        ),
      ),
    ) ;

  }

}