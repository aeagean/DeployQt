/**********************************************************
Author: Qt君
微信公众号: Qt君(首发)
QQ群: 732271126
Email: 2088201923@qq.com
LICENSE: MIT
**********************************************************/
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include <stdlib.h>
#include <QDebug>
#include "VersionModel.h"
#include "ToolsModel.h"

class Application : public QGuiApplication
{
public:
    Application(int &argc, char ** argv) : QGuiApplication(argc, argv) {}

    bool notify(QObject *receiver, QEvent *e) {
        return QGuiApplication::notify(receiver, e);
    }
};

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    Application app(argc, argv);

    qmlRegisterType<VersionModel>("VersionMode", 1, 0, "VersionMode");
    qmlRegisterType<ToolsModel>("ToolsModel", 1, 0, "ToolsModel");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/Qml/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
