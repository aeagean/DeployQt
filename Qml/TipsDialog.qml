/**********************************************************
Author: Qt君
微信公众号: Qt君(首发)
QQ群: 732271126
Email: 2088201923@qq.com
LICENSE: MIT
**********************************************************/
import QtQuick 2.0

Rectangle {
    id: root
    property alias text: content.text

    color: "#90000000"
    visible: false

    MouseArea { anchors.fill: parent }

    Rectangle {
        anchors.centerIn: parent
        width: root.width * 0.7;
        height: root.height * 0.4;
        radius: 8

        Text {
            id: content
            anchors.centerIn: parent
            font.pixelSize: 20
        }
    }

    Timer {
        id: delayTimer
        repeat: false
        onTriggered: hide()
    }

    function show(content) {
        root.text = content
        visible = true
    }

    function hide() {
        visible = false
    }

    function delayHide(msecond) {
        delayTimer.interval = msecond
        delayTimer.start()
    }
}
