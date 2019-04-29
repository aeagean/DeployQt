#include "VersionMode.h"
#include <QDir>
#include <QDebug>

static const QString PROGRAMS_PATH = QDir::homePath() + "/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/";

VersionMode::VersionMode()
{
    qDebug()<<PROGRAMS_PATH;

    QDir dir(PROGRAMS_PATH);
    QStringList filter = QStringList()<<"Qt*";
    m_qtVersionList = dir.entryList(filter, QDir::NoFilter, QDir::Name);
}

QStringList VersionMode::qtVersionList()
{
    return m_qtVersionList;
}

QStringList VersionMode::compilerVersionList()
{
    QString qtVersionPath = PROGRAMS_PATH + m_qtVersion;

    QDir dir(qtVersionPath);
    dir.cd(m_qtVersion.mid(3));
    qDebug()<<dir.path();
    m_compilerVersionList = dir.entryList(dir.filter() | QDir::NoDotAndDotDot);
    qDebug()<<m_compilerVersionList;
    return m_compilerVersionList;
}

QString VersionMode::qtVersion()
{
    return m_qtVersion;
}

void VersionMode::setQtVersion(const QString &version)
{
    m_qtVersion = version;

    emit statusChanged();
    emit listChanged();
}

QString VersionMode::compilerVersion()
{
    return QString();
}

void VersionMode::setCompilerVersion(const QString &version)
{

}
