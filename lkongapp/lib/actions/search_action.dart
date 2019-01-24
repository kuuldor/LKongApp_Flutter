import 'dart:async';

import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/middlewares/api.dart';
import 'base_action.dart';
import 'api_action.dart';

abstract class SearchRequest extends APIRequest with StartLoading {
  final int searchType;
  final String searchString;
  final int nexttime;
  final int sortType;

  SearchRequest(Completer completer, this.searchString, this.searchType,
      this.sortType, this.nexttime)
      : super(completer: completer, api: SEARCH_API, parameters: {
          "nexttime": nexttime,
          "search": searchString,
          "type": searchType,
          "sort": sortType,
        });
}

class SearchNewRequest extends SearchRequest {
  SearchNewRequest(
      Completer completer, String searchString, int searchType, int sortType)
      : super(completer, searchString, searchType, sortType, 0);

  @override
  CreateFailure get badResponse => (error) => SearchNewFailure(this, error);

  @override
  CreateSuccess get goodResponse => (result) => SearchNewSuccess(this, result);
}

class SearchLoadMoreRequest extends SearchRequest {
  final int searchType;
  final String searchString;
  final int nexttime;

  SearchLoadMoreRequest(Completer completer, this.searchString, this.searchType,
      int sortType, this.nexttime)
      : super(completer, searchString, searchType, sortType, nexttime);

  @override
  CreateFailure get badResponse =>
      (error) => SearchLoadMoreFailure(this, error);

  @override
  CreateSuccess get goodResponse =>
      (result) => SearchLoadMoreSuccess(this, result);
}

class SearchSuccess extends APISuccess with StopLoading {
  final result;

  SearchSuccess(request, this.result) : super(request);
}

class SearchFailure extends APIFailure with StopLoading {
  SearchFailure(request, String error) : super(request, error);
}

class SearchNewSuccess extends SearchSuccess {
  SearchNewSuccess(request, result) : super(request, result);
}

class SearchNewFailure extends SearchFailure {
  SearchNewFailure(request, String error) : super(request, error);
}

class SearchLoadMoreSuccess extends SearchSuccess {
  SearchLoadMoreSuccess(request, result) : super(request, result);
}

class SearchLoadMoreFailure extends SearchFailure {
  SearchLoadMoreFailure(request, String error) : super(request, error);
}
