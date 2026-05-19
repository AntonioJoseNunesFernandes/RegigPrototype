import QtQuick
import QtQuick.Shapes

Rectangle {
    enum Property_1 { Property_1_Default, Property_1_Variant2}

    id: header_2

    property int property_2: Header_2.Property_1.Property_1_Default

    height: 28
    width: 440

    clip: true
    color: "#ffffff"

    states: [
        State {
            name: "Property 1=Default"
            when: header_2.property_2 === Header_2.Property_1.Property_1_Default

            PropertyChanges {
                target: icon
                visible: true
            }
        },
        State {
            name: "Property 1=Variant2"
            when: header_2.property_2 === Header_2.Property_1.Property_1_Variant2

            PropertyChanges {
                target: icon
                visible: false
            }
        }
    ]

    Rectangle {
        id: icon

        height: 16.67
        width: 27.83

        color: "transparent"

        Shape {
            id: icon_1

            height: 16.67
            width: 27.83

            ShapePath {
                id: icon_1_ShapePath0

                fillColor: "#00000000"
                fillRule: ShapePath.WindingFill
                strokeColor: "#000000"
                strokeWidth: 3

                PathSvg {
                    id: icon_1_ShapePath0_PathSvg0

                    path: "M 8.333343505859375 16.666704177856445 L 0 8.333369255065918 L 8.333343505859375 0"
                }
            }
        }
    }
}