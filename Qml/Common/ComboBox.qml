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

    /// 此属性拥有组合框中当前项的索引。默认值为-1，当count为0时-1，其他情况为0或其他。
    property alias  currentIndex: _listView.currentIndex

    /**
     * @brief: 此属性拥有组合框中当前项的文本。
     * @note: read-only
     */
    property string currentText:  _listView.currentText

    /// 此属性为组合框提供数据模型。
    property alias  model:        _listView.model

    /// 此属性可以判断组合框是否被按下。按钮可以通过触摸或按键事件按下。
    property alias  pressed:      mouseArea.pressed

    /// 此属性可以判断组合框是否处于展开状态。
    property bool   down:         false;

    /**
     * @brief: 组合框中项数。
     * @note: read-only
     */
    property alias  count:        _listView.count

    /**
     * @brief 该属性为组合框代理项。
     * @note: 自定义delegate需要手动设置down属性与currentIndex属性以隐藏下拉列表和设置下拉列表当前项。
     */
    property Component delegate:    _private.defaultDelegate

    /// 用于设置指示器，标识组合框是否处于展开状态。常用的设置为三角形指示器。
    property Component indicator:   _private.defaultIndicator

    /// 用于设置组合框的可视项。
    property Component contentItem: _private.defaultContentItem

    /// 用于设置组合框的可视项的背景。
    property Component background:  _private.defaultBackground

    /// 用于设置下拉框的背景项，设置其宽高可以限制下拉框的大小。默认展示下拉框的三个项目。
    property Component popup:       _private.defaultPopup

    width: 150;
    height: 40

    /// background
    Loader {
        id: backgroundId
        sourceComponent: background
    }

    /// contentItem
    Item {
        width: contentItemId.item.width
        height: contentItemId.item.height

        Loader {
            id: contentItemId
            sourceComponent: contentItem
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            onReleased: root.down = !root.down
        }
    }

    /// indicator
    Loader {
        id: indicatorId
        sourceComponent: indicator
    }

    /// popup
    /// 下拉列表ListView
    Loader {
        id: popupId
        y: contentItemId.item.height
        visible: root.down
        clip: true
        sourceComponent: popup

        ListView {
            id: _listView
            z: popupId.item.z + 1
            property string currentText: ""
            width:  popupId.item.width
            height: popupId.item.height
            clip: true
            delegate: root.delegate
            onCurrentIndexChanged: currentText = model[currentIndex]
        }
    }

    /* Private */
    QtObject {
        id: _private
        property Component defaultDelegate: Rectangle {
            width: root.width; height: root.height

            Text {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 20
                /* 鼠标进入会显示对应高亮文字。 */
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
                /* 最后一个项不隐藏分隔线。 */
                visible: index !== root.count - 1
            }

            MouseArea {
                id: delegateMouseArea
                property bool isEnter: false
                anchors.fill: parent
                hoverEnabled: true /* 开启鼠标实时捕抓。 */
                onEntered: isEnter = true
                onExited: isEnter = false
                onClicked: {
                    /* 当选项被选中后需要用户设置down的状态为false,以让下拉列表收起来。 */
                    /* 还需设置currentIndex的值，以至于可以刷新contentItem的文字显示。 */
                    root.down = false
                    root.currentIndex = index
                }
            }
        }

        property Component defaultIndicator: Item {
            width: root.width; height: root.height

            /* 三角形指示器 */
            Item {
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 2
                anchors.right: parent.right
                anchors.rightMargin: 15
                clip: true
                width: 2*height; height: 7

                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -parent.height/2
                    width: Math.sqrt(parent.width*parent.width*2)/2; height: width
                    color: root.down ? "white" : "#4cbeff"
                    rotation: 45
                }
            }
        }

        property Component defaultContentItem: Rectangle {
            width: root.width; height: root.height
            color: root.down ? "#4cbeff" : "white"
            border.width: root.down ? 0 : 1
            border.color: "#d5d5d5"

            /* 显示当前下拉列表选中的内容 */
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

        property Component defaultBackground: Item { }

        /* 设置popup可以设置下拉框的高度和宽度 */
        property Component defaultPopup: Rectangle {
            width: root.width; height: root.count < 3 ? root.count * root.height : root.height * 3
            border.color: "#d5d5d5"
            border.width: 2
        }
    }
}
