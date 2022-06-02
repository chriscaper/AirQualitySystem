import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:syncfusion_flutter_gauges/gauges.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Air Quality Management',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage("0","0","0","0","0",title: 'Air Quality Management System'),

    );
  }
}

class MyHomePage extends StatefulWidget {
   MyHomePage(this.mq6, this.mq135, this.pm, this.humid, this.temp,{Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  String mq6;
  String mq135;
  String pm;
  String temp;
  String humid;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> _getData() async {
    var url = Uri.parse("https://api.thingspeak.com/channels/1752477/feeds.json?api_key=2HUOZFIFSHU4M6V9&results=2");

    while(true){
      var result = await http.get(url);
      print(result);
      Map<String, dynamic> feeds = jsonDecode(result.body);
      print(result.body);
      Map<String, dynamic> fields = feeds["feeds"][0];
      print(fields);
      setState(() {
        widget.mq6 = fields["field1"];
        widget.mq135 = fields["field2"];
        widget.pm = fields["field3"];
        widget.humid = fields["field4"];
        widget.temp = fields["field5"];
      });
      print(widget.mq6);
      print(widget.mq135);
      print(widget.pm);
      print(widget.humid);
      print(widget.temp);


      //sleep(Duration(seconds:10));
    }
  }




  @override
  void initState(){
    super.initState();
    _getData();
  }



  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title), centerTitle: true,
      ),
      body:  SingleChildScrollView(child:
      Center(
        child: Column(
          children:  [
            const SizedBox(
              height: 20,
            ),
            Container(
              child: SfRadialGauge(
                  axes: <RadialAxis>[RadialAxis(  interval: 10,
                      startAngle: 0, endAngle: 360, showTicks: false,
                      showLabels: false,
                      axisLineStyle: const AxisLineStyle(thickness: 20),
                      pointers:  <GaugePointer>[RangePointer(value: double.parse(widget.temp),
                          width: 20, color: Color(0xFFFFCD60),
                          enableAnimation: true,
                          cornerStyle: CornerStyle.bothCurve)],
                      annotations: <GaugeAnnotation>[
                        GaugeAnnotation(widget: Column(children: <Widget>[Container(
                            width: 50.00 ,
                            height:  50.00,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: ExactAssetImage('assets/weather.png'),
                                fit: BoxFit.fitHeight,
                              ),
                            )),
                          Padding(padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
                            child: Text('Temperature\n         ' + widget.temp + "\u2103",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25)),)
                        ],) , angle: 270, positionFactor: 0.1)]
                  )]),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              child: Center(
                  child: SfRadialGauge(
                  axes: <RadialAxis>[RadialAxis(  interval: 10,
                      startAngle: 0, endAngle: 360, showTicks: false,
                      showLabels: false,
                      axisLineStyle: const AxisLineStyle(thickness: 20),
                      pointers:  <GaugePointer>[RangePointer(value: double.parse(widget.humid),
                          width: 20, color: Color(0xFFFFCD60),
                          enableAnimation: true,
                          cornerStyle: CornerStyle.bothCurve)],
                      annotations: <GaugeAnnotation>[
                        GaugeAnnotation(widget: Column(children: <Widget>[Container(
                            width: 50.00 ,
                            height:  50.00,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: ExactAssetImage('assets/weather.png'),
                                fit: BoxFit.fitHeight,
                              ),
                            )),
                          Padding(padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
                            child: Text('Humidity\n      ' + widget.humid + "%",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25)),)
                        ],) , angle: 270, positionFactor: 0.1)]
                  )])),
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
              child: Column(
                children: [
                  Text("Particulate Matter 2.5 Sensor Value", style: TextStyle(fontSize: 24),),
                  SizedBox(
                    height: 25,

                  ),
                  Text(widget.pm , style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),),
                  Text("parts per million"),
              Center(
                child: SfRadialGauge(
                  axes:<RadialAxis>[
                    RadialAxis(showLabels: false, showAxisLine: false, showTicks: false,
                        minimum: 0, maximum: 99,
                        ranges: <GaugeRange>[GaugeRange(startValue: 0, endValue: 33,
                            color: Color(0xFF00AB47), label: 'Low',
                            sizeUnit: GaugeSizeUnit.factor,
                            labelStyle: GaugeTextStyle(fontFamily: 'Times', fontSize:  20),
                            startWidth: 0.65, endWidth: 0.65
                        ),GaugeRange(startValue: 33, endValue: 66,
                          color:Color(0xFFFFBA00), label: 'Moderate',
                          labelStyle: GaugeTextStyle(fontFamily: 'Times', fontSize:   20),
                          startWidth: 0.65, endWidth: 0.65, sizeUnit: GaugeSizeUnit.factor,
                        ),
                          GaugeRange(startValue: 66, endValue: 99,
                            color:Color(0xFFFE2A25), label: 'Fast',
                            labelStyle: GaugeTextStyle(fontFamily: 'Times', fontSize:   20),
                            sizeUnit: GaugeSizeUnit.factor,
                            startWidth: 0.65, endWidth: 0.65,
                          ),

                        ],
                        pointers: <GaugePointer>[NeedlePointer(value: 60
                        )]
                    )
                  ],
                ),),
                ],
              ),
            ),
            Card(
              child: Column(
                children: [
                  Text("                     MQ-6 Sensor                   ", style: TextStyle(fontSize: 24),),
                  Text("parts per million"),
                  SizedBox(
                    height: 25,
                  ),
                  Text(widget.mq6, style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),),
                  Center(
                    child: SfRadialGauge(
                      axes:<RadialAxis>[
                        RadialAxis(showLabels: false, showAxisLine: false, showTicks: false,
                            minimum: 0, maximum: 99,
                            ranges: <GaugeRange>[GaugeRange(startValue: 0, endValue: 33,
                                color: Color(0xFF00AB47), label: 'Low',
                                sizeUnit: GaugeSizeUnit.factor,
                                labelStyle: GaugeTextStyle(fontFamily: 'Times', fontSize:  20),
                                startWidth: 0.65, endWidth: 0.65
                            ),GaugeRange(startValue: 33, endValue: 66,
                              color:Color(0xFFFFBA00), label: 'Moderate',
                              labelStyle: GaugeTextStyle(fontFamily: 'Times', fontSize:   20),
                              startWidth: 0.65, endWidth: 0.65, sizeUnit: GaugeSizeUnit.factor,
                            ),
                              GaugeRange(startValue: 66, endValue: 99,
                                color:Color(0xFFFE2A25), label: 'Fast',
                                labelStyle: GaugeTextStyle(fontFamily: 'Times', fontSize:   20),
                                sizeUnit: GaugeSizeUnit.factor,
                                startWidth: 0.65, endWidth: 0.65,
                              ),

                            ],
                            pointers: <GaugePointer>[NeedlePointer(value: 30
                            )]
                        )
                      ],
                    ),),
                ],
              ),
            ),
            Card(
              child: Column(
                children: [
                  Text("                 MQ-135 Sensor               ", style: TextStyle(fontSize: 24),),
                  Text("parts per million"),
                  SizedBox(
                    height: 25,
                  ),
                  Text(widget.mq135, style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),),
                  Center(
                    child: SfRadialGauge(
                      axes:<RadialAxis>[
                        RadialAxis(showLabels: false, showAxisLine: false, showTicks: false,
                            minimum: 0, maximum: 99,
                            ranges: <GaugeRange>[GaugeRange(startValue: 0, endValue: 33,
                                color: Color(0xFF00AB47), label: 'Low',
                                sizeUnit: GaugeSizeUnit.factor,
                                labelStyle: GaugeTextStyle(fontFamily: 'Times', fontSize:  20),
                                startWidth: 0.65, endWidth: 0.65
                            ),GaugeRange(startValue: 33, endValue: 66,
                              color:Color(0xFFFFBA00), label: 'Moderate',
                              labelStyle: GaugeTextStyle(fontFamily: 'Times', fontSize:   20),
                              startWidth: 0.65, endWidth: 0.65, sizeUnit: GaugeSizeUnit.factor,
                            ),
                              GaugeRange(startValue: 66, endValue: 99,
                                color:Color(0xFFFE2A25), label: 'Fast',
                                labelStyle: GaugeTextStyle(fontFamily: 'Times', fontSize:   20),
                                sizeUnit: GaugeSizeUnit.factor,
                                startWidth: 0.65, endWidth: 0.65,
                              ),

                            ],
                            pointers: <GaugePointer>[NeedlePointer(value: 45
                            )]
                        )
                      ],
                    ),),
                ],
              ),
            ),


          ],
        ) ,
      ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}


// Adding Graphs, Adding Notification on Toxic Levels, Adding Refresh Feature