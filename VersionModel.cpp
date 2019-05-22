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

VersionModel::VersionModel()
{
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
        QString path = qtBinPath + ";" + qgetenv("PATH");
        qputenv("PATH", path.toStdString().c_str());
        process.start("windeployqt.exe", arguments);

        process.waitForFinished();
        qDebug()<<"[Info]"<<"Result Output: "<<process.readAllStandardOutput().toStdString().c_str();
        qDebug()<<"[Info]"<<"Error Output: "<<process.readAllStandardError().toStdString().c_str();
    }

    return true;
}

bool VersionModel::test()
{
    qDebug()<<"[Info]"<<"testing"<<m_exeFile;
    QFileInfo testFileInfo(m_exeFile);
//    m_testProcess.setWorkingDirectory(testFileInfo.absolutePath());
    m_testProcess.startDetached(m_exeFile);
//    m_testProcess.waitForFinished();
    qDebug()<<m_testProcess.readAllStandardOutput();
    qDebug()<<m_testProcess.readAllStandardError();

    return true;
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
