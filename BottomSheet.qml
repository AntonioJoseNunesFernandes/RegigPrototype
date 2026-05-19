import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// BottomSheet.qml
// Usage:
//   BottomSheet {
//       id: sheet
//       title: "Options"
//       // Add your content as children — they go inside the sheet body
//       Text { text: "Hello from the sheet!" }
//   }
//   sheet.open()

Item {
    id: root

    // ── Public API ────────────────────────────────────────────────
    property string title: ""
    property real   peekHeight:  48           // height of the drag handle + title row
    property real   sheetRadius: 20           // corner radius of the sheet card
    property color  sheetColor:   "#FFFFFF"
    property color  handleColor:  "#D0D0D0"
    property color  titleColor:   "#1A1A2E"
    property bool   dragEnabled:  true

    // read-only state
    readonly property bool isOpen: _state === "open"

    function open()  { _state = "open"  }
    function close() { _state = "closed" }
    function toggle() { _state = (_state === "open") ? "closed" : "open" }

    // ── Internals ────────────────────────────────────────────────
    property string _state: "closed"

    // Fill the parent so the overlay covers the whole screen
    anchors.fill: parent
    anchors.bottomMargin: 15
    anchors.topMargin: 15
    anchors.leftMargin: 15
    anchors.rightMargin: 15
    // Don't steal events when closed
    enabled: _state === "open"

    // ── background blur / overlay ─────────────────────────────────────────
    Rectangle {
        id: overlay
        anchors.fill: parent
        //color: root.overlayColor
        opacity: 0
        visible: true

        Behavior on opacity {
            NumberAnimation { duration: 280; easing.type: Easing.InOutQuad }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: root.close()
        }
    }

    // ── Sheet card ───────────────────────────────────────────────
    Rectangle {
        id: sheet

        width:  parent.width
        height: contentColumn.implicitHeight + root.sheetRadius  // auto-size to content
        // clamp: never taller than 90 % of the screen
        property real maxH: parent.height * 0.90
        Component.onCompleted: if (height > maxH) height = maxH

        // Start off-screen (below the bottom edge)
        y: parent.height
        anchors.horizontalCenter: parent.horizontalCenter

        color:  root.sheetColor
        radius: root.sheetRadius

        // Only round the top two corners
        Rectangle {
            anchors { left: parent.left; right: parent.right; bottom: parent.bottom }
            height: root.sheetRadius
            color:  root.sheetColor
        }

        layer.enabled: true
        layer.effect: null   // shadow via drop-shadow workaround below

        // Soft shadow
        Rectangle {
            anchors.fill:    parent
            anchors.margins: -1
            color:           "transparent"
            radius:          root.sheetRadius
            border.color:    Qt.rgba(0,0,0,0.7)
            border.width:    1
            z: -1
        }

        // ── Content ──────────────────────────────────────────────
        ColumnLayout {
            id: contentColumn
            width: parent.width
            spacing: 0

            // Drag handle
            Item {
                Layout.fillWidth: true
                height: 28

                Rectangle {
                    anchors.centerIn: parent
                    width:  40
                    height: 4
                    radius: 2
                    color:  root.handleColor
                }

                // Drag area on the handle row
                MouseArea {
                    anchors.fill: parent
                    enabled:      root.dragEnabled
                    property real _startY: 0
                    property real _startSheetY: 0

                    onPressed: (mouse) => {
                        _startY      = mouse.y
                        _startSheetY = sheet.y
                        dragAnim.stop()
                    }

                    onPositionChanged: (mouse) => {
                        const delta = mouse.y - _startY
                        const newY  = _startSheetY + delta
                        const minY  = root.height - sheet.height
                        sheet.y = Math.max(minY, newY)
                    }

                    onReleased: {
                        const threshold = sheet.height * 0.30
                        const minY = root.height - sheet.height
                        if (sheet.y - minY > threshold) {
                            root.close()
                        } else {
                            // snap back
                            dragAnim.to = minY
                            dragAnim.start()
                        }
                    }
                }
            }

            // Optional title
            Text {
                visible:             root.title !== ""
                Layout.fillWidth:    true
                Layout.leftMargin:   24
                Layout.rightMargin:  24
                Layout.bottomMargin: 8
                text:                root.title
                font.pixelSize:      17
                font.weight:         Font.DemiBold
                color:               root.titleColor
                elide:               Text.ElideRight
            }

            // Divider under title
            Rectangle {
                visible:          root.title !== ""
                Layout.fillWidth: true
                height:           1
                color:            "#F0F0F0"
            }

            // ── User content goes here ────────────────────────
            Item {
                id: contentSlot
                Layout.fillWidth:   true
                Layout.leftMargin:  0
                Layout.rightMargin: 0
                implicitHeight:     _childrenHeight()

                // Reflect children added by the user
                // (children of BottomSheet are reparented here via the default property)
                function _childrenHeight() {
                    let h = 0
                    for (let i = 0; i < contentSlot.children.length; i++)
                        h += contentSlot.children[i].implicitHeight || contentSlot.children[i].height || 0
                    return h || 0
                }
            }
        }

        // Snap-back animation
        NumberAnimation {
            id: dragAnim
            target:   sheet
            property: "y"
            duration: 220
            easing.type: Easing.OutCubic
        }

        Behavior on y {
            id: yBehavior
            enabled: _state !== "dragging"
            NumberAnimation {
                duration:     320
                easing.type:  Easing.OutCubic
            }
        }
    }

    // ── State machine ────────────────────────────────────────────
    states: [
        State {
            name: "open"
            when: root._state === "open"
            PropertyChanges { target: sheet;    y: root.height - sheet.height }
        },
        State {
            name: "closed"
            when: root._state === "closed"
            PropertyChanges { target: sheet;    y: root.height }
        }
    ]

    // Default property lets children be placed inside contentSlot automatically
    default property alias content: contentSlot.data
}
