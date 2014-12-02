import QtQuick 2.3
import QtQuick.Controls 1.2

Rectangle {
    id: mapPage
    width: parent.width
    height: parent.height
    anchors.fill: parent
    anchors.margins: 10
    color: "white";

    Image {
        id: mapPage2
        fillMode:  Image.Tile
        //PreserveAspectFit
        //PreserveAspectCrop
        //width: parent.width;
        //height: parent.height;
        //width: 650;
        //height: 890;
         source: "map1fl.png"
         smooth: true

        MouseArea {
                anchors.fill: parent
                drag.target: mapPage2
                drag.axis: Drag.YAxis
        }

    }
    Image {
        id: youMark
        width: 20;
        height:30;
        //PreserveAspectFit
        //PreserveAspectCrop
        //width: parent.width;
        //height: parent.height;
        //width: 650;
        //height: 890;
         source: "you.png"
         smooth: true

        MouseArea {
                onClicked: {
                  if (mouse.button == Qt.RightButton)
                      parent.color = 'blue';
                }
                anchors.fill: parent
                drag.target: youMark
                drag.axis: Drag.YAxisXaxis
        }

    }
}

