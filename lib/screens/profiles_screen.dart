import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/account_controller.dart';
import '../controllers/profile_controller.dart';
import '../controllers/the_movie_db_controller.dart';
import '../controllers/watch_list_controller.dart';
import '../widgets/custom_text_form_field.dart';

class ProfilesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Text('Profiles'),
                Spacer(),
                InkWell(
                  child: Icon(Icons.logout),
                  onTap: () {
                    Provider.of<AccountController>(context, listen: false)
                        .signOut();
                  },
                ),
              ],
            ),
          ),
          body: GridView.count(
            padding: const EdgeInsets.all(16.0),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: controller.profiles.map((profile) {
              return FlatButton(
                padding: EdgeInsets.zero,
                child: Container(
                  color: Colors.green,
                  child: Center(child: Text(profile.name)),
                ),
                onPressed: () async {
                  Provider.of<ProfileController>(context, listen: false)
                      .changeProfile(profile);

                  Provider.of<WatchListController>(context, listen: false)
                      .loadWatchList();

                  Provider.of<TheMovieDBController>(context, listen: false)
                      .suggestedMovies();
                },
              );
            }).toList(),
          ),
          floatingActionButton: controller.profiles.length < 4
              ? FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () {
                    addNewProfile(context);
                  },
                )
              : Container(),
        );
      },
    );
  }

  void addNewProfile(BuildContext context) {
    final TextEditingController _nameCtrl = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Create new profile'),
          content: Form(
            key: _formKey,
            child: CustomTextFormField(
              ctrl: _nameCtrl,
              label: 'Name',
              hint: 'Joice',
              validator: (String text) {
                if (text.trim().isEmpty) {
                  return 'The name can\'t be blank!';
                }
                return null;
              },
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: new Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: new Text("Save"),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Provider.of<ProfileController>(
                    context,
                    listen: false,
                  ).insertNewProfile(
                    _nameCtrl.text.trim(),
                  );
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
