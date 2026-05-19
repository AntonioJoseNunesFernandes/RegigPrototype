import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    width: 440
    height: 956
    visible: true
    title: qsTr("Hello World")
    footer: TabBar{
        id: bottomTabBar
        width: parent.width

        TabButton {
            text: qsTr("1")
        }
        TabButton {
            text: qsTr("2")
        }
        TabButton {
            text: qsTr("3")
            enabled: false
        }
        TabButton {
            text: qsTr("4")
            enabled: false
        }
    }

    StackLayout {
        id: sl
        width: parent.width
        height: parent.height
        currentIndex: bottomTabBar.currentIndex
        Item {
            id: mapTab

            ColumnLayout {
                id: layout
                height: sl.height
                width: sl.width

                Layout.topMargin: 3
                Layout.bottomMargin: 3

                spacing: 0

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

                    Image {
                        id: please
                        property string iconColor: "00ff1a"

                        source: "image://mysvgprovider/assets/Logo_Artists_1.svg?color=" + iconColor
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
                    }
                }
            }
        }
        Item {
            id: followingTab

            ButtonVenueName{
                id: test
                venue_buttonLayoutWidth: parent.width
                venue_buttonLayoutHeight: 95

                Layout.topMargin: 30
            }
        }
        Item {
            id: artistSearchTab
        }
        Item {
            id: userTab
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
