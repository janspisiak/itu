import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1

import io.thp.pyotherside 1.3

Rectangle {
	id: scanPage
	anchors.fill: parent
	//anchors.topMargin: topPanel.height + anchors.margins
	width: parent.width
	height: parent.height

	color: "#333333"

	property int baseControlHeight
	baseControlHeight: 40
	property int baseFontHeight
	baseFontHeight: baseControlHeight * 0.4

	Python {
		id: py
		Component.onCompleted: {
			addImportPath(Qt.resolvedUrl('.'));

			importModule('wifi', function() {
				py.call('wifi.scan', [], function (result) {
					console.log(result);
					for (var i = 0; i < result.length; i++) {
						result[i].checked = false;
						wifiListModel.append(result[i]);
					}
				});
			});
		}
	}

	Rectangle {
		id: wifiListHeader
		height: baseControlHeight
		anchors { top: parent.top; left: parent.left; right: parent.right; margins: 10;}
		color: "#111111"

		property string textColor;
		textColor: "white"

		property string mainColor;
		mainColor: "#d16d1d"

		Rectangle {
			height: parent.height
			width: parent.width
			gradient: Gradient {
				GradientStop { position: 0.0; color: "white" }
				GradientStop { position: 1.0; color: "black" }
			}
			opacity: 0.02
		}

		 Rectangle {
			 width: 8
			 height: parent.height
			 color: wifiListHeader.mainColor
		 }

		 RowLayout {
			 height: parent.height
			 anchors.left: parent.left
			 anchors.right: selectButtonHeader.left
			 anchors.leftMargin: height / 2
			 anchors.rightMargin: height / 2

			 Text {
				 text: "ESSID"
				 Layout.preferredWidth: parent.width / 4
				 font.pixelSize: baseFontHeight
				 color: wifiListHeader.textColor
			 }

			 Text {
				 text: "Quality"
				 Layout.preferredWidth: parent.width / 16
				 visible: (parent.width / 4 > 60)
				 font.pixelSize: baseFontHeight
				 color: wifiListHeader.textColor
			 }

			 Text {
				 text: "Auth"
				 Layout.preferredWidth: parent.width / 16
				 visible: (parent.width / 4 > 80)
				 font.pixelSize: baseFontHeight
				 color: wifiListHeader.textColor
			 }
		 }

		 Rectangle {
			 id: selectButtonHeader
			 height: parent.height
			 width: Math.max(parent.parent.width / 8, label.implicitWidth + height)
			 //color: checked ? Qt.lighter(wifiListHeader.mainColor, 4) : wifiListHeader.mainColor
			 color: "transparent"
			 anchors.right: parent.right
			 Text {
				 id: label;
				 text: "Select"
				 anchors.centerIn: parent
				 color: wifiListHeader.textColor
				 font.pixelSize: baseFontHeight
			 }
		 }
	 }

	ListView {
		id: wifiList
		spacing: 4
		anchors { top: wifiListHeader.bottom; left: parent.left; right: parent.right; bottom: parent.bottom; margins: 10; topMargin: 15 }
		clip: true

		model: ListModel {
			id: wifiListModel
		}

		delegate: Rectangle {
			width: wifiList.width
			height: baseControlHeight
			color: checked ? "#111111" : "#111111"
			clip: true

			property string textColor;
			textColor: "white"

			property string blueColor;
			blueColor: "#111c29"

			property bool detailShown;
			detailShown: false

			Rectangle {
				height: parent.height
				width: parent.width
				gradient: Gradient {
					GradientStop { position: 0.0; color: "white" }
					GradientStop { position: 1.0; color: "black" }
				}
				opacity: checked ? 0.06 : 0.02
			}

			/*Rectangle {
				id: detailView
				border.color: "#aa0000"
				border.width: 2
				height: 200
				width: parent.width
				anchors.top: parent.bottom
				transform: Translate {
					id: detailViewTranslate
					y: -200
					Behavior on y { NumberAnimation { duration: 400; easing.type: Easing.OutQuad } }
				}
				color: "green"
			}*/

			Rectangle {
				width: 8
				height: parent.height
				color: Qt.lighter(blueColor, checked ? 6 : 2)
			}

			RowLayout {
				height: parent.height
				anchors.left: parent.left
				anchors.right: detailButton.left
				anchors.leftMargin: height / 2
				anchors.rightMargin: height / 2

				Text {
					id: textEssid
					text: ESSID
					Layout.preferredWidth: parent.width / 4
					font.pixelSize: baseFontHeight
					color: textColor
				}

				Text {
					text: (Quality * 100).toFixed(1) + '%'
					Layout.preferredWidth: parent.width / 16
					visible: (parent.width / 4 > 60)
					font.pixelSize: baseFontHeight
					color: textColor
				}

				Text {
					text: Authentication
					Layout.preferredWidth: parent.width / 16
					visible: (parent.width / 4 > 80)
					font.pixelSize: baseFontHeight
					color: textColor
				}
			}

			Rectangle {
				id: detailButton
				height: parent.height
				width: Math.max(parent.parent.width / 8, label.implicitWidth + height)
				color: checked ? Qt.lighter(blueColor, 4) : blueColor
				anchors.right: parent.right
				 Text {
					 id: label;
					 text: "Select"
					 anchors.centerIn: parent
					 color: "white"
					 font.pixelSize: baseFontHeight
				 }
				 Rectangle {
					 anchors.bottom: parent.bottom
					 width: parent.width
					 height: parent.height / 10
					 color: Qt.lighter(parent.color, 2)
				 }

				 Rectangle {
					 height: parent.height
					 width: parent.width
					 gradient: Gradient {
						 GradientStop { position: 0.0; color: "white" }
						 GradientStop { position: 1.0; color: "black" }
					 }
					 opacity: checked ? 0.08 : 0.04
				 }

				 MouseArea {
					 anchors.fill: parent
					 onClicked: {
						 var item = wifiList.model.get(index);
						 item.checked = !item.checked;
					 }
				 }
			 }

			MouseArea {
				 id: mouseArea
				 anchors.fill: parent
				 onClicked: {
					 var item = wifiList.model.get(index);
					 item.checked = !item.checked;
				}
			}
		}

		populate: Transition {
			NumberAnimation { properties: "x,y"; duration: 400; easing.type: Easing.OutBounce }
		}
	}
}
