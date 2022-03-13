import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls
import QtMultimedia

import "serviceCalls.js" as Service

Rectangle {
    property var channels;
    property var response;
    property string errorMsg: "";
    property var st;

    function callChannels() {
        response = Service.login(un.text, pw.text)
        if(response.jwt !== undefined) {
            st.push(st.items[1], StackView.PushTransition);
            st.items[1].loadChannels(response.jwt);
        }
        else {
            errors.color = "#ffcccb";
            errorMsg = response.message;
        }
    }

    width: windowMain.width; height: windowMain.height
    color: "#303030"
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
                onClicked: callChannels();
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

