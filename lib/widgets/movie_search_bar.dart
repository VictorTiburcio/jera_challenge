// Flutter imports:
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/the_movie_db_controller.dart';
import 'custom_text_form_field.dart';

class MovieSearchBar extends StatelessWidget {
  final TextEditingController _searchCtrl;
  MovieSearchBar(this._searchCtrl);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: CustomTextFormField(
            ctrl: _searchCtrl,
            label: 'Search',
            hint: 'Movie name',
            prefixIcon: Icon(
              Icons.search,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        SizedBox(width: 10.0),
        SizedBox(
          width: 80,
          child: FlatButton(
            textColor: Colors.white,
            child: Text(
              'Search',
              style: TextStyle(color: Theme.of(context).primaryColor),
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
