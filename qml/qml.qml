import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1
import io.thp.pyotherside 1.3

ApplicationWindow {
    title: qsTr("Hello World i3float")
    id: mainWindow
    width: 720
    height: 860
    color: "black"
    property bool menu_shown: false
    /* this rectangle contains the "menu" */
    Rectangle {
        id: menuView
        anchors.fill: parent
        //color: "#303030";
        gradient: Gradient {
             GradientStop { position: 0.0; color: "red" }
             GradientStop { position: 0.33; color: "yellow" }
             GradientStop { position: 1.0; color: "green" }
         }

        opacity: mainWindow.menu_shown ? 1 : 0
        Behavior on opacity { NumberAnimation { duration: 300 } }
        /* this is my sample menu content (TODO: replace with your own) */
        ListView {
            anchors { fill: parent; margins: 22 }
            model: ListModel {
                ListElement {
                    label: "Scan"
                    source: "ScanPage"
                }
                ListElement {
                    label: "Map"
                    source: "MapPage"
                }
            }
            spacing: 2
            delegate: Rectangle {
                height: 40;
                width: parent.width - 44;
                color: "#AAA"

                Text {
                    anchors { left: parent.left; leftMargin: 12; verticalCenter: parent.verticalCenter }
                    color: "white";
                    font.pixelSize: 25;
                    text: label
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("Loading " + source);
                        normalView.currentPage = source
                        mainWindow.onMenu();
                    }
                }
            }
        }
    }
    /* this rectangle contains the "normal" view in your app */
    Rectangle {
        id: normalView
        anchors.fill: parent
        color: "#333"
        /* this is what moves the normal view aside */

        transform: Translate {
            id: normalViewTranslate
            x: 0
            Behavior on x { NumberAnimation { duration: 400; easing.type: Easing.OutQuad } }
        }

        /* quick and dirty menu "button" for this demo (TODO: replace with your own) */
        Rectangle {
            id: topPanel

            color: "#222222"
            width: parent.width
            height: Math.min(parent.height / 64 + 25, 40)

//            id: menu_bar_
            anchors.top: parent.top
            Rectangle {
                id: menu_button_
                anchors {left: parent.left; verticalCenter: parent.verticalCenter; margins: 2 }
                color: "white"; implicitWidth: menuLabel.width; height: parent.height - 2; smooth: true
                scale: ma_.pressed ? 1.2 : 1
                Text { id: menuLabel; anchors.centerIn: parent; anchors.margins: 10; font.pixelSize: 48; fontSizeMode: Text.VerticalFit; text: "Menu" }
                MouseArea { id: ma_; anchors.fill: parent; onClicked: mainWindow.onMenu(); }
            }
        }

        //Put the name of the QML files containing your pages (without the '.qml')
        property variant pagesList  : [
            "ScanPage",
            "MapPage"
        ];

        // Set this property to another file name to change page
        property string  currentPage : "ScanPage";

        Repeater {
            model: normalView.pagesList;
            delegate: Loader {
                active: false;
                asynchronous: true;
                anchors.top: topPanel.bottom
                anchors { top: topPanel.bottom; bottom: parent.bottom; left: parent.left; right: parent.right; margins: 10 }
                visible: (normalView.currentPage === modelData);
                source: "%1.qml".arg(modelData)
                onVisibleChanged:      { loadIfNotLoaded(); }
                Component.onCompleted: { loadIfNotLoaded(); }

                function loadIfNotLoaded () {
                    // to load the file at first show
                    if (visible && !active) {
                        active = true;
                    }
                }
            }
        }
        /* put this last to "steal" touch on the normal window when menu is shown */
        MouseArea {
            anchors.fill: parent
            enabled: mainWindow.menu_shown
            onClicked: mainWindow.onMenu();
        }
        Rectangle {
            anchors.fill: parent
            opacity: mainWindow.menu_shown ? 0.4 : 0
            Behavior on opacity { NumberAnimation { duration: 300 } }
            color: "#000"
        }

    }
    /* this functions toggles the menu and starts the animation */
    function onMenu()
    {
        normalViewTranslate.x = mainWindow.menu_shown ? 0 : mainWindow.width * 0.3
        mainWindow.menu_shown = !mainWindow.menu_shown;
    }
}
