import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/account_controller.dart';
import '../controllers/profile_controller.dart';
import '../controllers/the_movie_db_controller.dart';
import '../controllers/watch_list_controller.dart';
import '../models/profile.dart';
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
                Text(
                  'Profiles - ${controller.profileCurrentlyLogged.name}',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                Spacer(),
                InkWell(
                  child: Icon(
                    Icons.logout,
                    color: Theme.of(context).primaryColor,
                  ),
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
              return Stack(
                fit: StackFit.expand,
                children: [
                  FlatButton(
                    color: Colors.grey.shade800,
                    child: Text(
                      profile.name,
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    onPressed: () {
                      Provider.of<ProfileController>(context, listen: false)
                          .changeProfile(profile);

                      Provider.of<WatchListController>(context, listen: false)
                          .loadWatchList();

                      Provider.of<TheMovieDBController>(context, listen: false)
                          .suggestedMovies();
                    },
                  ),
                  !profile.main
                      ? Padding(
                          padding: EdgeInsets.only(top: 10.0, right: 10.0),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              child: Icon(
                                Icons.remove_circle,
                                color: Colors.red,
                              ),
                              onTap: () => removeProfile(context, profile),
                            ),
                          ),
                        )
                      : Container(),
                ],
              );
            }).toList(),
          ),
          floatingActionButton: controller.profiles.length < 4
              ? FloatingActionButton(
                  child: Icon(Icons.add, color: Theme.of(context).primaryColor),
                  onPressed: () {
                    addNewProfile(context);
                  },
                )
              : Container(),
        );
      },
    );
  }

  void removeProfile(BuildContext context, Profile profile) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade900,
          title: Text(
            'Delete Profile',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          content: Container(
            width: 300,
            child: Text(
              'Are you sure that you want to delete this profile?',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: new Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: new Text('Delete'),
              onPressed: () {
                Provider.of<ProfileController>(context, listen: false)
                    .deleteProfile(profile);
                Navigator.of(context).pop();
              },
            ),
          ],
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
          backgroundColor: Colors.grey.shade900,
          title: Text(
            'Create new profile',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          content: Container(
            width: 300,
            child: Form(
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
