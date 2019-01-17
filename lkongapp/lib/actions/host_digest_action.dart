import 'dart:async';

import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/middlewares/api.dart';
import 'package:meta/meta.dart';
import 'base_action.dart';
import 'api_action.dart';

class HotDigestRequest extends APIRequest with StartLoading {
  HotDigestRequest(Completer completer)
      : super(completer: completer, api: HOTDIGEST_API, parameters: {});

  @override
  CreateFailure get badResponse => (error) => HotDigestFailure(this, error);

  @override
  CreateSuccess get goodResponse => (list) => HotDigestSuccess(this, list);
}

class HotDigestSuccess extends APISuccess with StopLoading {
  final List<HotDigestResult> list;

  HotDigestSuccess(request, this.list) : super(request);
}

class HotDigestFailure extends APIFailure with StopLoading {
  HotDigestFailure(request, String error) : super(request, error);
}
