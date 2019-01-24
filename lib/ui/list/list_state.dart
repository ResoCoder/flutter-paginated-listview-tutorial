library list_state;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:list_view_pagination_tut/data/model/list_item.dart';

part 'list_state.g.dart';

abstract class ListState implements Built<ListState, ListStateBuilder> {
  BuiltList<ListItem> get listItems;
  bool get hasReachedEndOfResults;

  ListState._();

  factory ListState([updates(ListStateBuilder b)]) = _$ListState;

  factory ListState.initial() {
    return ListState((b) => b
      ..listItems.replace(BuiltList<ListItem>())
      ..hasReachedEndOfResults = false);
  }

  factory ListState.success(BuiltList<ListItem> items) {
    return ListState((b) => b
      ..listItems.replace(items)
      ..hasReachedEndOfResults = false);
  }
}
