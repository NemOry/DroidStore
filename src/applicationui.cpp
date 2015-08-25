/*
 * Copyright (c) 2011-2013 BlackBerry Limited.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include "applicationui.hpp"
#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/LocaleHandler>

#include <bb/system/InvokeRequest>
#include <bb/cascades/Invocation>
#include <bb/system/SystemDialog>
#include <bb/system/SystemToast>
#include <bb/system/SystemProgressToast>
#include <bb/system/SystemProgressDialog>

#include <bb/PackageInfo>
#include <bb/data/SqlDataAccess>

#include "WebImageView.h"
#include "DroidStoreAPI.h"

#include <Flurry.h>
#include <QtLocationSubset/QGeoPositionInfoSource>
#include <QtLocationSubset/QGeoCoordinate>

using namespace bb::cascades;
using namespace bb::system;
using bb::PackageInfo;
using bb::data::SqlDataAccess;

const QString ApplicationUI::AUTHOR = "Nemory Development Studios";
const QString ApplicationUI::APPNAME = "Droid Store";

ApplicationUI::ApplicationUI(bb::cascades::Application *app) :
        QObject(app)
{
	invokeManager = new InvokeManager();

	qmlRegisterType<QTimer>("my.library", 1, 0, "QTimer");

    QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);
    qml->setContextProperty("_app", this);

    DroidStoreAPI *droidStoreAPI = new DroidStoreAPI();
	qml->setContextProperty("_droidStoreAPI", droidStoreAPI);

    PackageInfo packageInfo;
	QDeclarativePropertyMap* map = new QDeclarativePropertyMap(this);
	map->setProperty("version", packageInfo.version());
	map->setProperty("author", packageInfo.author());
	qml->setContextProperty("_packageInfo", map);

    AbstractPane *root = qml->createRootObject<AbstractPane>();
    app->setScene(root);

    SqlDataAccess sda(dbPath());
    //sda.execute("DROP TABLE Favorites");
	sda.execute("CREATE TABLE IF NOT EXISTS Favorites( packageid TEXT, url TEXT, name TEXT, description TEXT, price TEXT, rating TEXT, image TEXT, isfree TEXT, publishername TEXT, publisherurl TEXT);");

	//sda.execute("DROP TABLE Downloads");
	sda.execute("CREATE TABLE IF NOT EXISTS Downloads( packageid TEXT, iconURL TEXT, name TEXT, status TEXT);");

	//sda.execute("DROP TABLE RecentSearches");
	sda.execute("CREATE TABLE IF NOT EXISTS RecentSearches( searchText TEXT);");

	QGeoPositionInfoSource *source = QGeoPositionInfoSource::createDefaultSource(this);

	if (source)
	{
		bool positionUpdatedConnected = connect(source, SIGNAL(positionUpdated (const QGeoPositionInfo &)), this, SLOT(positionUpdated (const QGeoPositionInfo &)));

		if (positionUpdatedConnected)
		{
			source->requestUpdate();
		}
		else
		{
			qDebug() << "positionUpdated connection failed";
			Flurry::Analytics::LogError("positionUpdated connection failed");
		}
	}
	else
	{
		qDebug() << "Failed to create QGeoPositionInfoSource";
		Flurry::Analytics::LogError("QGeoPositionInfoSource::createDefaultSource(this) failed");
	}
}

void ApplicationUI::positionUpdated(const QGeoPositionInfo &update)
{
	if (!update.isValid())
	{
		Flurry::Analytics::LogError("positionUpdated returned invalid location fix");
		return;
	}

	QGeoCoordinate coordinate = update.coordinate();
	Flurry::Analytics::SetLocation(coordinate.latitude(),
			coordinate.longitude(),
			update.attribute(QGeoPositionInfo::HorizontalAccuracy),
			update.attribute(QGeoPositionInfo::VerticalAccuracy));
}

void ApplicationUI::flurrySetUserID(QString value)
{
	Flurry::Analytics::SetUserID(value);
}

void ApplicationUI::flurryLogError(QString value)
{
	Flurry::Analytics::LogError(value);
}

void ApplicationUI::flurryLogEvent(QString value)
{
	Flurry::Analytics::LogEvent(value);
}

void ApplicationUI::addToRecentSearches
	(
		QString searchText
	)
{
	if(!existsInRecentSearches(searchText))
	{
		QFile file(dbPath());

		if (file.open(QIODevice::ReadWrite))
		{
			SqlDataAccess sda(dbPath());
			sda.execute("INSERT INTO RecentSearches (searchText) VALUES ("
					"'" + searchText + "');");
		}
	}
}

void ApplicationUI::clearRecentSearches()
{
	QFile file(dbPath());

	if (file.open(QIODevice::ReadWrite))
	{
		SqlDataAccess sda(dbPath());
		sda.execute("DELETE FROM RecentSearches");

		showToast("Cleared Recent Searches");
	}
}

void ApplicationUI::removeFromRecentSearches(QString searchText)
{
	if(existsInRecentSearches(searchText))
	{
		QFile file(dbPath());

		if (file.open(QIODevice::ReadWrite))
		{
			SqlDataAccess sda(dbPath());
			sda.execute("DELETE FROM RecentSearches WHERE searchText = '" + searchText + "'");
		}
	}
}

int ApplicationUI::recentSearchesCount()
{
	int result = 0;

	QFile file(dbPath());

	if (file.open(QIODevice::ReadWrite))
	{
		SqlDataAccess sda(dbPath());
		QVariant list = sda.execute("SELECT * FROM RecentSearches");
		QVariantList vlist = list.value<QVariantList>();

		result = vlist.size();
	}

	return result;
}

bool ApplicationUI::existsInRecentSearches(QString searchText)
{
	bool result = false;

	QFile file(dbPath());

	if (file.open(QIODevice::ReadWrite))
	{
		SqlDataAccess sda(dbPath());
		QVariant list = sda.execute("SELECT * FROM RecentSearches WHERE searchText = '" + searchText + "'");
		QVariantList vlist = list.value<QVariantList>();

		if(vlist.size() > 0)
		{
			result = true;
		}
	}

	return result;
}

//===========================

void ApplicationUI::addToDownloads
	(
		QString packageid,
		QString iconURL,
		QString name,
		QString status
	)
{
	if(!existsInDownloads(packageid))
	{
		QFile file(dbPath());

		if (file.open(QIODevice::ReadWrite))
		{
			SqlDataAccess sda(dbPath());
			sda.execute("INSERT INTO Favorites (packageid, iconURL, name, status) VALUES ("
					"'" + packageid + "', "
					"'" + iconURL + "', "
					"'" + name + "', "
					"'" + status + "');");

			showToast(packageid + " Added To Downloads");
		}
	}
}

void ApplicationUI::clearDownloads()
{
	QFile file(dbPath());

	if (file.open(QIODevice::ReadWrite))
	{
		SqlDataAccess sda(dbPath());
		sda.execute("DELETE FROM Downloads");

		showToast("Cleared Downloads");
	}
}

void ApplicationUI::removeFromDownloads(QString packageid)
{
	if(existsInDownloads(packageid))
	{
		QFile file(dbPath());

		if (file.open(QIODevice::ReadWrite))
		{
			SqlDataAccess sda(dbPath());
			sda.execute("DELETE FROM Downloads WHERE packageid = '" + packageid + "'");

			showToast(packageid + " Removed From Downloads");
		}
	}
}

int ApplicationUI::downloadsCount()
{
	int result = 0;

	QFile file(dbPath());

	if (file.open(QIODevice::ReadWrite))
	{
		SqlDataAccess sda(dbPath());
		QVariant list = sda.execute("SELECT * FROM Downloads");
		QVariantList vlist = list.value<QVariantList>();

		result = vlist.size();
	}

	return result;
}

bool ApplicationUI::existsInDownloads(QString packageid)
{
	bool result = false;

	QFile file(dbPath());

	if (file.open(QIODevice::ReadWrite))
	{
		SqlDataAccess sda(dbPath());
		QVariant list = sda.execute("SELECT * FROM Downloads WHERE packageid = '" + packageid + "'");
		QVariantList vlist = list.value<QVariantList>();

		if(vlist.size() > 0)
		{
			result = true;
		}
	}

	return result;
}

void ApplicationUI::openSearch(QVariant parameters)
{
    emit openSearchSignal(parameters);
}

void ApplicationUI::openSettings()
{
    emit openSettingsSignal();
}

void ApplicationUI::openDownloads()
{
    emit openDownloadsSignal();
}

void ApplicationUI::switchToTab(QString tabname)
{
	emit switchToTabSignal(tabname);
}

void ApplicationUI::loadAllPage(QString query)
{
	emit loadAllPageSignal(query);
}

void ApplicationUI::loadGamesPage(QString query)
{
	emit loadGamesPage(query);
}
void ApplicationUI::loadAppsPage(QString query)
{
	emit loadAppsPage(query);
}
void ApplicationUI::loadTopAppsPage(QString query)
{
	emit loadTopAppsPageSignal(query);
}

void ApplicationUI::loadCategorizedApps(QString categoryName)
{
	emit loadCategorizedAppsSignal(categoryName);
}

QString ApplicationUI::dbPath()
{
	return QDir::home().absoluteFilePath("droidstore.db");
}


void ApplicationUI::addToFavorites
	(
		QString packageid,
		QString url,
		QString name,
		QString description,
		QString price,
		QString rating,
		QString image,
		QString isfree,
		QString publishername,
		QString publisherurl
	)
{
	if(!existsInFavorites(packageid))
	{
		QFile file(dbPath());

		if (file.open(QIODevice::ReadWrite))
		{
			SqlDataAccess sda(dbPath());
			sda.execute("INSERT INTO Favorites (packageid, url, name, description, price, rating, image, isfree, publishername, publisherurl) VALUES ("
					"'" + packageid + "', "
					"'" + url + "', "
					"'" + name + "', "
					"'" + description + "', "
					"'" + price + "', "
					"'" + rating + "', "
					"'" + image + "', "
					"'" + isfree + "', "
					"'" + publishername + "', "
					"'" + publisherurl + "');");

			showToast(packageid + " Added To Favorites");
		}
	}
}

void ApplicationUI::clearFavorites()
{
	QFile file(dbPath());

	if (file.open(QIODevice::ReadWrite))
	{
		SqlDataAccess sda(dbPath());
		sda.execute("DELETE FROM Favorites");

		showToast("Cleared Favorites");
	}
}

void ApplicationUI::removeFromFavorites(QString packageid)
{
	if(existsInFavorites(packageid))
	{
		QFile file(dbPath());

		if (file.open(QIODevice::ReadWrite))
		{
			SqlDataAccess sda(dbPath());
			sda.execute("DELETE FROM Favorites WHERE packageid = '" + packageid + "'");

			showToast(packageid + " Removed From Favorites");
		}
	}
}

int ApplicationUI::favoritesCount()
{
	int result = 0;

	QFile file(dbPath());

	if (file.open(QIODevice::ReadWrite))
	{
		SqlDataAccess sda(dbPath());
		QVariant list = sda.execute("SELECT * FROM Favorites");
		QVariantList vlist = list.value<QVariantList>();

		result = vlist.size();
	}

	return result;
}

bool ApplicationUI::existsInFavorites(QString packageid)
{
	bool result = false;

	QFile file(dbPath());

	if (file.open(QIODevice::ReadWrite))
	{
		SqlDataAccess sda(dbPath());
		QVariant list = sda.execute("SELECT * FROM Favorites WHERE packageid = '" + packageid + "'");
		QVariantList vlist = list.value<QVariantList>();

		if(vlist.size() > 0)
		{
			result = true;
		}
	}

	return result;
}

void ApplicationUI::deleteFile(QString fileName)
{
	if(fileExists(fileName))
	{
		QFile::remove(fileName);

		showToast("File: " + fileName + " deleted.");
	}
	else
	{
		showToast("File: " + fileName + " does not exist.");
	}
}

void ApplicationUI::wipeContentsInFolder(const QString &folder)
{
	if(folder.length() > 0)
	{
		QDir dir(folder);

		if (dir.exists(folder))
		{
			Q_FOREACH(QFileInfo info, dir.entryInfoList(QDir::NoDotAndDotDot | QDir::System | QDir::Hidden  | QDir::AllDirs | QDir::Files | QDir::AllEntries | QDir::Writable, QDir::DirsFirst))
			{
				if(contains(info.absoluteFilePath(), "apk"))
				{
					QFile::remove(info.absoluteFilePath());
				}
			}
		}
	}
}

double ApplicationUI::fileSize(QString fileName)
{
	double size = 0.0;

	if(QFile::exists(fileName))
	{
		QFile file(fileName);

		if (file.open(QIODevice::ReadOnly))
		{
		    size = file.size();
		    file.close();
		}
	}

	return size;
}

bool ApplicationUI::fileExists(QString fileName)
{
	bool exists = false;

	if(QFile::exists(fileName))
	{
		exists = true;
	}

	return exists;
}

QString ApplicationUI::getSetting(const QString &objectName, const QString &defaultValue)
{
	QSettings settings(AUTHOR, APPNAME);

	if (settings.value(objectName).isNull()
			|| settings.value(objectName) == "")
	{
		return defaultValue;
	}

	return settings.value(objectName).toString();
}

void ApplicationUI::setSetting(const QString &objectName, const QString &inputValue)
{
	QSettings settings(AUTHOR, APPNAME);
	settings.setValue(objectName, QVariant(inputValue));
}

void ApplicationUI::invokeEmail(QString email, QString subject, QString body)
{
	InvokeRequest request;
	request.setTarget("sys.pim.uib.email.hybridcomposer");
	request.setAction("bb.action.SENDEMAIL");
	QString emailURL = "mailto:" + email + "?subject=" + subject.replace(" ", "%20") + "&body=" + body.replace(" ", "%20");
	request.setUri(emailURL);
	invokeManager->invoke(request);
}

void ApplicationUI::invokeBBWorld(QString appid)
{

	InvokeRequest request;
	request.setMimeType("application/x-bb-appworld");
	request.setAction("bb.action.OPEN");
	request.setUri("appworld://content/" + appid);
	invokeManager->invoke(request);
}

void ApplicationUI::invokeBrowser(QString url) {
	InvokeRequest request;
	request.setTarget("sys.browser");
	request.setAction("bb.action.OPEN");
	request.setUri(url);
	invokeManager->invoke(request);
}

void ApplicationUI::invokeInstaller(QString url)
{
	InvokeRequest request;
	request.setTarget("sys.installhandlerui");
	request.setAction("bb.action.VIEW");
	request.setUri(url);
	invokeManager->invoke(request);
}

void ApplicationUI::showToast(QString text)
{
	SystemToast *toast = new SystemToast(this);
	toast->setBody(text);
	toast->setPosition(SystemUiPosition::MiddleCenter);
	toast->show();
}

void ApplicationUI::showDialog(const QString &title, const QString &text)
{
	SystemDialog *dialog = new SystemDialog(this);
	dialog->setTitle(title);
	dialog->setBody(text);
	dialog->setEmoticonsEnabled(true);
	dialog->show();
}

bool ApplicationUI::contains(QString text, QString find)
{
	if(find == "" || find == " " || find == "  " || text == "" || text == " " || text == "  ")
	{
		return false;
	}

	bool result;

	if(getSetting("caseSensitive", "false") == "true")
	{
		result = text.contains(find, Qt::CaseSensitive);
	}
	else if(getSetting("caseSensitive", "false") == "false")
	{
		result = text.contains(find, Qt::CaseInsensitive);
	}

	return result;
}
