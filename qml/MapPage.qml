import QtQuick 2.3
import QtQuick.Controls 1.2

Rectangle {
	id: mapPage
	anchors.fill: parent
	color: "#333"

	Flickable {
		id: mapImageFrame
		clip:true
		width: mapImage.width
		height: mapImage.height
		anchors.fill: parent
		//anchors.margins: 0
		contentWidth: mapImage.width * mapImage.scale
		contentHeight: mapImage.height * mapImage.scale
		boundsBehavior: Flickable.DragAndOvershootBounds

		Image {
			id: mapImage
			fillMode: Image.PreserveAspectFit
			source: "map1fl.png"
			smooth: true
			y: height * (scale - 1) / 2
			x: width * (scale - 1) / 2

			property double markScale: 1.0

			MouseArea {
				anchors.fill: parent
				acceptedButtons: Qt.LeftButton //| Qt.RightButton

				onWheel: {
					var newScale = mapImage.scale + mapImage.scale * wheel.angleDelta.y / 120 / 10;
					mapImage.scale = (newScale < 1) ? 1 : newScale;
					mapImage.markScale -= mapImage.markScale * wheel.angleDelta.y / 2400 ;
					mapImage.markScale = (mapImage.markScale > 1) ? 1 : mapImage.markScale;
					//mapImageFrame.returnToBounds();
				}

				onClicked: {
					if (mouse.button == Qt.LeftButton) {
						console.log(mouse.x, youMark.width, mapImage.markScale / mapImage.scale)
						youMark.x = mouse.x - youMark.width * mapImage.markScale / mapImage.scale
						youMark.y = mouse.y// - youMark.height * (1 - mapImage.markScale)
						//console.log(youMark.x, youMark.y);
						youMark.visible = true
					}
				}
			}

			Image {
				id: youMark
				width: 30;
				height:35;
				scale: mapImage.markScale
				source: "you.png"
				mipmap: true
			}
		}
	}
}
