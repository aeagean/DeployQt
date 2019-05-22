import QtQuick 2.0

ComboBox {
    id: root
    model: ["One", "Two", "Three", "Four", "Five"]

    background: Item { }

    contentItem: RoundRectangle {
        width: root.width; height: root.height
        color: root.down ? "#4cbeff" : "white"
        radius: 8
        radiusCorners: root.down ? (Qt.AlignLeft | Qt.AlignRight | Qt.AlignTop) :
                                       (Qt.AlignLeading | Qt.AlignRight | Qt.AlignTop | Qt.AlignBottom)

        border.color: root.down ? "#00000000" : "#d5d5d5"

        Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 20
            color: root.down ? "white" : "#333333"
            text: root.currentText
            font.bold: true
            font.pixelSize: 17
        }
    }

    indicator: Item {
        width: root.width; height: root.height

        Item {
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 20
            width: Math.sqrt(_triangle.width*_triangle.width*2); height: width/2
            clip: true

            Rectangle {
                id: _triangle
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: parent.height/4
                width: 12; height: width
                color: root.down ? "white" : "#4cbeff"
                rotation: 45
            }
        }
    }

    delegate: Item {
        width: root.width; height: root.height

        Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 20
            color: delegateMouseArea.isEnter ? "#4cbeff" : "black"
            text: modelData
            font.bold: true
            font.pixelSize: 17
        }

        Rectangle {
            id: line
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            width: parent.width - 40
            height: 1
            color: "#e6e8ea"
            visible: index !== root.count - 1
        }

        MouseArea {
            id: delegateMouseArea
            property bool isEnter: false
            anchors.fill: parent
            hoverEnabled: true
            onEntered: isEnter = true
            onExited: isEnter = false
            onClicked: {
                root.down = false
                root.currentIndex = index
            }
        }
    }

    popup: Rectangle {
        width: root.width; height: root.count < 3 ? root.count * root.height : root.height * 3
        border.color: "#d5d5d5"
        border.width: 1
    }
}

