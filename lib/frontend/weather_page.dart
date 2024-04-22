import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.orange,
      body: SafeArea(
        bottom: false,
        child: Container(
            height: double.infinity,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment(0.8, 1.5),
                        colors: <Color>[
                          Color.fromARGB(255, 254, 199, 143),
                          Color(0xfff39060),
                          Color.fromARGB(255, 86, 88, 177),
                          Color.fromARGB(255, 75, 84, 211),
                          Color.fromARGB(255, 1, 37, 245),
                        ],
                        tileMode: TileMode.mirror,
                      ),
                    ),
          child: const Column(children: [
                        Text(
                          'Muar',
                          style: TextStyle(color: Colors.white,  fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20,),
                        Text(
                          'Cloud',
                          style: TextStyle(color: Colors.white,  fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20,),
                        Text(
                          "17°C",
                          style: TextStyle(color: Colors.white,  fontWeight: FontWeight.bold),
                        ),
                       
              
          ],),
        ),
      )
    );
  }
}