import 'package:flutter/material.dart';

class Loadding extends StatefulWidget {
  const Loadding({super.key});

  @override
  State<Loadding> createState() => _LoaddingState();
}

class _LoaddingState extends State<Loadding> {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator();
  }
}
