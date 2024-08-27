import 'package:flutter/material.dart';

typedef OnChangeCallback = void Function(dynamic value);

class CustomSearchDelegate extends SearchDelegate {
  bool? b;
  final List itemList;
  String? type_id;
  final OnChangeCallback list;
  final OnChangeCallback index_back;

  CustomSearchDelegate(
      this.itemList, this.index_back, this.b, this.type_id, this.list);

  @override
  List<Widget> buildActions(BuildContext context) {
    // Actions for the search bar (e.g., clear query button).
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Leading icon on the left side of the search bar.
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Build the search results based on the query.
    final results = itemList
        .where((item) => item['$type_id'].toString().contains(query))
        .toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index]['$type_id'].toString()),
          onTap: () {
            // You can handle item selection here.
            // list(results[index]['id_user_control'].toString());
            close(context, results[index]['$type_id'].toString());
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List suggestionList = itemList
        .where((item) => item['$type_id'].toString().startsWith(query))
        .toList();
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestionList[index]['$type_id'].toString()),
          onTap: () {
            query = suggestionList[index]['$type_id'].toString();
            index_back(index);
            list(suggestionList);
            print(suggestionList[index]['email'].toString());
            Navigator.pop(context);

            //77
          },
        );
      },
    );
  }
}
