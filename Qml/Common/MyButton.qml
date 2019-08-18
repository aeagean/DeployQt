/**********************************************************
Author: Qt君
微信公众号: Qt君(首发)
QQ群: 732271126
Email: 2088201923@qq.com
LICENSE: MIT
**********************************************************/
import QtQuick 2.0

RoundRectangle {
    id: root
    property alias text: content.text
    signal clicked()

    color: mouseArea.pressed ? "#4cbeff" : "white"
    radius: 8
    border.color: mouseArea.pressed ? "#00000000" : "#d5d5d5"

    Text {
        id: content
        anchors.centerIn: parent
        color: mouseArea.pressed ? "white" : "#333333"
        font.pixelSize: 17
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: root.clicked()
    }
}
