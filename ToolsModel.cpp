/**********************************************************
Author: Qt君
微信公众号: Qt君(首发)
QQ群: 732271126
Email: 2088201923@qq.com
LICENSE: MIT
**********************************************************/
#include "ToolsModel.h"
#include <QDesktopServices>
#include <QUrl>

ToolsModel::ToolsModel(QObject *parent) : QObject(parent)
{

}

void ToolsModel::openUrl(const QString &url)
{
    QDesktopServices::openUrl(QUrl(url));
}
