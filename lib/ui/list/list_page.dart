import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:list_view_pagination_tut/data/model/list_item.dart';
import 'package:list_view_pagination_tut/ui/list/list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListPage extends StatefulWidget {
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final _listBloc = kiwi.Container().resolve<ListBloc>();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _listBloc.getNextListPage();
  }

  @override
  void dispose() {
    super.dispose();
    _listBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paginated List App'),
      ),
      body: BlocBuilder(
        bloc: _listBloc,
        builder: (context, ListState state) {
          if (state.listItems.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return NotificationListener<ScrollNotification>(
              onNotification: _handleScrollNotification,
              child: ListView.builder(
                itemCount: calculateListItemCount(state),
                controller: _scrollController,
                itemBuilder: (context, index) {
                  return index >= state.listItems.length
                      ? _buildLoaderListItem()
                      : _buildDataListItem(state.listItems[index]);
                },
              ),
            );
          }
        },
      ),
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0) {
      _listBloc.getNextListPage();
    }

    return false;
  }

  int calculateListItemCount(ListState state) {
    if (state.hasReachedEndOfResults) {
      return state.listItems.length;
    } else {
      // + 1 for the loading indicator
      return state.listItems.length + 1;
    }
  }

  Widget _buildLoaderListItem() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildDataListItem(ListItem item) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Color(item.colorInt),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 10),
            Text(
              item.title,
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
