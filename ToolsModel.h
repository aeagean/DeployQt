/**********************************************************
Author: Qtbig哥
WeChat Official Accounts Platform: nicaixiaoxuesheng (文章首发)
Website: qtbig.com(后续更新)
Email:  2088201923@qq.com
QQ交流群: 732271126
LISCENSE: MIT
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
