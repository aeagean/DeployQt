#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include "VersionModel.h"
#include <stdlib.h>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    qmlRegisterType<VersionModel>("VersionMode", 1, 0, "VersionMode");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
