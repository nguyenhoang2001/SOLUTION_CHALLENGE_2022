# EMETER - SOLUTION CHALLENGE 2022

<p align="center"><img src="./readme_img/logo.png" width="200" height="202"></p>

A new Flutter project which provides awesome features to user based on their current emotion.

## ⭐ **Introduction**

Our group desire to design a Flutter application that can detect user's current emotion, our app can detect these following emotion:

- Anger
- Contempt
- Disgust
- Fear
- Happiness
- Neutral
- Sadness
- Surprise

Then application will create recommended music playlist or books that are suitable for user's feelings.

## 💻 **Requirements**
Running our application required internet connection.

## ✨ **Features**
- Listen to music.
- Read eBooks.
- Posting status.

## 📸 **Screenflow**

### **Authentication**

Before accessing to application features, user need to login in the `Login` tab:

<p align="center"><img src="./readme_img/login.png" width="256" height="455"></p>

If user are new to the application, they can register by filling in these below information in the `Register` tab to create a new account:

<p align="center"><img src="./readme_img/register.png" width="256" height="455"></p>

### **Main screen**

<p align="center"><img src="./readme_img/camera.png" width="256" height="455"></p>

The app bar of the application provide 4 main features:

- Camera
- Book
- Feed
- Settings

#### **Camera**
In the `Camera` tab, user will provide the picture of their face, then our application start scanning and detecting the emotion.

If there is no emotion detected, application will pop an `alert` message:

<p align="center"><img src="./readme_img/no_emotion.png" width="256" height="455"></p>

Or else, emotion detected successfully, there will be a `success` message like this:

<p align="center"><img src="./readme_img/emotion_detected.png" width="256" height="455"></p>

User can click the `Retry` button to retake the picture, or else user can click the `Confirm` button, the application will go into playlist interface:

<p align="center"><img src="./readme_img/playlist.png" width="256" height="455"></p>

In here, user can listen to the playlist which is created based on their emotion.

#### **Book**

For this section, users are able to read books which are recommend based on their emotions.

<p align="center"><img src="./readme_img/book.png" width="256" height="455"></p>

After choosing a book, a new page which contains description about the book will exist and there also provide some more book are written by the same author.

<p align="center"><img src="./readme_img/book_chosen.png" width="256" height="455"></p>

To read the book, the user first need to download it just by a press to download button and allow the application to download the book.

<p align="center"><img src="./readme_img/book_chosen.png" width="256" height="455"></p>

If user love this book and want to read it more in future, they can press the heart button on the right top corner, the book will be save into favourite section in setting.

#### **Newsfeed**

A place for users share their status or giving advice is also provided as a function in our application.

<p align="center"><img src="./readme_img/newsfeed.png" width="256" height="455"></p>

To post a status, press the pen button on the top right of the screen and user can type anything they want to share or consult from the community.

<p align="center"><img src="./readme_img/post.png" width="256" height="455"></p>

And the status will be posted on the forum.

<p align="center"><img src="./readme_img/after_post.png" width="256" height="455"></p>

User can also like or comment on others's post. If there's an impolite post, user can report it immediately.

<p align="center"><img src="./readme_img/comment.png" width="256" height="455"></p>

#### **Setting**
This is the place for user to check what's there favourite, downloaded books or their information.

<p align="center"><img src="./readme_img/setting.png" width="256" height="455"></p>

##### **Favorite**
User can find what's book they liked in here.

<p align="center"><img src="./readme_img/favourite.png" width="256" height="455"></p>

##### **Download**
All the books downloaded are stored in this section.
<p align="center"><img src="./readme_img/download.png" width="256" height="455"></p>

##### **About**
To show user the producer.
<p align="center"><img src="./readme_img/about.png" width="256" height="455"></p>

##### **Info**
User can see their information here.

<p align="center"><img src="./readme_img/info.png" width="256" height="455"></p>

## 