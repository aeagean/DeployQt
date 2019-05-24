/**********************************************************
Author: Qtbig哥
WeChat Official Accounts Platform: nicaixiaoxuesheng (文章首发)
Website: qtbig.com(后续更新)
Email:  2088201923@qq.com
QQ交流群: 732271126
LISCENSE: MIT
**********************************************************/
import QtQuick 2.0
import ToolsModel 1.0
import "../Common"

Rectangle {
    width: 640; height: 480

    Row {
        anchors.centerIn: parent
        width: parent.width - 10; height: parent.height - 10
        spacing: 20

        Column {
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width*0.25; //height: parent.height
            spacing: 20

            Column {
                width: parent.width; height: width + 40
                spacing: 10

                Image {
                    width: parent.width; height: width
                    source: "qrc:/Resource/Qtbig.png"
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "作者: QtBig哥"
                }
            }

            Column {
                width: parent.width
                height: width + 40
                clip: true

                Image {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width + 23; height: width
                    source: "qrc:/Resource/Qtbig_qrcode.jpg"
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "扫一扫关注微信公众号"
                }
            }
        }

        Column {
            anchors.verticalCenter: parent.verticalCenter
            spacing: 15

            Row {
                height: 30
                spacing: 5

                Text {
                    id: sourceCode
                    anchors.verticalCenter: parent.verticalCenter
                    text: "源码地址: https://github.com/aeagean/DeployQt"
                }

                MyButton {
                    anchors.verticalCenter: parent.verticalCenter
                    width: 60; height: 30
                    text: "打开"
                    onClicked: toolsModel.openUrl("https://github.com/aeagean/DeployQt")
                }
            }
        }
    }

    ToolsModel {
        id: toolsModel
    }
}
