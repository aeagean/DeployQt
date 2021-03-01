/**********************************************************
Author: Qt君
微信公众号: Qt君(首发)
QQ群: 732271126
Email: 2088201923@qq.com
LICENSE: MIT
**********************************************************/
import QtQuick 2.0
import QtQuick.Window 2.2
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.0
import Qt.labs.platform 1.0
import VersionMode 1.0

import "./Common"
import "./About"

Window {
    id: root
    visible: true
    flags: Qt.Dialog | Qt.MSWindowsFixedSizeDialogHint
           | Qt.WindowTitleHint | Qt.WindowCloseButtonHint
           | Qt.CustomizeWindowHint | Qt.WindowSystemMenuHint
           | Qt.WindowMinimizeButtonHint | Qt.WindowStaysOnTopHint
    width: 640
    height: 560
    title: qsTr("Qt程序打包工具v1.0.1")

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

            _private.displayExeFile = displayFile
            versionMode.exeFile = firstUrl.substr(8) // remove prefix "file:///"
        }

    }

    Column {
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width
        spacing: 10

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

        ContentBar {
            z: 1
            width: parent.width
            height: 40
            text: "选择构建方式"

            MyComboBox {
                model: versionMode.buildTypeList
                onCurrentTextChanged: versionMode.buildType = currentText
            }
        }

        ContentBar {
            width: parent.width
            height: 40
            text: "选择Qt类型"

            Row {
                height: 40
                RadioButton {
                    id: widgetButton
                    checked: true
                    text: "widget"
                    width: 90
                    onCheckedChanged:  {
                        if(checked) {
                            versionMode.qmlDir = ""
                        }
                    }
                }

                RadioButton {
                    id: qmlButton
                    text: "qml"
                    width: 70
                }

                TextField {
                    width: parent.width - qmlButton.width - widgetButton.width - qmlFileDialogButton.width
                    height: 40
                    visible: qmlButton.checked
                    text: qmlFolderDialog.folder
                    placeholderText: "qml 文件路径"
                    selectByMouse: true
                    onTextChanged: {
                        versionMode.qmlDir = text
                    }
                }

                MyButton {
                    visible: qmlButton.checked
                    id: qmlFileDialogButton
                    text: "..."
                    height: 40
                    width: 30
                    onClicked: {
                        qmlFolderDialog.open()
                    }
                }

                FolderDialog {
                    id: qmlFolderDialog
                }
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
                    text: _private.displayExeFile.length === 0 ?  defaultText : _private.displayExeFile
                }
            }
        }

        MyButton {
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width - 10
            height: 40
            text: "生成"
            onClicked: {
                if (versionMode.exeFile.length === 0) {
                    tipsDialog.show("请添加目标程序")
                    tipsDialog.delayHide(1500)
                    return
                }

                tipsDialog.show("正在生成")
                delayCreate.start()
            }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width - 10
            spacing: 5

            MyButton {
                width: (parent.width - 5)/2
                height: 40
                text: "测试"
                onClicked: {
                    if (versionMode.exeFile.length === 0) {
                        tipsDialog.show("请添加目标程序")
                        tipsDialog.delayHide(1500)
                        return
                    }

                    tipsDialog.show("正在打开[" + _private.displayExeFile + "]")

                    delayTest.start()
                }
            }

            MyButton {
                width: (parent.width - 5)/2
                height: 40
                text: "关于"
                onClicked: aboutDialog.visible = true
            }
        }
    }

    About {
        id: aboutDialog
        visible: false
    }

    TipsDialog {
        id: tipsDialog
        anchors.fill: parent
    }

    VersionMode {
        id: versionMode
    }

    QtObject {
        id: _private
        property bool lineEnable: false
        property string displayExeFile: ""
    }

    Timer {
        id: delayCreate
        repeat: false;
        interval: 300
        onTriggered: {
            if (! versionMode.create()) {
                tipsDialog.show("生成失败, 请检查编译器是否存在。")
                tipsDialog.delayHide(3000)
            }
            else {
                tipsDialog.show("生成成功")
                tipsDialog.delayHide(2000)
            }
        }
    }

    Timer {
        id: delayTest
        repeat: false;
        interval: 300
        onTriggered: {
            if (! versionMode.test()) {
                tipsDialog.show("测试失败，切换编译器试试。")
                tipsDialog.delayHide(1500)
            }
            else {
                tipsDialog.delayHide(500)
            }
        }
    }
}
