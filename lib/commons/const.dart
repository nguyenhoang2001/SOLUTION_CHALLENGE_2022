final List<String> iconImageList = ['assets/images/user.png'];
const String firebaseCloudserverToken ='AAAABtQIKms:APA91bFQu5UgGdRy9FctBP5BcCoV-LYewUa7y2lhlFPDKvKEoRpSDGlCcCfTaB_DZt9RKSqoijGhjN9slgrbCYo1ApgJnpzMU8aijl25HD8uEtzsfXHhtU_CLLjXZLzlDA8WXmh4al86';
const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
class MyProfileData{
  final String myThumbnail;
  final String myName;
  final List<String> myLikeList;
  final List<String> myLikeCommnetList;
  final String? myFCMToken;
  MyProfileData({required this.myName,required this.myThumbnail,required this.myLikeList,required this.myLikeCommnetList,required this.myFCMToken});
}

const reportMessage = 'Thank you for reporting. We will determine the user\'s information within 24 hours and delete the account or take action to stop it.';
