import 'package:flutter/material.dart';
void main(){
  runApp(AnimatedApp());
}
class AnimatedApp extends StatelessWidget{
@override
Widget build(BuildContext context){
  return MaterialApp(
    home:AnimationDemo(),

  );
}
}
class AnimationDemo extends StatefulWidget{
  @override
  _AnimationDemoState createState()=>_AnimationDemoState();
}
class _AnimationDemoState extends State<AnimationDemo>
with SingleTickerProviderStateMixin{
  AnimationController?_controller;
  Animation<Offset>?_slideAnimation;
  bool _visible=true;
  @override
  void initState(){
    super.initState();
_controller=AnimationController(
  duration:const Duration(seconds:2),
  vsync:this,
);
_slideAnimation=Tween<Offset>(
  begin:Offset(0,-1),
  end:Offset(0,0),

).animate(CurvedAnimation(
  parent:_controller!,
  curve:Curves.easeInOut,
));
  }
  @override
  void dispose(){
    _controller!.dispose();
    super.dispose();
  }
  void _animated(){
    setState((){
      _visible=!_visible;
    });
    if(_visible){
      _controller!.forward();
    }else{
      _controller!.reverse();
    }
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(title:Text('Fade &Slide Animation')),
      body:Center(
        child:Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children:[
            SlideTransition(
              position:_slideAnimation!,
              child:AnimatedOpacity(
                opacity:_visible ? 1.0:0.0,
                duration:Duration(seconds:2),
                child:Container(
                  width:200,
                  height:200,
                  color:Colors.blue,
                  child:Center(
                    child:Text(
                      'Slide & Fade',
                      style:TextStyle(color:Colors.white,fontSize:20),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height:20),
            ElevatedButton(
              onPressed: _animated,
              child:Text(_visible ?'Hide':'Show'),
            ),
          ],
        ),
      ),
    );
  }
  }
  
  
