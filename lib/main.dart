import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();
  final TextEditingController _fieldFive = TextEditingController();
  final TextEditingController _fieldSix = TextEditingController();
  final TextEditingController _fieldSeven = TextEditingController();
  final TextEditingController _fieldEight = TextEditingController();
  final TextEditingController _fieldNine = TextEditingController();
  final TextEditingController _fieldTen = TextEditingController();

  String? _otp;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Enter Vehicle Number",
            style: TextStyle(fontSize: 24, fontFamily: "Lato"),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              LetterInput(_fieldOne, true),
              LetterInput(_fieldTwo, false),
              NumberInput(_fieldThree, false),
              NumberInput(_fieldFour, false),
              LetterInput(_fieldFive, true),
              LetterInput(_fieldSix, false),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NumberInput(_fieldSeven, false),
              NumberInput(_fieldEight, false),
              NumberInput(_fieldNine, true),
              NumberInput(_fieldTen, false),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  _otp = _fieldOne.text +
                      _fieldTwo.text +
                      _fieldThree.text +
                      _fieldFour.text +
                      _fieldFive.text +
                      _fieldSix.text +
                      _fieldSeven.text +
                      _fieldEight.text +
                      _fieldNine.text +
                      _fieldTen.text;
                });
              },
              child: const Text('Submit')),
          const SizedBox(
            height: 30,
          ),
          Text(
            _otp ?? 'Please enter OTP',
            style: const TextStyle(fontSize: 30),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => resultpage(text: _otp.toString())));
            },
            child: Text("Next Page"),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class NumberInput extends StatelessWidget {
  final TextEditingController controller;
  final bool autoFocus;
  const NumberInput(this.controller, this.autoFocus, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 50,
      child: TextField(
        autofocus: autoFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        controller: controller,
        maxLength: 1,
        cursorColor: Theme.of(context).primaryColor,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            counterText: '',
            hintStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}

class LetterInput extends StatelessWidget {
  final TextEditingController controller;
  final bool autoFocus;
  const LetterInput(this.controller, this.autoFocus, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 50,
      child: TextField(
        textCapitalization: TextCapitalization.characters,
        autofocus: autoFocus,
        textAlign: TextAlign.center,
        // keyboardType: TextInputType.number,
        controller: controller,
        maxLength: 1,
        cursorColor: Theme.of(context).primaryColor,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            counterText: '',
            hintStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}

class resultpage extends StatefulWidget {
  final String text;
  resultpage({Key? key, required this.text}) : super(key: key);

  @override
  _resultpageState createState() => _resultpageState();
}

class _resultpageState extends State<resultpage> {
  // final String text = '';
  late List data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Result Page"),
        ),
        body: Center(
            child: FutureBuilder(
                future: DefaultAssetBundle.of(context)
                    .loadString('assets/sample.json'),
                builder: (context, snapshot) {
                  // Decode the JSON
                  var newData = json.decode(snapshot.data.toString());

                  return ListView.builder(

                      itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 32, bottom: 32, left: 16, right: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {},
                                  child: Text(
                                    newData[index]['title'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  ),
                                ),
                                Text(
                                  newData[index]['text'],
                                  style: TextStyle(color: Colors.grey.shade600),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                      itemCount: newData == null ? 0 : newData.length,
                  );
                })));
  }
}

// class resultpage extends StatelessWidget {
//   List _items = [];
//   final String text;
//   resultpage({Key? key, required this.text}) : super(key: key);
//
//   Future<void> readJson() async {
//     final String response = await rootBundle.loadString('assets/sample.json');
//     final data = await json.decode(response);
//     setState(() {
//       _items = data["items"];
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Result Page"),
//       ),
//       body: ListView(children: [
//         ListTile(
//           leading: Icon(Icons.airport_shuttle),
//           title: Text("Vehicle Number", style: TextStyle(fontSize: 20),),
//           subtitle: Text(text, style: TextStyle(fontSize: 18),),
//           trailing: Icon(Icons.menu),
//         ),
//         Text(
//           text,
//           style: TextStyle(fontSize: 24),
//         ),
//         Text(
//           text,
//           style: TextStyle(fontSize: 24),
//         ),
//       ]),
//     );
//   }
// }

// body: Center(
// child: ListView.builder(
// itemBuilder: (BuildContext context, int index) {
// return Card(
// child: Padding(
// padding: const EdgeInsets.only(
// top: 32, bottom: 32, left: 16, right: 16),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: <Widget>[
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: <Widget>[
// InkWell(
// onTap: () {},
// child: Text(
// 'Country',
// style: TextStyle(
// fontWeight: FontWeight.bold, fontSize: 22),
// ),
// ),
// Text(
// 'Capital',
// style: TextStyle(color: Colors.grey.shade600),
// ),
// ],
// ),
// Container(
// height: 50,
// width: 50,
// child: Image.asset('assets/images/face1.jpg'),
// )
// ],
// ),
// ),
// );
// },
// itemCount: 5,
// ),
// ),
