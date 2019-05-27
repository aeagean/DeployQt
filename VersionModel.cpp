/**********************************************************
Author: Qtbig哥
WeChat Official Accounts Platform: nicaixiaoxuesheng (文章首发)
Website: qtbig.com(后续更新)
Email:  2088201923@qq.com
QQ交流群: 732271126
LISCENSE: MIT
**********************************************************/
#include "VersionModel.h"
#include <QDir>
#include <QProcess>
#include <QtGlobal>
#include <QDebug>

static const QString PROGRAMS_PATH = QDir::homePath() + "/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/";

static QString qtEnvPath(const QString &envPath)
{
    QString result;
    QFile file(envPath + "/qtenv2.bat");
    if (!file.open(QIODevice::ReadOnly)) {
        qDebug()<<"[Info] "<<"Qt Env Path: "<<result;
        return result;
    }

    while (!file.atEnd()) {
        QString line = QString(file.readLine());
        int index = line.indexOf("set PATH=");
        if (index != -1) {
            result = line.mid(9).remove("%PATH%").trimmed();
        }
    }

    file.close();
    qDebug()<<"[Info] "<<"Qt Env Path: "<<result;
    return result;
}

VersionModel::VersionModel()
{
    m_sourceEnvPath = qgetenv("PATH");
}

bool VersionModel::create()
{
    m_testProcess.kill();
    qDebug()<<"[Info] "<<"Exe File: "<<m_exeFile;
    qDebug()<<"[Info] "<<"Qt Version: "<<m_qtVersion;
    qDebug()<<"[Info] "<<"Compiler Version: "<<m_compilerVersion;

    QDir dir(PROGRAMS_PATH + m_qtVersion + "/" + m_qtVersionDirName + "/" + m_compilerVersion);
    QStringList dirs = dir.entryList(QDir::Files);
    QString qtBinPath;
    if (! dirs.empty()) {
        QFileInfo info(dir.path() + "/" + dirs.first());

        QFileInfo sourceFile(info.symLinkTarget());
        qtBinPath = sourceFile.path();
        QDir qtDir = sourceFile.dir();
        qtDir.cdUp();
        QString qtPath = qtDir.path();
        qDebug()<<"[Info] "<<"Qt Path"<<qtPath;
        qDebug()<<"[Info] "<<qtBinPath;

        QStringList arguments;
        arguments<<"--qmldir"<<qtPath + "/qml"<<m_exeFile<<"--release";

        QProcess process;
        QString path = qtEnvPath(qtBinPath) + ";" + m_sourceEnvPath;
        qputenv("PATH", path.toStdString().c_str());
        process.start("windeployqt.exe", arguments);

        process.waitForStarted();
        process.waitForFinished();
        qDebug()<<"[Info]"<<"Result Output: "<<process.readAllStandardOutput().toStdString().c_str();
        qDebug()<<"[Info]"<<"Error Output: "<<process.readAllStandardError().toStdString().c_str();
        qDebug()<<"[Info]"<<"Status: "<<process.exitCode()<<process.exitStatus();

        return process.exitCode() == 0 && process.exitStatus() == QProcess::NormalExit;
    }

    return true;
}

bool VersionModel::test()
{
    qDebug()<<"[Info]"<<"testing"<<m_exeFile;
    QFileInfo testFileInfo(m_exeFile);
    m_testProcess.setProgram(m_exeFile);
    m_testProcess.start();

    if (! m_testProcess.waitForStarted())
        return false;

    if (! m_testProcess.waitForFinished())
        return false;

    qDebug()<<"[Info]"<<"Test Process Output: "<<m_testProcess.readAllStandardOutput();
    qDebug()<<"[Info]"<<"Test Process Input: "<<m_testProcess.readAllStandardError();
    qDebug()<<"[Info]"<<"Test status: "<<m_testProcess.exitCode()<<m_testProcess.exitStatus()<<m_testProcess.errorString();

    return m_testProcess.exitCode() == 0 && m_testProcess.exitStatus() == QProcess::NormalExit;
}

QStringList VersionModel::qtVersionList()
{
    QDir dir(PROGRAMS_PATH);
    QStringList filter = QStringList()<<"Qt*";

    return dir.entryList(filter, QDir::NoFilter, QDir::Name);
}

QStringList VersionModel::compilerVersionList()
{
    QString qtVersionPath = PROGRAMS_PATH + m_qtVersion;
    QDir dir(qtVersionPath);

    int index = dir.entryList(dir.filter() | QDir::Dirs).indexOf(QRegExp("^[5]+(\\.\\d+)*$"));
    if (index != -1) {
        m_qtVersionDirName = dir.entryList().at(index);
        dir.cd(m_qtVersionDirName);
    }

    QStringList compilerList = dir.entryList(dir.filter() | QDir::NoDotAndDotDot);
    if (! compilerList.isEmpty())
        m_compilerVersion = compilerList.first();

    return compilerList;
}

QString VersionModel::qtVersion()
{
    return m_qtVersion;
}

void VersionModel::setQtVersion(const QString &version)
{
    m_qtVersion = version;

    emit statusChanged();
    emit listChanged();
}

QString VersionModel::compilerVersion()
{
    return m_compilerVersion;
}

void VersionModel::setCompilerVersion(const QString &version)
{
    m_compilerVersion = version;
    emit statusChanged();
}

QString VersionModel::exeFile()
{
    return m_exeFile;
}

void VersionModel::setExeFile(const QString &file)
{
    m_exeFile = file;
    emit statusChanged();
}
