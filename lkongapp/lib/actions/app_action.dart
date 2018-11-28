import 'package:flutter/material.dart';
import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/actions/base_action.dart';

class Rehydrate extends StartLoading {}

class Dehydrate {}

class RehydrateSuccess implements StopLoading {
  final PersistentState state;
  RehydrateSuccess(this.state);
}

class RehydrateFailure implements StopLoading {
  final String error;

  RehydrateFailure(this.error);
}

class DehydrateSuccess implements StopLoading {}

class DehydrateFailure implements StopLoading {
  final String error;

  DehydrateFailure(this.error);
}

class ChangeSetting {
  final Function(AppSettingBuilder builder) change;

  ChangeSetting(this.change);
}

