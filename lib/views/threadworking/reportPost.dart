import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../commons/const.dart';
import '../../controllers/FBCloudStore.dart';


class ReportPost extends StatefulWidget {
  final String postUserName;
  final String postId;
  final String content;
  final String reporter;
  ReportPost({required this.postUserName,required this.postId,required this.content,required this.reporter});
  @override State<StatefulWidget> createState() => _ReportPost();
}

class _ReportPost extends State<ReportPost> {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text("Report Post"),
      content:
      Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text("Post Author: ${widget.postUserName}\n\nPlease choice why do you want to report the post\n"),
          _blockButton('Possible Spam Post'),
          _blockButton('Inappropriate Post'),
          _blockButton('Not relative about subject'),
          _blockButton('Impersonation')
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("Close"),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  Widget _blockButton(String buttonText){
    return RaisedButton(
      onPressed: () =>_reportUser(buttonText),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top:12.0,bottom:12),
        child: Container(
          width: double.infinity,
          child: Text(buttonText,
            style: TextStyle(color: Colors.red,
                fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }

  void _reportUser(String reportReason) async{
    showToastMessage();
    await FBCloudStore.sendReportUserToFB(context,reportReason,widget.postUserName,widget.postId,widget.content,widget.reporter);
    Navigator.of(context).pop();
  }

  static void showToastMessage(){
    Fluttertoast.showToast(
        msg: reportMessage,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}