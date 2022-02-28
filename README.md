# Channel List App
## Introduction
The main purpose of this project is to display a list of channels for a user that logged in. The channels in the list, when selected, will display a video where the user has the option to play the video or to return to the list.

## App details

The application was built in Qt, using Javascript for calls to an API.
In order to display the channels for a user, the user needs to log in with valid credentials. The login is performed by calling an API which returns a token on success.
This token is used further for authorization when a "fetch channels" call to an API is performed.

## How to run
1. Clone the repository
2. Open the project in Qt Creator, and build a Release version of the project.
3. Compiled project should not require any additional configuration changes, user may have to install the QtQuick and QtMultimedia modules.

###### Note for Windows
If the app is being built for the Windows version, user may have to run the "windeployqt" command in order to add all the necessary dependencies the app requires in order to run the application.

```
windeployqt channellistapp.exe
```
###### Note for Linux
Release version for Linux systems does not require any additional configurations. User may simply run it from Command Line:
```
cd build-ChannelListApp-Desktop_Qt_6_2_3_GCC_64bit-Release
./ChannelListApp
```
## Notes

This project was developed using Qt Creator. The project was tested on Windows 10 and Ubuntu 20.04.3 LTS and was developed with Qt version 6.2.3.
