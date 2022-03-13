import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls
import QtMultimedia

Rectangle {
    property string videourl: "";
    property var st;

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
