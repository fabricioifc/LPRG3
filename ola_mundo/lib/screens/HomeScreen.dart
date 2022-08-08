import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key, this.title}) : super(key: key);

  final String? title;
  final _pageController = PageController(initialPage: 3);

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      scrollDirection: Axis.horizontal,
      children: [
        Tela(
          bgColor: Colors.red,
        ),
        Tela(
          title: 'Página 2',
          bgColor: Colors.green,
        ),
        Tela(
          title: 'Página 3',
          bgColor: Colors.blue,
        ),
        CounterScreen(n: 0),
      ],
    );
  }
}

class Tela extends StatelessWidget {
  Tela({Key? key, this.title, required this.bgColor}) : super(key: key);

  final String? title;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      child: Center(
        child: Text(this.title ?? 'Hello World'),
      ),
    );
  }
}

class CounterScreen extends StatefulWidget {
  CounterScreen({Key? key, required this.n}) : super(key: key);

  int n;

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  // int _n = 0;

  @override
  void initState() {
    super.initState();

    () async {
      await Future.delayed(Duration.zero);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Contador Pronto')),
      );
    }();
  }

  @override
  void dispose() {
    super.dispose();

    widget.n = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contador')),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${widget.n}',
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _decrement();
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  child: const Icon(
                    Icons.exposure_minus_1,
                    size: 40.0,
                    color: Colors.white,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _increment();
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  child: const Icon(
                    Icons.plus_one,
                    size: 40.0,
                    color: Colors.black45,
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }

  void _increment() {
    debugPrint('Mais Um');
    setState(() {
      // _n++;
      widget.n++;
    });
  }

  void _decrement() {
    debugPrint('Mais Um');
    setState(() {
      // _n--;
      widget.n--;
    });
  }
}
