/**********************************************************
Author: Qtbig哥
WeChat Official Accounts Platform: nicaixiaoxuesheng (文章首发)
Website: qtbig.com(后续更新)
Email:  2088201923@qq.com
QQ交流群: 732271126
LISCENSE: MIT
**********************************************************/
import QtQuick 2.0
import QtQuick.Window 2.2
import VersionMode 1.0

import "./Common"

Window {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    DropArea {
        anchors.fill: parent;
        onEntered: {
            var isValid = true

            if (! drag.hasUrls)
                isValid = false;

            if (drag.urls.length !== 1)
                isValid = false;

            var suffix = drag.urls[0].substr(-4, 4)
            if (suffix !== ".exe" && suffix !== ".EXE")
                isValid = false;

            if (! isValid)
                drag.accepted = false
        }

        onDropped: {
            var firstUrl = drop.urls[0]
            var lastSlashPosition = firstUrl.lastIndexOf('/')+1
            var displayFile = firstUrl.substring(lastSlashPosition)

            exeFileText.text = displayFile
            versionMode.exeFile = firstUrl.substr(8) // remote prefix "file:///"
        }

    }

    Column {
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width
        spacing: 15

        ContentBar {
            z: 2
            width: parent.width
            height: 40
            text: "选择Qt版本"

            MyComboBox {
                model: versionMode.qtVersionList
                onCurrentTextChanged: versionMode.qtVersion = currentText
            }
        }

        ContentBar {
            z: 1
            width: parent.width
            height: 40
            text: "选择编译器版本"

            MyComboBox {
                model: versionMode.compilerVersionList
                onCurrentTextChanged: versionMode.compilerVersion = currentText
            }
        }

        Item {
            width: parent.width
            height: 240

            Rectangle {
                anchors.centerIn: parent
                width: parent.width - 8; height: parent.height - 4
                color: "#fafbfc"
                radius: 4
                border.color: "#e1e4e8"
                border.width: 2

                Text {
                    id: exeFileText
                    anchors.centerIn: parent
                    color: text === "拖拽程序到此处" ? "gray" : "black"
                    font.pixelSize: 20
                    text: "拖拽程序到此处"
                }
            }
        }

        MyButton {
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width - 10
            height: 40
            text: "生成"
            onClicked: versionMode.create()
        }

        MyButton {
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width - 10
            height: 40
            text: "测试"
            onClicked: versionMode.test()
        }
    }

    VersionMode {
        id: versionMode
    }

}
