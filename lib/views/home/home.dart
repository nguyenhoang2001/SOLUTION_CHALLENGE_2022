import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:solution_challenge_2022/components/body_builder.dart';
import 'package:solution_challenge_2022/components/book_card.dart';
import 'package:solution_challenge_2022/components/book_list_item.dart';
import 'package:solution_challenge_2022/models/category.dart';
import 'package:solution_challenge_2022/util/consts.dart';
import 'package:solution_challenge_2022/util/router.dart';
import 'package:solution_challenge_2022/view_models/home_provider.dart';
import 'package:solution_challenge_2022/views/genre/genre.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
String myEmotion = "normal";

void saveEmotion(String emotion) {
  if(emotion.isNotEmpty) {
    myEmotion = emotion;
  }
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback(
      (_) => Provider.of<HomeProvider>(context, listen: false).getFeeds(),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<HomeProvider>(
      builder: (BuildContext context, HomeProvider homeProvider, Widget? child) {
        return Scaffold(
          body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                backgroundColor: Theme.of(context).primaryColor,
                floating: true,
                title: const Text('Book',
                    style: TextStyle(
                    fontSize: 21.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
              )
            ],
            body: _buildBody(homeProvider),
          ),
        );
      },
    );
  }

  Widget _buildBody(HomeProvider homeProvider) {
    return BodyBuilder(
      apiRequestStatus: homeProvider.apiRequestStatus,
      child: _buildBodyList(homeProvider),
      reload: () => homeProvider.getFeeds(),
    );
  }

  Widget _buildBodyList(HomeProvider homeProvider) {
    return RefreshIndicator(
      onRefresh: () => homeProvider.getFeeds(),
      child: ListView(
        children: <Widget>[
          _buildFeaturedSection(homeProvider),
          SizedBox(height: 20.0),
          _buildSectionTitle('Categories'),
          SizedBox(height: 10.0),
          _buildGenreSection(homeProvider),
          SizedBox(height: 20.0),
          _buildSectionTitle('Recommended'),
          SizedBox(height: 20.0),
          _buildNewSection(homeProvider),
        ],
      ),
    );
  }

  _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '$title',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  _buildFeaturedSection(HomeProvider homeProvider) {
    return Container(
      height: 200.0,
      child: Center(
        child: ListView.builder(
          primary: false,
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          scrollDirection: Axis.horizontal,
          itemCount: homeProvider.top.feed?.entry?.length ?? 0,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            Entry entry = homeProvider.top.feed!.entry![index];
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
              child: BookCard(
                img: entry.link![1].href!,
                entry: entry,
              ),
            );
          },
        ),
      ),
    );
  }

  _buildGenreSection(HomeProvider homeProvider) {
    return Container(
      height: 50.0,
      child: Center(
        child: ListView.builder(
          primary: false,
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          scrollDirection: Axis.horizontal,
          itemCount: homeProvider.top.feed?.link?.length ?? 0,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            Link link = homeProvider.top.feed!.link![index];

            // We don't need the tags from 0-9 because
            // they are not categories
            if (index < 10) {
              return SizedBox();
            }
            // // testing the sort of categories
            // if(link.title != "Action & adventure") {
            //   return SizedBox();
            // }
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.all(
                    Radius.circular(1.0),
                  ),
                  onTap: () {
                    MyRouter.pushPage(
                      context,
                      Genre(
                        title: '${link.title}',
                        url: link.href!,
                      ),
                    );
                  },
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        '${link.title}',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _buildNewSection(HomeProvider homeProvider) {
    return ListView.builder(
      primary: false,
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: homeProvider.recent.feed?.entry?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        Entry entry = homeProvider.recent.feed!.entry![index];
        bool pass = false;
        if(myEmotion == "neutral" || myEmotion == "happiness") {
          for(int i = 0; i < entry.category!.length; i++) {
            String? cate = entry.category![i].label;
            if(cate == "Literary" ||cate == "Science fiction"
                 ||cate == "Romance" || cate == "Juvenile & young adult" ||
                cate == "Business & economics"||cate == "Humorous") {
              pass = true;
              break;
            }
          }
        }
        else if(myEmotion == "sadness" || myEmotion == "fear"||
            myEmotion == "anger"|| myEmotion == "surprise"||
            myEmotion == "disgust" || myEmotion == "contempt") {
            for(int i = 0; i < entry.category!.length; i++) {
              String? cate = entry.category![i].label;
              if( cate == "Drama" || cate == "Short stories" ||cate == "Thrillers"
                  ||cate == "Suspense" ||cate == "Romance" ||
                  cate == "True story" ||cate == "Mystery & detective" || cate == "Religious") {
                pass = true;
                break;
              }
            }
        }else {
          pass = true;
        }


        if(pass == false) {
          return const SizedBox();
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
          child: BookListItem(
            entry: entry,
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
