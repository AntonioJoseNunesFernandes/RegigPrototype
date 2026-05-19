import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    width: 440
    height: 956
    visible: true
    title: qsTr("Hello World")

    ColumnLayout {
        id: layout
        x: 0
        y: 0
        height: parent.height
        width: parent.width

        Layout.topMargin: 3
        Layout.bottomMargin: 3

        spacing: 0

        Rectangle {
            id: r1

            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.preferredHeight: 95
            Layout.preferredWidth: parent.width
            border.color: "#000000"
            border.width: 1
            clip: true
            color: "#000000"
            radius: 3.20
        }

        Rectangle {
            id: r2

            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.preferredHeight: 95
            Layout.preferredWidth: parent.width
            border.color: "#ffffff"
            border.width: 1
            clip: true
            color: "#ffffff"
            radius: 3.20

            property string iconColor: "#000000"
            property string svgSource: ""
            property string svgDir: "assets/Logo_Artists.svg"

            Component.onCompleted: loadSvg(svgDir, iconColor, 73, 65, function(result) {svgSource = result})

            function loadSvg(dir, color_, width_, height_, callback) {
                var xhr = new XMLHttpRequest()
                xhr.open("GET", dir, true)
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === XMLHttpRequest.DONE) {
                        var raw = xhr.responseText

                        // Replace fill color
                        raw = raw.replace(/fill="[^"]*"/g,   `fill="${color_}"`)
                        // Replace width
                        raw = raw.replace(/width="[^"]*"/g,  `width="${width_}"`)
                        // Replace height
                        raw = raw.replace(/height="[^"]*"/g, `height="${height_}"`)

                        // Also handle stroke if needed
                        // raw = raw.replace(/stroke="[^"]*"/g, `stroke="${i}"`)

                        callback("data:image/svg xml;utf8," + encodeURIComponent(raw))
                    }
                }
                xhr.send()
            }

            Image {
                id: iconImage
                source: r2.svgSource
                width: 73
                height: 65
                sourceSize.width: 73
                sourceSize.height: 65

                anchors.leftMargin: 15
                anchors.topMargin: 15
                anchors.top : parent.top
                anchors.left: parent.left
            }

            Image {
                id: iconImage1
                source: "assets/Logo_Artists.svg"
                sourceSize.width: 73
                sourceSize.height: 65

                anchors.rightMargin: 15
                anchors.topMargin: 15
                anchors.top : parent.top
                anchors.right: parent.right
            }
        }

        Rectangle {
            id: r3

            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.preferredHeight: 95
            Layout.preferredWidth: parent.width
            border.color: "#000000"
            border.width: 1
            clip: true
            color: "#000000"
            radius: 3.20
        }

        Rectangle {
            id: r4

            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.preferredHeight: 95
            Layout.preferredWidth: parent.width
            border.color: "#ffffff"
            border.width: 1
            clip: true
            color: "#ffffff"
            radius: 3.20

            Image {
                id: please
                source: "image://mysvgprovider/assets/Logo_Artists_1.svg?color=000000"
                width: 73
                height: 65
                sourceSize.width: 73
                sourceSize.height: 65

                anchors.leftMargin: 15
                anchors.topMargin: 15
                anchors.top : parent.top
                anchors.left: parent.left
            }
        }

        Rectangle {
            id: r5

            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.preferredHeight: 95
            Layout.preferredWidth: parent.width
            border.color: "#000000"
            border.width: 1
            clip: true
            color: "#000000"
            radius: 3.20
        }

        Rectangle {
            id: r6

            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.preferredHeight: 95
            Layout.preferredWidth: parent.width
            border.color: "#6c757d"
            border.width: 1
            clip: true
            color: "#6c757d"
            radius: 3.20
        }

        Rectangle {
            id: r7

            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.preferredHeight: 95
            Layout.preferredWidth: parent.width
            border.color: "#000000"
            border.width: 1
            clip: true
            color: "#000000"
            radius: 3.20
        }

        Rectangle {
            id: r8

            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.preferredHeight: 95
            Layout.preferredWidth: parent.width
            border.color: "#6c757d"
            border.width: 1
            clip: true
            color: "#6c757d"
            radius: 3.20

            Button {
                text: "Open C++ Bottom Sheet"
                anchors.centerIn: parent
                onClicked: optionsSheet.open()
                //onClicked: {
                    // Pass the current active window handle context
                //    cPlusPlusSheet.openSheet()
                //}
            }
        }

        // Instantiating the C++ Bottom Sheet
        //BottomSheet {
            //id: cPlusPlusSheet
            // Link the widget parent to the window context mapping
            //Component.onCompleted: {
                // Internal window mapping connection
            //}
        //}

        Rectangle {
            id: r9

            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.preferredHeight: 95
            Layout.preferredWidth: parent.width
            border.color: "#000000"
            border.width: 1
            clip: true
            color: "#000000"
            radius: 3.20
        }

        ButtonVenueName{
            id: test
            venue_buttonLayoutWidth: parent.width
            venue_buttonLayoutHeight: 95
        }
    }

    BottomSheet {
        id: optionsSheet
        title: "Options"

        ColumnLayout {
            width: parent.width
            spacing: 0

            Repeater {
                model: [
                    { icon: "✏️",  label: "Edit"    },
                    { icon: "📋",  label: "Copy"    },
                    { icon: "🔗",  label: "Share"   },
                    { icon: "🗑️",  label: "Delete"  }
                ]

                delegate: Rectangle {
                    required property var modelData
                    Layout.fillWidth: true
                    height: 56
                    color: hovered ? "#F4F6FB" : "transparent"

                    property bool hovered: false

                    RowLayout {
                        anchors { fill: parent; leftMargin: 24; rightMargin: 24 }
                        spacing: 16

                        Text {
                            text: modelData.icon
                            font.pixelSize: 20
                        }
                        Text {
                            Layout.fillWidth: true
                            text:             modelData.label
                            font.pixelSize:   15
                            color:            "#1A1A2E"
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered:  parent.hovered = true
                        onExited:   parent.hovered = false
                        onClicked:  optionsSheet.close()
                    }

                    Rectangle {
                        anchors { left: parent.left; right: parent.right; bottom: parent.bottom }
                        height: 1
                        color:  "#10F0F0"
                        visible: true
                    }
                }
            }
        }
    }
}
