import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../commons/const.dart';
import '../../commons/utils.dart';
import '../threadworking/reportPost.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class ThreadItem extends StatefulWidget{
  final BuildContext parentContext;
  final DocumentSnapshot data;
  MyProfileData? myData;
  final ValueChanged<MyProfileData> updateMyDataToMain;
  final bool isFromThread;
  final Function threadItemAction;
  final int commentCount;
  ThreadItem({required this.data,required this.myData,required this.updateMyDataToMain,required this.threadItemAction,required this.isFromThread,required this.commentCount,required this.parentContext});
  @override State<StatefulWidget> createState() => _ThreadItem();
}
class _ThreadItem extends State<ThreadItem>{
  late MyProfileData _currentMyData;
  late int _likeCount;
  @override
  void initState() {
    _currentMyData = widget.myData!;
    _likeCount = widget.data['postLikeCount'];
    super.initState();
  }

  void _updateLikeCount(bool isLikePost) async{
    MyProfileData _newProfileData = await Utils.updateLikeCount(widget.data,widget.myData!.myLikeList.isNotEmpty && widget.myData!.myLikeList.contains(widget.data['postID']) ? true : false,widget.myData,widget.updateMyDataToMain,true);
    setState(() {
      _currentMyData = _newProfileData;
    });
    setState(() {
      isLikePost ? _likeCount-- : _likeCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // return Padding(
    //   padding: const EdgeInsets.fromLTRB(2.0,2.0,2.0,6),
    //   child: Card(
    //     elevation:10.0,
    //     child: Padding(
    //       padding: const EdgeInsets.all(10.0),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: <Widget>[
    //           GestureDetector(
    //             onTap: () => widget.isFromThread ? widget.threadItemAction(widget.data) : null,
    //             child: Row(
    //               children: <Widget>[
    //                 Padding(
    //                   padding: const EdgeInsets.fromLTRB(6.0,2.0,10.0,2.0),
    //                   child: Container(
    //                       width: 48,
    //                       height: 48,
    //                       child: Image.asset('assets/images/${widget.data['userThumbnail']}')
    //                   ),
    //                 ),
    //                 Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: <Widget>[
    //                     Text(widget.data['userName'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
    //                     Padding(
    //                       padding: const EdgeInsets.all(2.0),
    //                       child: Text(Utils.readTimestamp(widget.data['postTimeStamp']),style: TextStyle(fontSize: 16,color: Colors.black87),),
    //                     ),
    //                   ],
    //                 ),
    //                 const Spacer(),
    //                 PopupMenuButton<int>(
    //                   itemBuilder: (context) => [
    //                     PopupMenuItem(
    //                       value: 1,
    //                       child: Row(
    //                         children: const [
    //                           Padding(
    //                             padding: EdgeInsets.only(right:8.0,left:8.0),
    //                             child: Icon(Icons.report),
    //                           ),
    //                           Text("Report"),
    //                         ],
    //                       ),
    //                     ),
    //                   ],
    //                   initialValue: 1,
    //                   onCanceled: () {
    //                     print("You have canceled the menu.");
    //                   },
    //                   onSelected: (value) {
    //                     showDialog(
    //                         context: widget.parentContext,
    //                         builder: (BuildContext context) => ReportPost(postUserName: widget.data['userName'],postId:widget.data['postID'],content:widget.data['postContent'],reporter: widget.myData!.myName,));
    //                   },
    //                 ),
    //               ],
    //             ),
    //           ),
    //           GestureDetector(
    //             onTap: () => widget.isFromThread ? widget.threadItemAction(widget.data) : null,
    //             child: Padding(
    //               padding: const EdgeInsets.fromLTRB(8,10,4,10),
    //               child: Container(
    //                 child: Text(widget.data['postContent'],
    //                   style: const TextStyle(fontSize: 16,),
    //                   maxLines: 1000,
    //                 ),
    //               ),
    //             ),
    //           ),
    //           const Divider(height: 2,
    //             color: Colors.white,
    //           ),
    //           Padding(
    //             padding: const EdgeInsets.only(top:6.0,bottom: 2.0),
    //             child: Row(
    //               children: <Widget>[
    //                 GestureDetector(
    //                   onTap: () => _updateLikeCount(_currentMyData.myLikeList != null && _currentMyData.myLikeList.contains(widget.data['postID']) ? true : false),
    //                   child: Row(
    //                     children: <Widget>[
    //                       Padding(
    //                         padding: const EdgeInsets.only(left:8.0),
    //                         child: Icon(FontAwesomeIcons.heart,size: 20,color: widget.myData!.myLikeList != null && widget.myData!.myLikeList.contains(widget.data['postID']) ? Colors.lightBlue[400] : Colors.black45),
    //                       ),
    //                       Padding(
    //                         padding: const EdgeInsets.only(left:8.0),
    //                         child: Text(' ${widget.isFromThread ? widget.data['postLikeCount'] : _likeCount} ',
    //                           style: TextStyle(fontSize: 16,
    //                               //fontWeight: FontWeight.bold,
    //                               color: widget.myData!.myLikeList != null && widget.myData!.myLikeList.contains(widget.data['postID']) ? Colors.lightBlue[400] : Colors.black45),),
    //                       ),
    //                       Padding(
    //                         padding: const EdgeInsets.only(left:25.0),
    //                         child: GestureDetector(
    //                           onTap: () => widget.isFromThread ? widget.threadItemAction(widget.data) : null,
    //                           child: Row(
    //                             children: <Widget>[
    //                               const Icon(FontAwesomeIcons.comment,size: 20),
    //                               Padding(
    //                                 padding: const EdgeInsets.only(left:8.0),
    //                                 child: Text(' ${widget.commentCount} ',style: const TextStyle(fontSize: 16,color: Colors.black45,)
    //                                     //fontWeight: FontWeight.bold),
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
    //
    return Container(
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tweetAvatar(),
          tweetBody(),
        ],
      ),
    );
  }

