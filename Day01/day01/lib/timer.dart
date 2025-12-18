import 'package:flutter/material.dart';
import 'dart:async' as async;

class TimerPage extends StatefulWidget {
  TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  final TextEditingController _controller = TextEditingController();
  async.Timer? _timer;
  int _remainingSeconds = 0;
  bool _isRunning = false;

  String get _formattedTime {
    int minutes = _remainingSeconds ~/ 60;
    int seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}';
  }

  void _startTimer() {
    if (_controller.text.isEmpty) return;

    int totalSeconds = int.tryParse(_controller.text) ?? 0;
    if (totalSeconds <= 0) return;

    setState(() {
      _remainingSeconds = totalSeconds;
      _isRunning = true;
    });

    _timer = async.Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _isRunning = false;
          timer.cancel();
        }
      });
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _remainingSeconds = 0;
      _isRunning = false;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF1A1D1F)),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Number of seconds to count:", style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter seconds",
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    _formattedTime,
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: _remainingSeconds == 0 ? Colors.red : Colors.green,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _isRunning ? null : _startTimer,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text("Start"),
                      ),
                      ElevatedButton(onPressed: _resetTimer, child: const Text("Reset")),
                    ],
                  ),
                ],
              ),
            ),
            // Custom Navigation Controls
            Positioned(
              top: 10,
              left: 10,
              child: Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu, size: 30, color: Colors.black),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, size: 30, color: Colors.black),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
