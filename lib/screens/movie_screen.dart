import 'dart:io';
import 'dart:typed_data';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../utils/constants.dart';

class MovieScreen extends StatelessWidget {
  static const String route = '/movie';

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;
    final String posterPath =
        '${Constants.lowQualityImageBaseUrl}/${movie.posterPath}';
    final TextStyle textStyle = TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 20.0,
    );

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              movie.title,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            Spacer(),
            InkWell(
              child: Icon(
                Icons.share,
                color: Theme.of(context).primaryColor,
              ),
              onTap: () => sharePoster(context, posterPath),
            )
          ],
        ),
        leading: InkWell(
          child: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
          onTap: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            movie.posterPath != null
                ? Image.network(posterPath)
                : Center(
                    child: Icon(
                      Icons.broken_image,
                      size: 300,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
            SizedBox(height: 15.0),
            Text(
              movie.overview,
              style: textStyle,
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 15.0),
            Text(
              'Release Date: ${movie.releaseDate}',
              style: textStyle,
            ),
            SizedBox(height: 15.0),
            Text(
              'Movie Average: ${movie.voteAverage}',
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }

  void sharePoster(BuildContext context, String posterPath) async {
    loadingDialog(context);
    var request = await HttpClient().getUrl(Uri.parse(posterPath));
    var response = await request.close();
    Uint8List bytes = await consolidateHttpClientResponseBytes(response);
    Navigator.of(context).pop();
    await Share.file('What does the fox say?', 'image.jpg', bytes, 'image/jpg');
  }

  void loadingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade900,
          content: Container(
            width: 150,
            height: 150,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