  Widget tweetAvatar() {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: CircleAvatar(
        child: Image.asset('assets/images/${widget.data['userThumbnail']}'),
        // backgroundImage: NetworkImage('assets/images/${widget.data['userThumbnail']}'),
      ),
    );
  }

  Widget tweetBody() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tweetHeader(),
          tweetText(),
          tweetButtons(),
        ],
      ),
    );
  }

  Widget tweetHeader() {
    return GestureDetector(
      onTap: () => widget.isFromThread ? widget.threadItemAction(widget.data) : null,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 5.0),
            child: Text(
              widget.data['userName'],
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            '· '+ Utils.readTimestamp(widget.data['postTimeStamp']),
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          const Spacer(),
          PopupMenuButton<int>(
            color: Colors.white,
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(right:8.0,left:8.0),
                      child:
                      Icon(FontAwesomeIcons.flag),
                    ),
                    Text("Report"),
                  ],
                ),
              ),
            ],
            initialValue: 1,
            onCanceled: () {
              print("You have canceled the menu.");
            },
            onSelected: (value) {
              showDialog(
                  context: widget.parentContext,
                  builder: (BuildContext context) => ReportPost(postUserName: widget.data['userName'],postId:widget.data['postID'],content:widget.data['postContent'],reporter: widget.myData!.myName,));
            },
          ),
        ],
      ),
    );
  }

  Widget tweetText() {
    return GestureDetector(
      onTap: () => widget.isFromThread ? widget.threadItemAction(widget.data) : null,
      child: Text(widget.data['postContent'],
        style: const TextStyle(fontSize: 16,),
        maxLines: 1000,
        overflow: TextOverflow.clip,
      ),
    );
  }

  Widget tweetButtons() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0, right: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
            GestureDetector(
              onTap: () => _updateLikeCount(_currentMyData.myLikeList.isNotEmpty && _currentMyData.myLikeList.contains(widget.data['postID']) ? true : false),
              child: Row(
              children: [
                  Icon(
                  FontAwesomeIcons.heart,
                  size: 16.0,
                  color: widget.myData!.myLikeList.isNotEmpty && widget.myData!.myLikeList.contains(widget.data['postID']) ? Colors.lightBlue[400] : Colors.black45,
                ),
                Container(
                  margin: const EdgeInsets.all(6.0),
                  child: Text(
                    '${widget.isFromThread ? widget.data['postLikeCount'] : _likeCount}',
                    style: TextStyle(
                      color: widget.myData!.myLikeList.isNotEmpty && widget.myData!.myLikeList.contains(widget.data['postID']) ? Colors.lightBlue[400] : Colors.black45,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => widget.isFromThread ? widget.threadItemAction(widget.data) : null,
            child: Row(
              children: [
                const Icon(
                  FontAwesomeIcons.comment,
                  size: 16.0,
                  color: Colors.black45,
                ),
                Container(
                  margin: const EdgeInsets.all(6.0),
                  child: Text(
                    '${widget.commentCount}',
                    style: const TextStyle(
                      color: Colors.black45,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget tweetIconButton(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16.0,
          color: Colors.black45,
        ),
        Container(
          margin: const EdgeInsets.all(6.0),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.black45,
              fontSize: 14.0,
            ),
          ),
        ),
      ],
    );
  }
}