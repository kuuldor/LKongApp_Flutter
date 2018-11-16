import 'package:redux/redux.dart';

import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/actions/actions.dart';

import 'package:lkongapp/reducers/story_reducer.dart';

final uiStateReducer = combineReducers<UIState>([
  TypedReducer<UIState, UIChange>(_changeUIState),
  TypedReducer<UIState, UIUpdateCurrentRoute>(_changeCurrentRoute),
  _contentReducer,
]);

UIState _changeUIState(UIState state, UIChange action) {
  return state.rebuild((b) => action.change(b));
}

UIState _changeCurrentRoute(UIState state, UIUpdateCurrentRoute action) {
  return state.rebuild((b) => b..navigationRoute = action.route);
}

UIState _contentReducer(UIState state, action) {
  return state.rebuild(
      (b) => b..content.replace(contentReducer(state.content, action)));
}
