/**********************************************************
Author: Qt君
微信公众号: Qt君(首发)
QQ群: 732271126
Email: 2088201923@qq.com
LICENSE: MIT
**********************************************************/
#ifndef TOOLS_H
#define TOOLS_H

#include <QObject>

class ToolsModel : public QObject
{
    Q_OBJECT
public:
    explicit ToolsModel(QObject *parent = nullptr);

    Q_INVOKABLE void openUrl(const QString &url);

signals:

public slots:
};

#endif // TOOLS_H
