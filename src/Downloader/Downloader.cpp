#include "Downloader.hpp"

#include <QtCore/QFileInfo>
#include <QtCore/QTimer>
#include <QtNetwork/QNetworkReply>
#include <QtNetwork/QNetworkRequest>
#include <QtCore/QtCore>

const QString AUTHOR = "Nemory Development Studios";
const QString APPNAME = "Droid Store";

Downloader::Downloader(QObject *parent)
    : QObject(parent), m_currentDownload(0), m_downloadedCount(0), m_totalCount(0), m_progressTotal(0), m_progressValue(0)
{}

void Downloader::download(const QString &url, const QString &packageid)
{
	QSettings settings(AUTHOR, APPNAME);
	QString saveLocation;

	if (settings.value("saveLocation").isNull() || settings.value("saveLocation") == "")
	{
		saveLocation = "/accounts/1000/shared/downloads/";
	}
	else
	{
		saveLocation = settings.value("saveLocation").toString();
	}

    const QString filename = saveLocation + packageid + ".apk";

    m_output.setFileName(filename);

    if (!m_output.open(QIODevice::WriteOnly))
    {
    	qDebug() << "PROBLEM OPENING FILE: " + filename;
        return;
    }

    QNetworkRequest request(url);
    m_currentDownload = m_manager.get(request);

    connect(m_currentDownload, SIGNAL(downloadProgress(qint64, qint64)), SLOT(downloadProgress(qint64, qint64)));
    connect(m_currentDownload, SIGNAL(finished()), SLOT(downloadFinished()));
    connect(m_currentDownload, SIGNAL(readyRead()), SLOT(downloadReadyRead()));

    qDebug() << "DOWNLOADING: " + url;

    m_downloadTime.start();
}

void Downloader::downloadProgress(qint64 bytesReceived, qint64 bytesTotal)
{
    m_progressTotal = bytesTotal;
    m_progressValue = bytesReceived;
    emit progressTotalChanged();
    emit progressValueChanged();

    double speed = bytesReceived * 1000.0 / m_downloadTime.elapsed();
    QString unit;

    if (speed < 1024)
    {
        unit = "bytes/sec";
    }
    else if (speed < 1024 * 1024)
    {
        speed /= 1024;
        unit = "kB/s";
    }
    else
    {
        speed /= 1024 * 1024;
        unit = "MB/s";
    }

    m_progressMessage = QString("%1 %2").arg(speed, 3, 'f', 1).arg(unit);
    emit progressMessageChanged();
}

void Downloader::downloadFinished()
{
    m_progressTotal = 0;
    m_progressValue = 0;
    m_progressMessage.clear();

    emit progressValueChanged();
    emit progressTotalChanged();
    emit progressMessageChanged();
    emit downloadDone();

    m_output.close();

    if (m_currentDownload->error())
    {
    	qDebug() << "DOWNLOADING ERROR: " + m_currentDownload->errorString();
    }
    else
    {
    	qDebug() << "DOWNLOADING SUCCEEDED: " + m_currentDownload->errorString();
        ++m_downloadedCount;
    }

    m_currentDownload->deleteLater();
    m_currentDownload = 0;
}

void Downloader::downloadReadyRead()
{
    m_output.write(m_currentDownload->readAll());
}

int Downloader::progressTotal() const
{
    return m_progressTotal;
}

int Downloader::progressValue() const
{
    return m_progressValue;
}

QString Downloader::progressMessage() const
{
    return m_progressMessage;
}
