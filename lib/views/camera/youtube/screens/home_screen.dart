import 'package:flutter/material.dart';
import 'package:solution_challenge_2022/views/camera/youtube/models/channel_model.dart';
import 'package:solution_challenge_2022/views/camera/youtube/models/video_model.dart';
import 'package:solution_challenge_2022/views/camera/youtube/screens/video_screen.dart';
import 'package:solution_challenge_2022/views/camera/youtube/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  final String emotion;
  HomeScreen(this.emotion);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Channel _channel;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initChannel();
  }

  _initChannel() async {
    Channel channel = await APIService(widget.emotion)
        .fetchChannel(channelId: 'UCHSxkZNNxl6Bix5h8v_VDCg');
    setState(() {
      _channel = channel;
    });
  }

  _buildProfileInfo() {
    return Container(
      height: 0,
    );
  }

  _buildVideo(Video video) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VideoScreen(id: video.id),
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        padding: EdgeInsets.all(10.0),
        height: 140.0,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 1),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Image(
              width: 150.0,
              image: NetworkImage(video.thumbnailUrl),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                video.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _loadMoreVideos() async {
    _isLoading = true;
    List<Video> moreVideos = await APIService(widget.emotion)
        .fetchVideosFromPlaylist(playlistId: _channel.uploadPlaylistId);
    List<Video> allVideos = _channel.videos..addAll(moreVideos);
    setState(() {
      _channel.videos = allVideos;
    });
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.emotion} Playlist'),
      ),
      body: _channel != null
//      NotificationListener<ScrollNotification>(
//              onNotification: (ScrollNotification scrollDetails) {
//                if (
////                !_isLoading &&
////                    _channel.videos.length != (_channel.videoCount) &&
//                    scrollDetails.metrics.pixels ==
//                        scrollDetails.metrics.maxScrollExtent) {
//                  _loadMoreVideos();
//                }
//                return false;
//              },
          //        child:
          ? ListView.builder(
              itemCount: 1 + _channel.videos.length,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return _buildProfileInfo();
                }
                Video video = _channel.videos[index - 1];
                return _buildVideo(video);
              },
            )
          //   )
          : Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor, // Red
                ),
              ),
            ),
    );
  }
}
