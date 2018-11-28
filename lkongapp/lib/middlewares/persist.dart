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
            String json = store.state.persistState.toJson();
            File(appStoragePath).writeAsString(json);
          }).then((file) {
            store.dispatch(DehydrateSuccess());
          }).catchError((e) {
            print(e.toString());
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
            PersistentState newState = PersistentState.fromJson(json);
            store.dispatch(RehydrateSuccess(newState));
          }).catchError((e) {
            store.dispatch(RehydrateFailure(e.toString()));
          }));
}
