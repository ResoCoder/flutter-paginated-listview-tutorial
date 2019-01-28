import 'package:kiwi/kiwi.dart';
import 'package:list_view_pagination_tut/data/generator/list_data_source.dart';
import 'package:list_view_pagination_tut/ui/list/list_bloc.dart';

void initKiwi() {
  Container().registerFactory((c) => ListDataSource());
  Container().registerFactory((c) => ListBloc(c.resolve()));
}
