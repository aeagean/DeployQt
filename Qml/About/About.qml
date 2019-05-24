/**********************************************************
Author: Qtbig哥
WeChat Official Accounts Platform: nicaixiaoxuesheng (文章首发)
Website: qtbig.com(后续更新)
Email:  2088201923@qq.com
QQ交流群: 732271126
LISCENSE: MIT
**********************************************************/
import QtQuick 2.0

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

            Image {
                width: parent.width; height: width
                source: "qrc:/Resource/Qtbig.png"
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
            spacing: 15
            Text {
                text: "作者: QtBig哥"
            }
            Text {
                text: "微信公众号: 你才小学生 (每天更新)"
            }
            Text {
                text: "源码地址: https://github.com/aeagean/DeployQt"
            }
        }
    }
}
