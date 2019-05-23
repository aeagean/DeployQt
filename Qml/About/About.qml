/**********************************************************
Author: Qtbig哥
WeChat Official Accounts Platform: nicaixiaoxuesheng (文章首发)
Website: qtbig.com(后续更新)
Email:  2088201923@qq.com
QQ交流群: 732271126
LISCENSE: MIT
**********************************************************/
import QtQuick 2.0

Item {
    width: 640; height: 480

    Row {
        anchors.centerIn: parent
        width: parent.width - 10; height: parent.height - 10

        Column {
            width: parent.width*0.25; height: parent.height
            spacing: 10

            Image {
                source: "file:///C:/Users/Ema-RD/Downloads/tmp/DeployQt/Resource/Qtbig哥.png"
            }

        }

        Column {
            Text {
                text: "作者: QtBig哥"
            }
            Text {
                text: "微信公众号: 你才小学生 (每天更新)"
            }
            Text {
                text: "源码地址: "
            }
        }
    }
}
