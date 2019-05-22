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
