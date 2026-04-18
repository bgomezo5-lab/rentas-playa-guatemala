// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rentas_playa_app/main.dart';


void main() {
  testWidgets('Prueba de carga de bienvenida', (WidgetTester tester) async {
    // Construye nuestra app y dispara un frame.
    // Usamos PantallaBienvenida porque es tu clase inicial
    await tester.pumpWidget(MaterialApp(home: PantallaBienvenida()));

    // Verifica que el texto principal aparezca
    expect(find.text('RENTAS PLAYA'), findsOneWidget);
    expect(find.text('SOY PROPIETARIO'), findsOneWidget);
  });
}

Widget? PantallaBienvenida() {
}
