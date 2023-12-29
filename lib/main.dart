import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final items = List<String>.generate(10, (i) => 'Izuku Midoriya    Deku');
  final ScrollController _topScrollController = ScrollController();
  final ScrollController _bottomScrollController = ScrollController();
  Timer? timer;
  double scrollOffset = 0;
  var diagonalValue = 0.0;
  var angleOfTriangle = 0.0;
  var finalDegree = 0.0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _stripeLooperFun();
    });
  }

  void _stripeLooperFun() {
    _topScrollController.addListener(() {
      scrollOffset = _topScrollController.offset /
          _calculateDiagonal(MediaQuery.of(context).size.height * 0.5,
              MediaQuery.of(context).size.width * 0.8); // (1 / sqrt(2))
      if (_topScrollController.position.pixels >=
          _topScrollController.position.maxScrollExtent) {
        _topScrollController
            .jumpTo(_topScrollController.position.minScrollExtent);
      }
    });
    _bottomScrollController.addListener(() {
      scrollOffset = _bottomScrollController.offset /
          _calculateDiagonal(MediaQuery.of(context).size.height * 0.5,
              MediaQuery.of(context).size.width * 0.8); // (1 / sqrt(2))
      if (_bottomScrollController.position.pixels >=
          _bottomScrollController.position.maxScrollExtent) {
        _bottomScrollController
            .jumpTo(_bottomScrollController.position.minScrollExtent);
      }
    });

    // Auto-scroll animation
   timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      _topScrollController.animateTo(
        _topScrollController.position.pixels + 100,
        // Adjust scroll distance as needed
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    });
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      _bottomScrollController.animateTo(
        _bottomScrollController.position.pixels + 100,
        // Adjust scroll distance as needed
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    });
  }

  double _calculateDiagonal(double a, double b) {
    // Calculate c using the formula c = sqrt(a^2 + b^2)
    return sqrt(a * a + b * b);
  }

  double _findAngle(double width, double diagonal) {
    //Calculate Cosθ using the formula Cosθ = formula base/diagonal
    double cosTheta = width / diagonal;
    //Calculate θ value cos inverse
    return acos(cosTheta);
  }

  double _radTODegree(double value) {
    // Convert radian to degree
    return value * (180 / pi);
  }

  @override
  Widget build(BuildContext context) {
    diagonalValue = _calculateDiagonal(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);
    angleOfTriangle =
        _findAngle(MediaQuery.of(context).size.width, diagonalValue);
    finalDegree = 180 - (_radTODegree(angleOfTriangle) + 90);
    return Scaffold(
      backgroundColor: const Color(0xd2014646),
      body: Center(
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height * 0.8,
              left: -20,
              child: Transform(
                transform: Matrix4.rotationZ(
                    -_radTODegree(angleOfTriangle) * 3.14159265 / 360),
                child: SizedBox(
                  width: _calculateDiagonal(MediaQuery.of(context).size.height,
                      MediaQuery.of(context).size.width),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: _bottomScrollController,
                    child: Container(
                      color: const Color(0xd235d7b9),
                      child: Row(
                        children: List.generate(
                          items.length * 2,
                          (i) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(items[i % items.length]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: MediaQuery.of(context).size.width * 0.35,
              height: MediaQuery.of(context).size.height * 0.80,
              width: MediaQuery.of(context).size.width * 0.30,
              child: Center(
                child: Image.asset('assets/images/IzukuMidoriya.png'),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.3,
              left: 0,
              child: Transform(
                transform: Matrix4.rotationZ(
                    _radTODegree(angleOfTriangle) * 3.14159265 / 360),
                child: SizedBox(
                  width: _calculateDiagonal(MediaQuery.of(context).size.height,
                      MediaQuery.of(context).size.width),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: _topScrollController,
                    child: Container(
                      color: const Color(0xd235d7b9),
                      child: Row(
                        children: List.generate(
                          items.length * 2,
                          (i) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(items[i % items.length]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.04,
              left: MediaQuery.of(context).size.width * 0.39,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Izuku\n",
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'nosifer',
                        foreground: Paint()
                          ..style = PaintingStyle.fill
                          ..strokeWidth = 1
                          ..color = Colors.amber,
                      ),
                    ),
                    TextSpan(
                      text: "Mid",
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'nosifer',
                        foreground: Paint()
                          ..style = PaintingStyle.fill
                          ..strokeWidth = 1
                          ..color = Colors.amber,
                      ),
                    ),
                    TextSpan(
                      text: "or",
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'nosifer',
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 1
                          ..color = Colors.amber,
                      ),
                    ),
                    TextSpan(
                      text: "iya",
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'nosifer',
                        foreground: Paint()
                          ..style = PaintingStyle.fill
                          ..strokeWidth = 1
                          ..color = Colors.amber,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
