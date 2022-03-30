# EMETER - SOLUTION CHALLENGE 2022

<p align="center"><img src="./readme_img/logo.png" width="200" height="202"></p>

A new Flutter project which provides awesome features to user based on their current emotion.

## Introduction

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

To run our application, user's device need to have Internet connection.

## Screenflow

### Authentication

Before accessing to application features, user need to login in the `Login` tab:

<p align="center"><img src="./readme_img/login.png" width="256" height="455"></p>

If user are new to the application, they can register by filling in these below information in the `Register` tab to create a new account:

<p align="center"><img src="./readme_img/register.png" width="256" height="455"></p>

### Main screen

<p align="center"><img src="./readme_img/camera.png" width="256" height="455"></p>

The app bar of the application provide 4 main features:

- Camera
- Book
- Feed
- Settings

#### Camera
In the `Camera` tab, user will provide the picture of their face, then our application start scanning and detecting the emotion.

If there is no emotion detected, application will pop an `alert` message:

<p align="center"><img src="./readme_img/no_emotion.png" width="256" height="455"></p>

Or else, emotion detected successfully, there will be a `success` message like this:

<p align="center"><img src="./readme_img/emotion_detected.png" width="256" height="455"></p>

User can click the `Retry` button to retake the picture, or else user can click the `Confirm` button, the application will go into playlist interface:

<p align="center"><img src="./readme_img/playlist.png" width="256" height="455"></p>

In here, user can listen to the playlist which is created based on their emotion.

#### Book

