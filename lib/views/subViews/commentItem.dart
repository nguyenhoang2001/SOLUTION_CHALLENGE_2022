import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../commons/const.dart';
import '../../commons/utils.dart';



class CommentItem extends StatefulWidget{
  final DocumentSnapshot data;
  MyProfileData? myData;
  final Size size;
  final ValueChanged<MyProfileData> updateMyDataToMain;
  final ValueChanged <List<String>> replyComment;
  CommentItem({required this.data,required this.size,required this.myData,required this.updateMyDataToMain,required this.replyComment});
  @override State<StatefulWidget> createState() => _CommentItem();
}

class _CommentItem extends State<CommentItem>{

  late MyProfileData _currentMyData;
  @override
  void initState() {
    _currentMyData = widget.myData!;
    super.initState();
  }

  void _updateLikeCount(bool isLikePost) async{
    MyProfileData _newProfileData = await Utils.updateLikeCount(widget.data,isLikePost,widget.myData,widget.updateMyDataToMain,false);
    setState(() {
      _currentMyData = _newProfileData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.data['toCommentID'] == "" ? EdgeInsets.all(8.0) : EdgeInsets.all(8.0),
      // EdgeInsets.fromLTRB(34.0,8.0,8.0,8.0),
      child: Stack(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(6.0,2.0,10.0,2.0),
                child: Container(
                    width: widget.data['toCommentID'] == "" ? 48 : 48,
                    height: widget.data['toCommentID'] == "" ? 48 : 48,
                    child: Image.asset('assets/images/${widget.data['userThumbnail']}')
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(widget.data['userName'],style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:4.0),
                            child: widget.data['toCommentID'] == "" ? Text(widget.data['commentContent'],maxLines: null,) :
                            RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(text: widget.data['toUserID'], style: TextStyle(fontWeight: FontWeight.bold,color: Colors.lightBlue[400])),
                                  TextSpan(text: Utils.commentWithoutReplyUser(widget.data['commentContent']), style: const TextStyle(color:Colors.black)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    width: widget.size.width - (widget.data['toCommentID'] == "" ? 90 : 90),
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                      ),
                      boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 7,
                            offset: Offset(3, 5),
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:8.0,top: 4.0),
                    child: Container(
                      width: widget.size.width * 0.38,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(Utils.readTimestamp(widget.data['commentTimeStamp']),
                            style: const TextStyle(color: Colors.black45),
                          ),

                          widget.data['commentLikeCount'] > 0 ? Text('${widget.data['commentLikeCount']}',style:TextStyle(fontSize: 14)):Container(),
                          GestureDetector(
                              onTap: () => _updateLikeCount(_currentMyData.myLikeCommnetList.isNotEmpty && _currentMyData.myLikeCommnetList.contains(widget.data['commentID']) ? true : false),
                              child: Text('Like',
                                  style:TextStyle(fontWeight: FontWeight.bold,color:_currentMyData.myLikeCommnetList.isNotEmpty && _currentMyData.myLikeCommnetList.contains(widget.data['commentID']) ? Colors.lightBlue[400] : Colors.black45))
                          ),
                          GestureDetector(
                              onTap: (){
                                widget.replyComment([widget.data['userName'],widget.data['commentID'],widget.data['FCMToken']]);
                               // _replyComment(widget.data['userName'],widget.data['commentID'],widget.data['FCMToken']);
                                print('leave comment of comment');
                              },
                              child: const Text('Reply',style:TextStyle(fontWeight: FontWeight.bold,color:Colors.black45))
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // widget.data['commentLikeCount'] > 0 ? Positioned(
          //   bottom: 19,
          //   right:-3,
          //   child: Padding(
          //     padding: const EdgeInsets.all(2.0),
          //     child: Row(
          //       children: <Widget>[
          //         Icon(Icons.favorite_outlined,size: 18,color: Colors.red[900],),
          //         //Text('${widget.data['commentLikeCount']}',style:TextStyle(fontSize: 14)),
          //       ],
          //     ),
          //   ),
          // ) : Container(),
        ],
      ),
    );
  }
}