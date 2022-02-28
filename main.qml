import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls
import QtMultimedia


import "serviceCalls.js" as Service
import "listBuilder.js" as Build

Window {
    id: windowMain
    width: 1280
    height: 720
    visible: true
    title: qsTr("Channels Application")

    property var response;
    property var channels;
    property string videourl: "";
    property string errorMsg: "";

    StackView {
        id: stack
        initialItem: view

        Rectangle {
            width: windowMain.width; height: windowMain.height
            color: "#303030"
            id: view
            Column {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                spacing: 6

                Row {

                    spacing: 5
                    Label {
                        text: "Username"
                        font.pixelSize: 15
                        font.italic: true
                        Layout.alignment: Qt.AlignLeft
                        color: "white"
                    }
                    TextField {
                        id: un
                        Layout.alignment: Qt.AlignRight
                        placeholderText: qsTr("Enter username")
                        background: Rectangle {
                            implicitWidth: 200
                            implicitHeight: 20
                            color: "white"
                            border.color: "white"
                        }
                    }
                }
                Row {

                    spacing: 5
                    Label {
                        text: "Password"
                        font.pixelSize: 15
                        font.italic: true
                        Layout.alignment: Qt.AlignLeft
                        color: "white"
                    }
                    TextField {
                        id: pw
                        echoMode: TextInput.Password
                        Layout.alignment: Qt.AlignRight
                        placeholderText: qsTr("Enter password")
                        background: Rectangle {
                            implicitWidth: 200
                            implicitHeight: 20
                            color: "white"
                            border.color: "white"
                        }
                    }
                }
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    Button {
                        id: loginB
                        contentItem: Text {
                                text: "Login"
                                color: "white"
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                elide: Text.ElideRight
                            }

                            background: Rectangle {
                                implicitWidth: 100
                                implicitHeight: 20
                                color: loginB.highlighted ? "gray" : "black"
                                border.color: "gray"
                                border.width: 1
                                radius: 2
                            }
                        onClicked: {
                            response = Service.login(un.text, pw.text)
                            if(response.jwt !== undefined) {
                                channels = Service.fetchChannels(response);
                                if(channels.length > 0) {
                                    stack.push(view2, StackView.PushTransition);
                                }
                                else {
                                    errors.color = "#ffcccb";
                                    errorMsg = channels.message;
                                }
                            }
                            else {
                                errors.color = "#ffcccb";
                                errorMsg = response.message;
                            }
                        }
                    }
                }
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    Rectangle {
                        id: errors
                        color: "#303030"
                        radius: 10.0
                        width: 300
                        height: 50
                        Text { anchors.centerIn: parent
                            font.pointSize: 8; text: errorMsg
                        }
                    }
                }
            }
        }
        Component {
            id: view2
            RowLayout
            {
                Component.onCompleted:{
                    Build.loadChannels(listModel, channels);
                }

                Rectangle {
                    id: root

                    width: windowMain.width
                    height: windowMain.height
                    color: "#303030"

                    Component {
                        id: dragDelegate

                        Item  {
                            id: content
                            height: 80
                            anchors.left: parent.left
                            anchors.right: parent.right
                            Rectangle {
                                id: body
                                anchors.fill: parent
                                color: "#303030"
                                border.width: 1
                                border.color: "white"
                                clip: false

                            Row {
                                id: column
                                anchors { fill: parent; }
                                leftPadding: 20
                                Image {
                                    source: image
                                }
                                Text {
                                    leftPadding: 20
                                    anchors.verticalCenter: column.verticalCenter
                                    font.pointSize: 24
                                    color: "white"
                                    text: name
                                }
                                property var itemUrl;
                            }
                            }
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    list.currentIndex = index
                                    videourl = listModel.get(list.currentIndex).itemUrl;
                                    stack.push(view3, StackView.PushTransition);
                                }
                            }
                        }
                    }
                    ListView {
                        id: list

                        anchors { fill: parent; margins: 2 }

                        model: ListModel {
                            id: listModel
                        }
                        delegate: dragDelegate
                        cacheBuffer: 50
                    }
                }
            }
        }
        Component {
            id: view3
            Video {
                id: video
                width: windowMain.width
                height: windowMain.height
                source: videourl
                Button {
                    id: closeVid
                    background: Rectangle {
                            implicitWidth: 20
                            implicitHeight: 20
                            opacity: enabled ? 1 : 0.3
                            border.color: closeVid.down ? "black" : "darkgrey"
                            border.width: 1
                            radius: 2
                        }
                    text: "X"
                    onClicked:{
                        stack.pop(StackView.PopTransition);
                    }
                    z: 100
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        video.play();
                    }
                    z: 99
                }

                focus: true
                Keys.onSpacePressed: {
                    video.play();
                    video.playbackState == MediaPlayer.PlayingState ? video.pause() : video.play()
                }
                Keys.onLeftPressed: video.seek(video.position - 5000)
                Keys.onRightPressed: video.seek(video.position + 5000)
            }
        }
    }
}
