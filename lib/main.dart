import 'package:flutter/material.dart';
import 'package:list_view_pagination_tut/injection_container.dart';
import 'package:list_view_pagination_tut/ui/list/list_page.dart';

void main() {
  initKiwi();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListPage(),
    );
  }
}
