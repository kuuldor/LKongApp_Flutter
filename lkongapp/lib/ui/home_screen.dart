import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:lkongapp/ui/app_drawer.dart';
import 'package:lkongapp/ui/page_builder.dart';
import 'package:lkongapp/ui/connected_widget.dart';
import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/actions/actions.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: AppDrawerBuilder(),
      body: PageBuilder(),
    );
  }
}
