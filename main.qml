import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls
import QtMultimedia

Window {
    id: windowMain
    width: 1280
    height: 720
    visible: true
    title: qsTr("Channels Application")

    StackView {
        id: stack
        initialItem: items[0]
        property variant items: [view1.createObject(), view2.createObject(), view3.createObject()]
    }
    Component
    {
        id: view1
        Login{
            id: lg
            st: stack
        }
    }
    Component
    {
        id: view2
        Channels{id: ch
        st: stack}
    }
    Component
    {
        id: view3
        VideoPlayer{id: vp
        st: stack}
    }
}
