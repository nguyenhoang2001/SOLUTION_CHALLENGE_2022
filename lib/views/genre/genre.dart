import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:solution_challenge_2022/components/body_builder.dart';
import 'package:solution_challenge_2022/components/book_list_item.dart';
import 'package:solution_challenge_2022/components/loading_widget.dart';
import 'package:solution_challenge_2022/models/category.dart';
import 'package:solution_challenge_2022/view_models/genre_provider.dart';
import 'package:provider/provider.dart';

class Genre extends StatefulWidget {
  final String title;
  final String url;

  Genre({
    Key? key,
    required this.title,
    required this.url,
  }) : super(key: key);

  @override
  _GenreState createState() => _GenreState();
}

class _GenreState extends State<Genre> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback(
      (_) => Provider.of<GenreProvider>(context, listen: false)
          .getFeed(widget.url),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, GenreProvider provider, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('${widget.title}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: _buildBody(provider),
        );
      },
    );
  }

  Widget _buildBody(GenreProvider provider) {
    return BodyBuilder(
      apiRequestStatus: provider.apiRequestStatus,
      child: _buildBodyList(provider),
      reload: () => provider.getFeed(widget.url),
    );
  }

  _buildBodyList(GenreProvider provider) {
    return ListView(
      controller: provider.controller,
      children: <Widget>[
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          shrinkWrap: true,
          itemCount: provider.items.length,
          itemBuilder: (BuildContext context, int index) {
            Entry entry = provider.items[index];
            return Padding(
              padding: EdgeInsets.all(5.0),
              child: BookListItem(
                entry: entry,
              ),
            );
          },
        ),
        SizedBox(height: 10.0),
        provider.loadingMore
            ? Container(
                height: 80.0,
                child: _buildProgressIndicator(),
              )
            : SizedBox(),
      ],
    );
  }

  _buildProgressIndicator() {
    return LoadingWidget();
  }
}
