import QtQuick 2.0
import QtQuick.Window 2.2
import QtQuick.Controls 2.5
import VersionMode 1.0

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    DropArea {
        anchors.fill: parent;
        onEntered: {
            if (drag.urls.length !== 1) {
                drag.accepted = false
                return false;
            }
        }

        onDropped: {
            if(drop.hasUrls)
                return false;

            if (drop.urls.length !== 1)
                return false;
        }

        Column {
            ComboBox {
                model: versionMode.qtVersionList
                onCurrentTextChanged: versionMode.qtVersion = currentText
            }

            ComboBox {
                model: versionMode.compilerVersionList
                onCurrentTextChanged: versionMode.compilerVersion = currentText
            }
        }
    }

    VersionMode {
        id: versionMode
    }
}
