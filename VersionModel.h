/**********************************************************
Author: Qtbig哥
WeChat Official Accounts Platform: nicaixiaoxuesheng (文章首发)
Website: qtbig.com(后续更新)
Email:  2088201923@qq.com
QQ交流群: 732271126
LISCENSE: MIT
**********************************************************/
#ifndef VERSIONMODEL_H
#define VERSIONMODEL_H

#include <QObject>
#include <QProcess>

class VersionModel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList qtVersionList       READ qtVersionList                            NOTIFY listChanged)
    Q_PROPERTY(QStringList compilerVersionList READ compilerVersionList                      NOTIFY listChanged)
    Q_PROPERTY(QString     qtVersion           READ qtVersion       WRITE setQtVersion       NOTIFY statusChanged)
    Q_PROPERTY(QString     compilerVersion     READ compilerVersion WRITE setCompilerVersion NOTIFY statusChanged)
    Q_PROPERTY(QString     exeFile             READ exeFile         WRITE setExeFile         NOTIFY statusChanged)

public:
    VersionModel();

    Q_INVOKABLE bool create();
    Q_INVOKABLE bool test();

    QStringList qtVersionList();
    QStringList compilerVersionList();


    QString     qtVersion();
    void        setQtVersion(const QString &version);

    QString     compilerVersion();
    void        setCompilerVersion(const QString &version);

    QString     exeFile();
    void        setExeFile(const QString &file);

signals:
    void listChanged();
    void statusChanged();

private:
    QStringList m_qtVersionList;
    QStringList m_compilerVersionList;
    QString m_qtVersion;
    QString m_qtVersionDirName;
    QString m_compilerVersion;
    QString m_exeFile;
    QString m_sourceEnvPath;
    QProcess m_testProcess;
};

#endif // VERSIONMODEL_H
