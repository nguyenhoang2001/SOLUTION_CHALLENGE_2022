import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge_2022/views/threadworking/writePost.dart';
import '../../commons/const.dart';
import '../../commons/utils.dart';
import '../subViews/threadItem.dart';
import 'contentDetail.dart';


class ThreadMain extends StatefulWidget{
  MyProfileData? myData;
  final ValueChanged<MyProfileData> updateMyData;
  ThreadMain({required this.myData,required this.updateMyData});
  @override State<StatefulWidget> createState() => _ThreadMain();
}

class _ThreadMain extends State<ThreadMain>{
  final bool _isLoading = false;
  void _writePost() {
    MyProfileData? save_mydata = widget.myData;
    if(save_mydata != null) {
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => WritePost(myData: widget.myData!,)));
    }else {
      print('myData is null');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        title: const Text(
          'Newsfeed',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          FlatButton(
              onPressed: _writePost,
              // child: const Text('Post',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),)
              child: const Icon(Icons.create, color: Colors.white,)
          )
        ],
// >>>>>>> 5b2fa77b80e4ab7abefb8ef6a1f86a853946eb2a
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('thread').orderBy('postTimeStamp',descending: true).snapshots(),
          builder: (context,snapshot) {
            if (!snapshot.hasData) return const LinearProgressIndicator();
            return Stack(
              children: <Widget>[
                snapshot.data!.docs.isNotEmpty ?
                ListView(
                  shrinkWrap: true,
                  children: snapshot.data!.docs.map((DocumentSnapshot data){
                    return ThreadItem(data: data,myData: widget.myData,updateMyDataToMain: widget.updateMyData,threadItemAction: _moveToContentDetail,isFromThread:true,commentCount: data['postCommentCount'],parentContext: context,);
                  }).toList(),
                ) : Container(
                  child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.error,color: Colors.grey[700],
                            size: 64,),
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Text('There is no post',
                              style: TextStyle(fontSize: 16,color: Colors.grey[700]),
                              textAlign: TextAlign.center,),
                          ),
                        ],
                      )
                  ),
                ),
                Utils.loadingCircle(_isLoading),
              ],
            );
          }
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Color(0xff40e0d0),
      //   onPressed: _writePost,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.create),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _moveToContentDetail(DocumentSnapshot data) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ContentDetail(postData: data,myData: widget.myData,updateMyData: widget.updateMyData,)));
  }
}