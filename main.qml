import QtQuick 2.0
import QtQuick.Window 2.2

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
            if(drop.hasUrls){
                for(var i = 0; i < drop.urls.length; i++){
                    console.log(drop.urls.length);
                    console.log(drop.urls[i]);
                }
            }
        }
    }
}
