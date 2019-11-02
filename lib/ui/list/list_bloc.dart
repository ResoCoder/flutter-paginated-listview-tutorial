import 'package:bloc/bloc.dart';
import 'package:list_view_pagination_tut/data/generator/list_data_source.dart';
import 'package:list_view_pagination_tut/ui/list/list.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  final ListDataSource _dataSource;

  ListBloc(this._dataSource);

  void getNextListPage() {
    this.add(FetchNextPage());
  }

  void dispose() => this.close();

  @override
  ListState get initialState => ListState.initial();

  @override
  Stream<ListState> mapEventToState(ListEvent event) async* {
    if (event is FetchNextPage) {
      try {
        final nextPageItems = await _dataSource.getNextListPage();
        yield ListState.success(state.listItems + nextPageItems);
      } on NoNextPageException catch (_) {
        yield state.rebuild((b) => b..hasReachedEndOfResults = true);
      }
    }
  }
}
