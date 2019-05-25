/**********************************************************
Author: Qtbig哥
WeChat Official Accounts Platform: nicaixiaoxuesheng (文章首发)
Website: qtbig.com(后续更新)
Email:  2088201923@qq.com
QQ交流群: 732271126
LISCENSE: MIT
**********************************************************/
import QtQuick 2.0
import ToolsModel 1.0
import "../Common"

Rectangle {
    id: root
    width: 640; height: 480

    MouseArea { anchors.fill: parent }

    Row {
        anchors.centerIn: parent
        width: parent.width - 10; height: parent.height - 10
        spacing: 20

        Column {
            y: 10
            width: parent.width * 0.25;
            spacing: 30

            Column {
                width: parent.width; height: width + 40
                spacing: 10

                Image {
                    width: parent.width; height: width
                    source: "qrc:/Resource/Qtbig.png"
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "作者: QtBig哥"
                }
            }

            Column {
                width: parent.width
                height: width + 40
                clip: true

                Image {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width + 23; height: width
                    source: "qrc:/Resource/Qtbig_qrcode.jpg"
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "扫码关注反馈问题"
                }
            }
        }

        Column {
            id: rightBar
            y: 10
            width: parent.width * 0.75 - 20
            spacing: 15

            Repeater {
                model: [
                    {
                        title: "适用范围: ",
                        content: "1. Window系统;\n2. Qt5.0版本以上编译的程序。"
                    },
                    {
                        title: "使用方法: ",
                        content: "1. 将需要打包的程序拖拽到打包工具中;\n2. 选择该程序编译时的Qt版本和编译器版本;\n3. 点击生成;\n4. 最后测试。"
                    },
                    {
                        title: "注意: ",
                        content: "程序引入的第三方库需要用户自己复制到运行程序目录下。"
                    },
                    {
                        title: "获取更多",
                        content: ""
                    }
                ]

                Item {
                    width: rightBar.width
                    height: displayInfo.height

                    Column {
                        id: displayInfo
                        spacing: 10
                        Text {
                            id: title
                            text: modelData.title
                            font.pixelSize: 25
                        }

                        Text {
                            id: content
                            text: modelData.content
                            lineHeight: 1.5
                        }
                    }

                }
            }


            Repeater {
                model: [
                    {
                        content: "源码地址: https://github.com/aeagean/DeployQt",
                        buttonText: "打开",
                        url: "https://github.com/aeagean/DeployQt"
                    },
                    {
                        content: "Big哥网站: http://www.qtbig.com",
                        buttonText: "打开",
                        url: "http://www.qtbig.com"
                    },
                ]

                Item {
                    width: parent.width
                    height: 10

                    Text {
                        id: sourceCode
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        text: modelData.content
                    }

                    MyButton {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        width: 60; height: 20
                        text: modelData.buttonText
                        onClicked: toolsModel.openUrl(modelData.url)
                    }
                }
            }

            Item {
                width: parent.width; height: 55

                MyButton {
                    x: 150
                    anchors.verticalCenter: parent.verticalCenter
                    width: 80; height: 35
                    text: "返回"
                    onClicked: root.visible = false
                }
            }
        }
    }

    ToolsModel {
        id: toolsModel
    }
}
