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
    flags: Qt.Dialog | Qt.MSWindowsFixedSizeDialogHint |
           Qt.WindowTitleHint | Qt.WindowCloseButtonHint |
           Qt.CustomizeWindowHint | Qt.WindowSystemMenuHint |
           Qt.WindowContextHelpButtonHint
    width: 640
    height: 480
    title: qsTr("Qt程序打包工具V0.9(By Qtbig哥)")

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

            if (! isValid) {
                drag.accepted = false
            }
            else {
                _private.lineEnable = true
            }
        }

        onExited: _private.lineEnable = false

        onDropped: {
            _private.lineEnable = false
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

                Rectangle {
                    anchors.centerIn: parent
                    width: parent.width - 8; height: parent.height - 8
                    color: "#dddddd"
                    visible: _private.lineEnable
                    radius: parent.radius
                }

                Text {
                    id: exeFileText
                    property string defaultText: "拖拽程序到此处"
                    anchors.centerIn: parent
                    color: text === defaultText ? "gray" : "black"
                    font.pixelSize: 30//text === defaultText ? 30 : 20
                    text: defaultText
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

    QtObject {
        id: _private
        property bool lineEnable: false
    }
}
