/**********************************************************
Author: Qt君
微信公众号: Qt君(首发)
QQ群: 732271126
Email: 2088201923@qq.com
LICENSE: MIT
**********************************************************/
#ifndef VERSIONMODEL_H
#define VERSIONMODEL_H

#include <QObject>
#include <QProcess>
#include <QUrl>

class VersionModel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList qtVersionList       READ qtVersionList                            NOTIFY listChanged)
    Q_PROPERTY(QStringList compilerVersionList READ compilerVersionList                      NOTIFY listChanged)
    Q_PROPERTY(QStringList buildTypeList       READ buildTypeList                            NOTIFY listChanged)
    Q_PROPERTY(QString     qtVersion           READ qtVersion       WRITE setQtVersion       NOTIFY statusChanged)
    Q_PROPERTY(QString     buildType           READ buildType       WRITE setBuildType       NOTIFY statusChanged)
    Q_PROPERTY(QString     compilerVersion     READ compilerVersion WRITE setCompilerVersion NOTIFY statusChanged)
    Q_PROPERTY(QString     exeFile             READ exeFile         WRITE setExeFile         NOTIFY statusChanged)
    Q_PROPERTY(QUrl        qmlDir              READ qmlDir          WRITE setQmlDir          NOTIFY statusChanged)
public:
    VersionModel();

    Q_INVOKABLE bool create();
    Q_INVOKABLE bool test();

    QStringList qtVersionList();
    QStringList compilerVersionList();
    QStringList buildTypeList();

    QString     buildType();
    void        setBuildType(const QString &buildType);

    QString     qtVersion();
    void        setQtVersion(const QString &version);

    QString     compilerVersion();
    void        setCompilerVersion(const QString &version);

    QString     exeFile();
    void        setExeFile(const QString &file);


    QUrl        qmlDir();
    void        setQmlDir(const QUrl &dir);

signals:
    void listChanged();
    void statusChanged();

private:
    QStringList m_qtVersionList;
    QStringList m_compilerVersionList;
    QString m_qtVersion;
    QString m_qtVersionDirName;
    QString m_compilerVersion;
    QString m_buildType;
    QString m_exeFile;
    QUrl    m_qmlDir;
    QString m_sourceEnvPath;
    QProcess m_testProcess;
};

#endif // VERSIONMODEL_H
