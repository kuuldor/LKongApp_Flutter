import 'package:flutter/material.dart';

import 'package:lkongapp/ui/app_drawer.dart';

import 'package:lkongapp/ui/page_controller.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: AppDrawerBuilder(),
      body: PageControl(),
    );
  }
}