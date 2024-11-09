// lib/main.dart

import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'route_observer.dart'; // Importe o routeObserver

void main() {
  runApp(MeuApp());
}

class MeuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Prestadores de Serviço',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      navigatorObservers: [routeObserver], // Use o routeObserver aqui
    );
  }
}
