/**********************************************************
Author: Qtbig哥
WeChat Official Accounts Platform: nicaixiaoxuesheng (文章首发)
Website: qtbig.com(后续更新)
Email:  2088201923@qq.com
QQ交流群: 732271126
LISCENSE: MIT
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
