import QtQuick
import QtQuick.Layouts

Rectangle {
    enum Property_1 { Property_1_Default, Property_1_Variant2}

    id: button_artist

    property int property_2: Button_artist.Property_1.Property_1_Default

    height: 31
    width: 83

    color: "transparent"

    states: [
        State {
            name: "Property 1=Default"
            when: button_artist.property_2 === Button_artist.Property_1.Property_1_Default

            PropertyChanges {
                source: Qt.resolvedUrl("assets/button_1.png")
                target: button
            }
        },
        State {
            name: "Property 1=Variant2"
            when: button_artist.property_2 === Button_artist.Property_1.Property_1_Variant2

            PropertyChanges {
                source: Qt.resolvedUrl("assets/button.png")
                target: button
            }
        }
    ]

    FlexboxLayout {
        id: button_artistLayout

        x: 0
        y: 0

        height: 31
        width: 83

        alignContent: FlexboxLayout.AlignStretch
        alignItems: FlexboxLayout.AlignStart
        columnGap: 0
        direction: FlexboxLayout.Row
        justifyContent: FlexboxLayout.JustifyStart
        rowGap: 0

        Button_1 {
            id: button

            Layout.fillHeight: true
            Layout.fillWidth: true
            _size: Button_1.Size.Size_small
            _state: Button_1.State_1.State_1_normal
            clip: true
            icon_Left: false
            icon_Only_1: Button_1.Icon_Only.Icon_Only_false
            icon_Right: false
            outline_1: Button_1.Outline.Outline_false
            source: Qt.resolvedUrl("assets/button_1.png")
            type_1: Button_1.Type.Type_secondary
        }
    }
}