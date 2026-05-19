cmake_minimum_required(VERSION 3.16)

project(RegigPrototype VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick Svg Widgets QuickControls2)

qt_standard_project_setup(REQUIRES 6.10)

qt_add_executable(appRegigPrototype
    main.cpp
    coloredsvgimageprovider.cpp
    #bottomsheet.cpp
)

qt_add_resources(appRegigPrototype "assets"
    FILES assets/Logo_Artists.svg assets/Logo_Artists_1.svg assets/fuck.txt
)

qt_add_qml_module(appRegigPrototype
    URI RegigPrototype
    SOURCES
    coloredsvgimageprovider.h coloredsvgimageprovider.cpp
    #bottomsheet.h bottomsheet.cpp
    QML_FILES
        Main.qml
        ButtonVenueName.qml
        Header2.qml
        comment_section_code_holder.qml
        BottomSheet.qml
    RESOURCES
        assets/Logo_Artists.svg
        assets/Logo_Artists_1.svg
        assets/fuck.txt
    IMPORTS QtQuick.Controls.Fusion
)


# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appRegigPrototype PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appRegigPrototype
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appRegigPrototype
    PRIVATE Qt6::Quick
    PRIVATE Qt6::Svg
    PRIVATE Qt6::QuickControls2
    PRIVATE Qt6::Widgets
)

include(GNUInstallDirs)
install(TARGETS appRegigPrototype
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
