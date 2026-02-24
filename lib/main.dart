import 'package:flutter/material.dart';
import 'package:g15/plate.dart';

import 'model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game 15',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const G15Page(title: 'Game 15'),
    );
  }
}

class G15Page extends StatefulWidget {
  const G15Page({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<G15Page> createState() => _G15PageState();
}

class _G15PageState extends State<G15Page> {
  // int _counter = 0;
  List<Plate> _plates = List.generate(16, (index) => Plate(number: index));

  @override
  void initState() {
    super.initState();
    _shuffle();
  }

  void _shuffle() {
    setState(() {
      _plates.shuffle();
    });
  }

  void _swap(int index1, int index2) {
    setState(() {
      final temp = _plates[index1];
      _plates[index1] = _plates[index2];
      _plates[index2] = temp;
    });
  }

  // void _incrementCounter() {
  //   setState(() {
  //     // This call to setState tells the Flutter framework that something has
  //     // changed in this State, which causes it to rerun the build method below
  //     // so that the display can reflect the updated values. If we changed
  //     // _counter without calling setState(), then the build method would not be
  //     // called again, and so nothing would appear to happen.
  //     _counter++;
  //   });
  // }

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
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          // Background image covering whole screen
          Positioned.fill(
            child: Image.asset(
              'assets/images/border.png',
              fit: BoxFit.contain,
            ),
          ),
          // 4x4 grid on top
          Center(
            child: AspectRatio(
              aspectRatio: 1,
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                ),
                itemCount: 16,
                itemBuilder: (context, index) {
                  var number = _plates[index].number;
                  if(number > 0) {
                    return GestureDetector(
                      onTap: () {
                        _onPlateClicked(index, number);
                      },
                      child: NumberedPlate(number: number),
                    );
                  } else {
                    return Image.asset(
                      'assets/images/empty.png',
                      fit: BoxFit.contain,
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onPlateClicked(int index, int number) {
    print('Plate clicked: index=$index, number=$number');
    var x = index % 4;
    var y = index ~/ 4;
    var leftIndex = y * 4 + (x - 1);
    var rightIndex = y * 4 + (x + 1);
    var topIndex = (y - 1) * 4 + x;
    var bottomIndex = (y + 1) * 4 + x;
    if (x <= 0)
      leftIndex = -1;
    if (x >= 4)
      rightIndex = -1;
    if (y <= 0)
      topIndex = -1;
    if (y >= 4)
      bottomIndex = -1;
    if (!trySwap(index, leftIndex)) {
      if (!trySwap(index, rightIndex)) {
        if (!trySwap(index, topIndex)) {
          if (!trySwap(index, bottomIndex)) {

          }
        }
      }
    }
  }

  bool trySwap(int index, int newIndex) {
    if (newIndex >= 0 && newIndex < 16 && _plates[newIndex].number == 0) {
      _swap(index, newIndex);
      return true;
    }
    return false;
  }
}

