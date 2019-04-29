#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include "VersionMode.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    qmlRegisterType<VersionMode>("VersionMode", 1, 0, "VersionMode");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
