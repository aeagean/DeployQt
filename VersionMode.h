#ifndef VERSIONMODE_H
#define VERSIONMODE_H

#include <QObject>

class VersionMode : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList qtVersionList       READ qtVersionList                            NOTIFY listChanged)
    Q_PROPERTY(QStringList compilerVersionList READ compilerVersionList                      NOTIFY listChanged)
    Q_PROPERTY(QString     qtVersion           READ qtVersion       WRITE setQtVersion       NOTIFY statusChanged)
    Q_PROPERTY(QString     compilerVersion     READ compilerVersion WRITE setCompilerVersion NOTIFY statusChanged)

public:
    VersionMode();

    QStringList qtVersionList();
    QStringList compilerVersionList();


    QString     qtVersion();
    void        setQtVersion(const QString &version);

    QString     compilerVersion();
    void        setCompilerVersion(const QString &version);

signals:
    void listChanged();
    void statusChanged();

private:
    QStringList m_qtVersionList;
    QStringList m_compilerVersionList;
    QString m_qtVersion;
    QString m_compilerVersion;
};

#endif // VERSIONMODE_H
