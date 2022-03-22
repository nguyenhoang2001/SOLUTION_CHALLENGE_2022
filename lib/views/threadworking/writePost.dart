import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import '../../commons/const.dart';
import '../../commons/utils.dart';
import '../../controllers/FBCloudStore.dart';
import '../../controllers/FBStorage.dart';


class WritePost extends StatefulWidget{
  MyProfileData? myData;
  WritePost({required this.myData});
  @override State<StatefulWidget> createState() => _WritePost();
}

class _WritePost extends State<WritePost>{

  TextEditingController writingTextController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  FocusNode writingTextFocus = FocusNode();
  bool _isLoading = false;
  // late File _postImageFile;

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardActionsItem(
          displayArrows:false,
          focusNode: _nodeText1,
        ),
        KeyboardActionsItem(
          displayArrows: false,
          focusNode: writingTextFocus,
          toolbarButtons: [
                (node) {
              return GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Container(
                  color: Colors.grey[200],
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: const <Widget>[
                      Text(
                        "Done",
                        style: TextStyle(color: Colors.black87,fontSize: 20,fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            },
          ],
        ),
      ],
    );
  }

  void _postToFB() async {
    setState(() {
      _isLoading = true;
    });
    String postID = Utils.getRandomString(8) + Random().nextInt(500).toString();
    // String? postImageURL;
    // if(_postImageFile != null){
    //   postImageURL = await FBStorage.uploadPostImages(postID: postID, postImageFile: _postImageFile);
    // }
    FBCloudStore.sendPostInFirebase(postID,writingTextController.text,widget.myData,'NONE');

    setState(() {
      _isLoading = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
// <<<<<<< HEAD
          backgroundColor: Theme.of(context).primaryColor,
          // title: Text('Downloads'),
// =======
          title: const Text(
            'Writing post',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        actions: <Widget>[
          FlatButton(
            onPressed: () => _postToFB(),
            child: const Text('Post',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),)
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          KeyboardActions(
            config: _buildConfig(context),
            child: Column(
              children: <Widget>[
                Container(
                    width: size.width,
                    height: size.height - MediaQuery.of(context).viewInsets.bottom - 80,
                    child: Padding(
                      padding: const EdgeInsets.only(right:14.0,left:10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    width: 40,
                                    height: 40,
                                    // child: Image.asset('assets/images/${widget.myData!.myThumbnail}')
                                  child:  Image.asset('assets/images/user.png'),
                                ),
                              ),
                              Text(widget.myData!.myName,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                            ],
                          ),
                          const Divider(height: 1,color: Colors.black,),
                          Expanded(
                            child: TextFormField(
                              autofocus: true,
                              focusNode: writingTextFocus,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Lets share something',
                                hintMaxLines: 4,
                              ),
                              controller: writingTextController,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                            ),
                          ),
                          // _postImageFile != null ? Image.file(_postImageFile,fit: BoxFit.fill,) :
                          Container(),
                        ],
                      ),
                    )
                ),
              ],
            ),
          ),
          Utils.loadingCircle(_isLoading),
        ],
      ),
    );
  }
}