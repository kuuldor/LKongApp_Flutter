import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/actions/actions.dart';
import 'package:redux/redux.dart';

class InitScreen extends StatelessWidget {
  static final String route = '/';

  @override
  Widget build(BuildContext context) {
    return StoreBuilder(
        onInit: (Store<AppState> store) => store.dispatch(Rehydrate()),
        builder: (BuildContext context, Store<AppState> store) {
          return Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(),
                ),
                SizedBox(
                  height: 4.0,
                  child: LinearProgressIndicator(),
                )
              ],
            ),
          );
        });
  }
}
