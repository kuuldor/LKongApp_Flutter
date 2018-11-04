import 'dart:io';
import 'package:redux/redux.dart';
import 'package:path_provider/path_provider.dart';

import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/actions/actions.dart';

const _storageFileName = 'LKongApp.state';


void saveAppState(Store<AppState> store, action, NextDispatcher next) {
  next(action);
  store.dispatch(
      (store) => getApplicationDocumentsDirectory().then((Directory appDocDir) {
            String appStoragePath = getStorageFile(appDocDir);
            File(appStoragePath).writeAsString(store.state.toJson());
          }).then((file) {
            store.dispatch(DehydrateSuccess());
          }).catchError((e) {
            store.dispatch(DehydrateFailure(e.toString()));
          }));
}

String getStorageFile(Directory appDocDir) =>
    appDocDir.path + "/" + _storageFileName;

void loadAppState(Store<AppState> store, action, NextDispatcher next) {
  next(action);
  store.dispatch(
      (store) => getApplicationDocumentsDirectory().then((Directory appDocDir) {
            String appStoragePath = getStorageFile(appDocDir);
            return File(appStoragePath).readAsString();
          }).then((String json) {
            AppState newState = AppState.fromJson(json);
            store.dispatch(RehydrateSuccess(newState));
          }).catchError((e) {
            store.dispatch(RehydrateFailure(e.toString()));
          }));
}
