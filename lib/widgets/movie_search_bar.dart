// Flutter imports:
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/the_movie_db_controller.dart';

class MovieSearchBar extends StatelessWidget {
  final TextEditingController _searchCtrl;
  MovieSearchBar(this._searchCtrl);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            height: 400.0,
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              // color: Color.fromARGB(12, 0, 0, 0),
            ),
            child: Row(
              children: <Widget>[
                Icon(Icons.search, size: 30),
                SizedBox(width: 10.0),
                Expanded(
                  child: TextFormField(
                    controller: _searchCtrl,
                    style: TextStyle(fontSize: 20.0),
                    decoration: InputDecoration.collapsed(
                      hintText: 'Movie name',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 10.0),
        SizedBox(
          width: 50.0,
          child: FlatButton(
            padding: EdgeInsets.zero,
            textColor: Colors.white,
            child: Text(
              'Search',
            ),
            onPressed: () {
              Provider.of<TheMovieDBController>(context, listen: false)
                  .search(_searchCtrl.text.trim());
            },
          ),
        )
      ],
    );
  }
}
