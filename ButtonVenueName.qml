import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes

Rectangle {
    id: venue_button

    property alias _color_ShapePath0StrokeColor: _color_ShapePath0.strokeColor
    property alias _textLayoutHeight: _textLayout.height
    property alias _textLayoutWidth: _textLayout.width
    property alias _text_1Color: _text_1.color
    property alias _text_1Text: _text_1.text
    property alias button_BorderColor: button_.border.color
    property alias button_BorderWidth: button_.border.width
    property alias button_Color: button_.color
    property alias button_LayoutWidth: button_Layout.width
    property alias venue_buttonLayoutWidth: venue_buttonLayout.width
    property alias venue_buttonLayoutHeight: venue_buttonLayout.height

    height: 24
    width: 226

    color: "transparent"

    FlexboxLayout {
        id: venue_buttonLayout

        x: 0
        y: 0

        height: 24
        width: 226

        alignContent: FlexboxLayout.AlignStretch
        alignItems: FlexboxLayout.AlignStart
        columnGap: 0
        direction: FlexboxLayout.Row
        justifyContent: FlexboxLayout.JustifyStart
        rowGap: 0

        Rectangle {
            id: button_

            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.preferredHeight: 24
            Layout.preferredWidth: 226
            border.color: "#6c757d"
            border.width: 1
            clip: true
            color: "#6c757d"
            radius: 3.20

            FlexboxLayout {
                id: button_Layout

                x: 10
                y: 4

                height: 16
                width: 208

                alignContent: FlexboxLayout.AlignCenter
                alignItems: FlexboxLayout.AlignCenter
                columnGap: 20
                direction: FlexboxLayout.Row
                justifyContent: FlexboxLayout.JustifyCenter
                rowGap: 0

                Rectangle {
                    id: _text

                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.preferredHeight: 14
                    Layout.preferredWidth: 162
                    clip: true
                    color: "#00ffffff"

                    FlexboxLayout {
                        id: _textLayout

                        x: 0
                        y: 0

                        height: 14
                        width: 162

                        alignContent: FlexboxLayout.AlignStart
                        alignItems: FlexboxLayout.AlignStart
                        direction: FlexboxLayout.Column
                        justifyContent: FlexboxLayout.JustifyCenter
                        rowGap: 0

                        Text {
                            id: _text_1

                            Layout.preferredHeight: 21
                            Layout.preferredWidth: 85
                            color: "#ffffff"
                            font.family: "ABeeZee"
                            font.pixelSize: 14
                            font.weight: Font.Normal
                            horizontalAlignment: Text.AlignLeft
                            lineHeight: 21
                            lineHeightMode: Text.FixedHeight
                            text: "Venue Name"
                            textFormat: Text.PlainText
                            verticalAlignment: Text.AlignTop
                        }
                    }
                }
                Rectangle {
                    id: icon_2

                    Layout.preferredHeight: 24
                    Layout.preferredWidth: 24
                    color: "transparent"

                    Shape {
                        id: _color

                        x: 10
                        y: 7

                        height: 10
                        width: 5

                        transform: Scale {
                            origin.x: _color.width / 2
                            origin.y: _color.height / 2
                            xScale: -1
                        }

                        ShapePath {  //probably replace PathSvg with ShapePath (see QML Documentation)
                            id: _color_ShapePath0

                            fillColor: "#00000000"
                            strokeColor: "#ffffff"
                            strokeWidth: 2

                            PathSvg {
                                id: _color_ShapePath0_PathSvg0

                                path: "M 5 0 L 0 5 L 5 10"
                            }
                        }
                    }
                }
            }
        }
    }
}