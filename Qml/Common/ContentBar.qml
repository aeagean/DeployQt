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
    id: root
    property alias text: content.text
    default property alias items: row.children

    Row {
        id: row
        Item {
            width: root.width*0.3
            height: root.height

            Text {
                id: content
                anchors.centerIn: parent
                font.pixelSize: 17
            }
        }
    }

    Component.onCompleted: {
        items[1].width = root.width*0.7 - 5
        items[1].height = root.height
    }
}
