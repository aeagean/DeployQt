#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include "VersionMode.h"
#include <stdlib.h>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    _putenv_s("path",
                      "C:\\Qt\\Qt5.12.2\\5.12.2\\mingw73_32\\lib;C:\\Qt\\Qt5.12.2\\5.12.2\\mingw73_32\\bin;C:\\Qt\\Qt5.12.2\\Tools\\mingw730_32\\bin;C:\\Qt\\Qt5.12.2\\5.12.2\\mingw73_32\\bin;C:\\Qt\\Qt5.12.2\\Tools\\mingw730_32\\bin;C:\\Program Files (x86)\\Thunder Network\\Thunder\\Program\\;C:\\Program Files (x86)\\Intel\\Intel(R) Management Engine Components\\iCLS\\;C:\\Program Files\\Intel\\Intel(R) Management Engine Components\\iCLS\\;C:\\Windows\\system32;C:\\Windows;C:\\Windows\\System32\\Wbem;C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\;C:\\Windows\\System32\\OpenSSH\\;C:\\Program Files (x86)\\Intel\\Intel(R) Management Engine Components\\DAL;C:\\Program Files\\Intel\\Intel(R) Management Engine Components\\DAL;C:\\Program Files (x86)\\Intel\\Intel(R) Management Engine Components\\IPT;C:\\Program Files\\Intel\\Intel(R) Management Engine Components\\IPT;C:\\Program Files (x86)\\NVIDIA Corporation\\PhysX\\Common;C:\\Program Files\\Intel\\WiFi\\bin\\;C:\\Program Files\\Common Files\\Intel\\WirelessCommon\\;C:\\Program Files\\Git\\cmd;C:\\Windows\\system32\\config\\systemprofile\\AppData\\Local\\Microsoft\\WindowsApps;C:\\Users\\Strong\\AppData\\Local\\Microsoft\\WindowsApps"
              );
    QGuiApplication app(argc, argv);

    qmlRegisterType<VersionMode>("VersionMode", 1, 0, "VersionMode");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
