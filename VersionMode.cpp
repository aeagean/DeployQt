#include "VersionMode.h"
#include <QDir>
#include <QDebug>

static const QString PROGRAMS_PATH = QDir::homePath() + "/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/";

VersionMode::VersionMode()
{
}

QStringList VersionMode::qtVersionList()
{
    QDir dir(PROGRAMS_PATH);
    QStringList filter = QStringList()<<"Qt*";

    return dir.entryList(filter, QDir::NoFilter, QDir::Name);
}

QStringList VersionMode::compilerVersionList()
{
    QString qtVersionPath = PROGRAMS_PATH + m_qtVersion;
    QDir dir(qtVersionPath);

    int index = dir.entryList(dir.filter() | QDir::Dirs).indexOf(QRegExp("^[5]+(\\.\\d+)*$"));
    if (index != -1) {
        dir.cd(dir.entryList().at(index));
    }

    return dir.entryList(dir.filter() | QDir::NoDotAndDotDot);
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
