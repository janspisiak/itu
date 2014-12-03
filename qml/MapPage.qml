import QtQuick 2.3
import QtQuick.Controls 1.2

Flickable {
    id: mapPage
    clip:true
    width: parent.width
    height: parent.height
    anchors.fill: parent
    anchors.margins: 0
    contentWidth: mapPage2.width
    contentHeight: mapPage2.height
  //  var wifiX, wifiY;
    Image {
        id: mapPage2
        //fillMode:  Image.PreserveAspectFit
        scale:  1.0
        //PreserveAspectFit
        //PreserveAspectCrop
        //width: parent.width;
        //height: parent.height;
        //width: 450;
        //height: 490;
        source: "map1fl.png"
        smooth: true
        width: parent.width;
                height: parent.height;
        MouseArea {

                anchors.fill: parent
                drag.target: mapPage2

               // drag.minimumY:  -100
               // drag.maximumY: -mapPage2.height + parent.height
               // drag.minimumX: 0
                //drag.maximumX: mapPage.width - mapPage2.width
                //mapPage.width - mapPage2.width
                acceptedButtons: Qt.LeftButton //| Qt.RightButton
                drag.axis: Drag.XAndYAxis

                onWheel: {
                    console.log("!",mapPage2.x/mapPage2.scale );
                    var scaleM = mapPage2.scale + mapPage2.scale * wheel.angleDelta.y / 120 / 10;
                    if(scaleM < 5)
                        mapPage2.scale = (scaleM < 1 ) ? 1 : scaleM;
                }

                onClicked: {

                    if (mouse.button == Qt.LeftButton)
                    {
                        youMark.x = mouse.x -15
                        youMark.y = mouse.y -33
                        //wifiX = mouse.x
                       // wifiY = mouse.y
                        youMark.visible = true
                    }
                }
        }


        Image {
            id: youMark
            width: 30;
            height:35;
            visible:false;
            source: "you.png"
            mipmap: true
        }
     }
}
