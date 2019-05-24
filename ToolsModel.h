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
