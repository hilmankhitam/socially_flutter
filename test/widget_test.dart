// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:socially/main.dart';

void main() {
  List<Tanggal> tanggal = [
    Tanggal(nama: 'Hilman', angka: 1),
    Tanggal(nama: 'Khitam', angka: 5),
    Tanggal(nama: 'Hilman', angka: 3),
    Tanggal(nama: 'Akari', angka: 6),
    Tanggal(nama: 'Akari', angka: 10),
    Tanggal(nama: 'Kito', angka: 7),
  ];
  var seen = <String>{};
  List<Tanggal> uniqueList =
      tanggal.where((element) => seen.add(element.nama)).toList();
  debugPrint(uniqueList[4].nama);
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(const MyApp());

  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);

  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();

  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });
}

class Tanggal {
  String nama;
  int angka;

  Tanggal({required this.nama, required this.angka});
}
