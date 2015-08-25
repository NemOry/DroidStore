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

#ifndef ApplicationUI_HPP_
#define ApplicationUI_HPP_

#include <QObject>
#include <bb/system/InvokeManager>
#include <bb/system/SystemProgressToast>
#include <bb/system/SystemProgressDialog>

#include <QtLocationSubset/QGeoPositionInfo>

using bb::system::InvokeManager;
using bb::system::SystemProgressToast;
using namespace QtMobilitySubset;

namespace bb
{
    namespace cascades
    {
        class Application;
    }
}

class ApplicationUI : public QObject
{
    Q_OBJECT

public:

    ApplicationUI(bb::cascades::Application *app);
    virtual ~ApplicationUI() { }

    static const QString AUTHOR;
	static const QString APPNAME;

	Q_INVOKABLE void flurrySetUserID(QString value);
	Q_INVOKABLE void flurryLogError(QString value);
	Q_INVOKABLE void flurryLogEvent(QString value);

	// DOWNLOADS

	Q_INVOKABLE void addToDownloads
	(
		QString packageid,
		QString iconURL,
		QString name,
		QString status
	);

	Q_INVOKABLE int downloadsCount();
	Q_INVOKABLE void clearDownloads();
	Q_INVOKABLE void removeFromDownloads(QString packageid);
	Q_INVOKABLE bool existsInDownloads(QString packageid);

	// RECENT SEARCHES

	Q_INVOKABLE void addToRecentSearches
	(
		QString searchText
	);

	Q_INVOKABLE int recentSearchesCount();
	Q_INVOKABLE void clearRecentSearches();
	Q_INVOKABLE void removeFromRecentSearches(QString searchText);
	Q_INVOKABLE bool existsInRecentSearches(QString searchText);

	// DOWNLOADS

	Q_INVOKABLE void openSearch(QVariant parameters);
	Q_INVOKABLE void openSettings();
	Q_INVOKABLE void openDownloads();

	Q_INVOKABLE bool contains(QString text, QString find);
	Q_INVOKABLE void invokeEmail(QString email, QString subject, QString body);
	Q_INVOKABLE void invokeBBWorld(QString appid);
	Q_INVOKABLE void invokeBrowser(QString url);
	Q_INVOKABLE void invokeInstaller(QString url);
	Q_INVOKABLE void showToast(QString text);
	Q_INVOKABLE void showDialog(const QString &title, const QString &text);
	Q_INVOKABLE QString getSetting(const QString &objectName, const QString &defaultValue);
	Q_INVOKABLE void setSetting(const QString &objectName, const QString &inputValue);
	Q_INVOKABLE bool fileExists(QString fileName);
	Q_INVOKABLE double fileSize(QString fileName);

	Q_INVOKABLE void deleteFile(QString fileName);
	Q_INVOKABLE void wipeContentsInFolder(const QString &folder);

	Q_INVOKABLE QString dbPath();

	Q_INVOKABLE int favoritesCount();
	Q_INVOKABLE void clearFavorites();

	Q_INVOKABLE void addToFavorites
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
	);

	Q_INVOKABLE void removeFromFavorites(QString packageid);
	Q_INVOKABLE bool existsInFavorites(QString packageid);

	Q_INVOKABLE void loadAllPage(QString query);
	Q_INVOKABLE void loadAppsPage(QString query);
	Q_INVOKABLE void loadGamesPage(QString query);
	Q_INVOKABLE void loadTopAppsPage(QString query);
	Q_INVOKABLE void loadCategorizedApps(QString categoryName);

	Q_INVOKABLE void switchToTab(QString tabname);

signals:
	void loadAllPageSignal(QString query);
	void loadAppsPageSignal(QString query);
	void loadGamesPageSignal(QString query);
	void loadTopAppsPageSignal(QString query);
	void loadCategorizedAppsSignal(QString categoryName);

	void openSearchSignal(QVariant parameters);
	void openSettingsSignal();
	void openDownloadsSignal();

	void switchToTabSignal(QString query);

private slots:



private:
	Q_SLOT void positionUpdated (const QGeoPositionInfo &update);

	InvokeManager* invokeManager;
};

#endif /* ApplicationUI_HPP_ */
