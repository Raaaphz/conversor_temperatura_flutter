import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum TempSelect { C, F }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Conversor de Temperatura',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Conversor de Temperatura'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  TempSelect _tempSelect = TempSelect.C;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'INSIRA A TEMPERATURA:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: _controller,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const Text(
              'Converter para:',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: const Text('°C'),
              leading: Radio<TempSelect>(
                value: TempSelect.C,
                groupValue: _tempSelect,
                onChanged: (TempSelect? value) {
                  setState(() {
                    _tempSelect = value!;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('°F'),
              leading: Radio<TempSelect>(
                value: TempSelect.F,
                groupValue: _tempSelect,
                onChanged: (TempSelect? value) {
                  setState(() {
                    _tempSelect = value!;
                  });
                },
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                double temp = double.tryParse(_controller.text) ?? 0.0;

                if (_tempSelect == TempSelect.F) {
                  temp = (temp * 9 / 5) + 32;
                } else {
                  temp = (temp - 32) * 5 / 9;
                }

                setState(() {
                  _controller.text = temp.toStringAsFixed(2);
                });
              },
              child: const Text('Converter'),
            ),
          ],
        ),
      ),
    );
  }
}
