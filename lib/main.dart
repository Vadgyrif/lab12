import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// стан: 4 кути
class Corners extends ChangeNotifier {
  List<double> r = [0, 0, 0, 0]; // TL, TR, BL, BR

  void set(int i, double v) {
    r[i] = v;
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => Corners(),
      child: const MaterialApp(home: HomePage()),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lab 12')),
      body: const Column(
        children: [
          SizedBox(height: 80),
          BlueBox(),
          SizedBox(height: 80),
          SlidersSection(),
        ],
      ),
    );
  }
}

// синій контейнер
class BlueBox extends StatelessWidget {
  const BlueBox({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.watch<Corners>().r;
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(r[0]),
          topRight: Radius.circular(r[1]),
          bottomLeft: Radius.circular(r[2]),
          bottomRight: Radius.circular(r[3]),
        ),
      ),
    );
  }
}

// секція зі слайдерами
class SlidersSection extends StatelessWidget {
  const SlidersSection({super.key});

  @override
  Widget build(BuildContext context) {
    final corners = context.watch<Corners>();
    const names = ['TL', 'TR', 'BL', 'BR'];

    return Column(
      children: [
        for (int i = 0; i < 4; i++) ...[
          Text('${names[i]}: ${corners.r[i].toStringAsFixed(2)}'),
          Slider(
            value: corners.r[i],
            max: 75,
            onChanged: (v) => corners.set(i, v),
          ),
        ],
      ],
    );
  }
}