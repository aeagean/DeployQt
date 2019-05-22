/**********************************************************
Author: Qtbig哥
WeChat Official Accounts Platform: nicaixiaoxuesheng (文章首发)
Website: qtbig.com(后续更新)
Email:  2088201923@qq.com
QQ交流群: 732271126
LISCENSE: MIT
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
