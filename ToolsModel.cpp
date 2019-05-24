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
