import 'package:HealthAndBeauty/bloc/app_bloc.dart';
import 'package:HealthAndBeauty/home.dart';
import 'package:HealthAndBeauty/persistence/respository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  debugPaintSizeEnabled = false;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppBloc _appBloc = AppBloc(Repository()) ;

  @override
  void dispose(){
    super.dispose();
    _appBloc.close();
  }

  @override
  void initState(){
    super.initState();
    _appBloc.add(AppInitEvent()) ;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
      lazy: false,
      create: (context)=> _appBloc,
      child: MaterialApp(
        title: 'Health and Beauty',
        theme: ThemeData(
          
          accentColor: Colors.white,
          fontFamily: "SfUi",
          primarySwatch: Colors.deepPurple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              TargetPlatform.android: ZoomPageTransitionsBuilder(),
              TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
              TargetPlatform.windows: ZoomPageTransitionsBuilder(),
              TargetPlatform.linux: ZoomPageTransitionsBuilder(),
              TargetPlatform.macOS: ZoomPageTransitionsBuilder(),

            },
          ),
        ),
        home: HomePage(),
      ),
    );
  }
}
