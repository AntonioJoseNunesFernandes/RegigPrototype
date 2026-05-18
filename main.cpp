#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "coloredsvgimageprovider.h"

int main(int argc, char *argv[])
{
    qDebug() << QFile::exists(":/assets/Logo_Artists_1.svg");
    qDebug() << QFile::exists("/assets/fuck.txt");
    qDebug() << QFile::exists("assets/fuck.txt");
    qDebug() << QFile::exists(":/fuck.txt");
    qDebug() << QFile::exists("/fuck.txt");
    qDebug() << QFile::exists("fuck.txt");


    qputenv("QML_XHR_ALLOW_FILE_READ", "1");

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.addImageProvider("mysvgprovider", new ColoredSVGImageProvider);
    engine.loadFromModule("RegigPrototype", "Main");

    return QCoreApplication::exec();
}
