import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Videos extends StatefulWidget {
  const Videos({Key? key}) : super(key: key);

  @override
  State<Videos> createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // body: NestedScrollView(
        //   floatHeaderSlivers: true,
        //   headerSliverBuilder: (context, innerBoxIsScrolled) => [
        //   // SliverAppBar(
        //   //   backgroundColor: Theme.of(context).primaryColor,
        //   //   floating: true,
        //   //   title: Text('Video',
        //   //       style: TextStyle(
        //   //       fontSize: 21.0,
        //   //       fontWeight: FontWeight.bold,
        //   //       ),
        //   //     ),
        //   //     centerTitle: true,
        //   //   ),
        //   // ],
        // ),
      appBar: AppBar(
        title: Text('Video',
          style: TextStyle(
            fontSize: 21.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
    );
  }
}
