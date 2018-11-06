import 'package:redux/redux.dart';

import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/actions/actions.dart';

final uiStateReducer = combineReducers<UIState>([
  TypedReducer<UIState, UIChange>(_changeUIState),
]);

UIState _changeUIState(UIState state, UIChange action) {
  return state.rebuild((b) => action.change(b));
}