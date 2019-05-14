import QtQuick 2.0
import QtQuick.Window 2.2
import QtQuick.Controls 2.5
import VersionMode 1.0

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
        width: parent.width
        spacing: 15

        ComboBox {
            width: root.width;
            model: versionMode.qtVersionList
            onCurrentTextChanged: versionMode.qtVersion = currentText
        }

        ComboBox {
            width: root.width
            model: versionMode.compilerVersionList
            onCurrentTextChanged: versionMode.compilerVersion = currentText
        }

        Rectangle {
            width: parent.width; height: 30
            border.width: 1
            Text {
                id: exeFileText
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        Button {
            width: parent.width
            text: "生成"
            onClicked: versionMode.create()
        }

        Button {
            width: parent.width
            text: "测试"
            onClicked: versionMode.test()
        }
    }

    VersionMode {
        id: versionMode
    }

}
