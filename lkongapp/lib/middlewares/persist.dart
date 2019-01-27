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
            var state = store.state.persistState;

            String json = state.toJson();
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
            // newState = newState.rebuild((b) => b
            //   ..authState.update((b) => b
            //     ..isAuthed = false
            //     ..currentUser = -1));
            store.dispatch(RehydrateSuccess(newState));
          }).catchError((e) {
            store.dispatch(RehydrateFailure(e.toString()));
          }));
}

void checkAndSaveAppState(Store<AppState> store, action, NextDispatcher next) {
  next(action);
  bool save = false;
  if (action is LoginSuccess ||
      action is LoginTestSuccess ||
      action is UserInfoSuccess ||
      action is LogoutSuccess ||
      action is DeleteUsers) {
    save = true;
  }
  if (save) {
    Future(() {
      store.dispatch(Dehydrate());
    });
  }
}
