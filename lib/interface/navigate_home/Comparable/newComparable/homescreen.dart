import 'package:flutter/material.dart';


class Homecomparable extends StatefulWidget {
  const Homecomparable({super.key});

  @override
  State<Homecomparable> createState() => _HomecomparableState();
}

class _HomecomparableState extends State<Homecomparable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
             TextButton(onPressed: (){
            Navigator.pushNamed(context, 'new');
          }, child: Text("New Comparable")),
          TextButton(onPressed: (){
            Navigator.pushNamed(context, 'old');
          }, child: Text("Old Comparable")),
          ],
         )
          
        ],
      ),
    );
  }
}