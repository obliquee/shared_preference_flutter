import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 String _haveStarted3Times = '';

 @override
 void initState(){
   super.initState();
   _incementStartup();
 }

 //Will get the startupnumber from shared_preferences
 //will return 0 if null
 Future<int> _getIntFromSharedPref() async{
   final prefs = await SharedPreferences.getInstance();
   final startupNumber = prefs.getInt('startupNumber'); //
   if(startupNumber == null){
     return 0;
   }
   return startupNumber;
 }

 ///Reset the counter in shared_preferences to 0
 Future<void> _resetCounter() async{
   final prefs = await SharedPreferences.getInstance();
   await prefs.setInt('startupNumber',0);
 
 } 

 //Will Incremnt the startup number and store it then
 //use setState to display in the UI
 Future<void> _incementStartup() async{
   final prefs = await SharedPreferences.getInstance();

   int lastStartupNumber = await _getIntFromSharedPref();
   int currentStartupNumber = ++lastStartupNumber;

   await prefs.setInt('startupNumber', currentStartupNumber);

   if(currentStartupNumber == 3){
     setState(() => _haveStarted3Times = '$currentStartupNumber Times Completed');
   
    //Reset only if you want to
    await _resetCounter();
   }else{
     setState(() => _haveStarted3Times = '$currentStartupNumber Times started the app');
   }
 }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        
        title: Text(widget.title),
      ),
      body: Center(
        child: Text('$_haveStarted3Times'),
      ),
      
    );
  }
}
