import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls
import QtMultimedia

import "listBuilder.js" as Build
import "serviceCalls.js" as Service

Rectangle {
    property var chlList: [];
    property string vidLink: "";
    property var st;

    function loadChannels(token) {
        chlList = Service.fetchChannels(token);
        Build.loadChannels(listModel, chlList);
    }

    function loadVideo() {
        stack.items[2].videourl = listModel.get(list.currentIndex).itemUrl;
        stack.push(stack.items[2], StackView.PushTransition);
    }
    RowLayout
    {

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
                        onClicked: loadVideo()
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
