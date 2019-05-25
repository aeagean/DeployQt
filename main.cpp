/**********************************************************
Author: Qtbig哥
WeChat Official Accounts Platform: nicaixiaoxuesheng (文章首发)
Website: qtbig.com(后续更新)
Email:  2088201923@qq.com
QQ交流群: 732271126
LISCENSE: MIT
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
