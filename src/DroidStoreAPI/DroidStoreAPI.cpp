#include "DroidStoreAPI.h"

#include <QDebug>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QSslConfiguration>
#include <QUrl>
#include <QtNetwork/QtNetwork>
#include <bb/data/JsonDataAccess>
#include <QtCore/QVariant>

using bb::data::JsonDataAccess;

// SERVER

//static QString hostname 		= "http://192.168.16.110/droidstore/";
static QString hostname 		= "http://kellyescape.com/droidstore/";

// EVOZI
//static QString downloadURL 		= hostname+ "downloadapk.php";
static QString downloadURL 		= "http://api.evozi.com/apk-downloader/download";

static QString searchURL 		= hostname + "searchapps.php";
static QString topAppsURL 		= hostname + "gettopapps.php";

// MINE
static QString featuredURL 		= hostname + "includes/webservices/getfeatureditems.php?version=";
static QString commentsURL 		= hostname + "includes/webservices/getreviews.php?itemtype=";
static QString addcommentURL 	= hostname + "includes/webservices/createreview.php";

DroidStoreAPI::DroidStoreAPI(QObject* parent)
    : QObject(parent)
{
	_resultsDataModel 		= new ArrayDataModel();
	_topAppsDataModel 		= new ArrayDataModel();
	_screenshotsDataModel 	= new ArrayDataModel();

	_popularAllDataModel 	= new ArrayDataModel();
	_popularAppsDataModel 	= new ArrayDataModel();
	_popularGamesDataModel 	= new ArrayDataModel();

	_trendingAllDataModel 	= new ArrayDataModel();
	_trendingAppsDataModel 	= new ArrayDataModel();
	_trendingGamesDataModel = new ArrayDataModel();

	_downloadsDataModel 	= new ArrayDataModel();

	_loading 			= false;

	resetAll();
}

void DroidStoreAPI::resetAll()
{
	_loading = false;

	_results.clear();
	_resultsDataModel->clear();

	_topApps.clear();
	_topAppsDataModel->clear();

	_screenshots.clear();
	_screenshotsDataModel->clear();

	_popularAll.clear();
	_popularAllDataModel->clear();

	_popularApps.clear();
	_popularAppsDataModel->clear();

	_popularGames.clear();
	_popularGamesDataModel->clear();

	_trendingAll.clear();
	_trendingAllDataModel->clear();

	_trendingApps.clear();
	_trendingAppsDataModel->clear();

	_trendingGames.clear();
	_trendingGamesDataModel->clear();

	_downloads.clear();
	_downloadsDataModel->clear();

	allChanged();
}

void DroidStoreAPI::allChanged()
{
	emit resultsChanged(_results);
	emit resultsDataModelChanged(_resultsDataModel);

	emit topAppsChanged(_topApps);
	emit topAppsDataModelChanged(_topAppsDataModel);

	emit screenshotsChanged(_screenshots);
	emit screenshotsDataModelChanged(_screenshotsDataModel);

	emit popularAllChanged(_popularAll);
	emit popularAllDataModelChanged(_popularAllDataModel);

	emit popularAppsChanged(_popularApps);
	emit popularAppsDataModelChanged(_popularAppsDataModel);

	emit popularGamesChanged(_popularGames);
	emit popularGamesDataModelChanged(_popularGamesDataModel);

	emit trendingAllChanged(_trendingAll);
	emit trendingAllDataModelChanged(_trendingAllDataModel);

	emit trendingAppsChanged(_trendingApps);
	emit trendingAppsDataModelChanged(_trendingAppsDataModel);

	emit trendingGamesChanged(_trendingGames);
	emit trendingGamesDataModelChanged(_trendingGamesDataModel);

	emit downloadsChanged(_downloads);
	emit downloadsDataModelChanged(_downloadsDataModel);

	emit loadingChanged(_loading);
}

void DroidStoreAPI::getDownloadURL(QByteArray packageid, QByteArray evozi_key)
{
	QHttpMultiPart *multiPart = new QHttpMultiPart(QHttpMultiPart::FormDataType);

	QHttpPart packageidPart;
	packageidPart.setHeader(QNetworkRequest::ContentDispositionHeader, QVariant("form-data; name=\"packagename\""));
	packageidPart.setBody(packageid);
	multiPart->append(packageidPart);

	QHttpPart apikeyPart;
	apikeyPart.setHeader(QNetworkRequest::ContentDispositionHeader, QVariant("form-data; name=\"api_key\""));
	apikeyPart.setBody(evozi_key);
	multiPart->append(apikeyPart);

	QUrl url(downloadURL);
	QNetworkRequest request(url);

	QNetworkAccessManager* manager = new QNetworkAccessManager();
	QNetworkReply *reply = manager->post(request, multiPart);
	multiPart->setParent(reply);

	connect(reply, SIGNAL(finished()), this, SLOT(onComplete()));
}

void DroidStoreAPI::addDownload(QVariant data)
{
	_downloadsDataModel->append(data);
	emit downloadsDataModelChanged(_downloadsDataModel);
}

void DroidStoreAPI::parseResultsJSON(QString jsonString, QString categoryOnly)
{
	JsonDataAccess jda;
	QVariant jsonDATA 	= jda.loadFromBuffer(jsonString);
	_results 			= jsonDATA.toMap().value("results").toList();

	QVariantList newResults = _results;

	if(categoryOnly != "all")
	{
		newResults.clear();

		foreach (QVariant app , _results)
		{
			if(categoryOnly == "game")
			{
				if(app.toMap().value("cat_int").toInt() >= 25) // if it's an game type
				{
					newResults.append(app);
				}
			}
			else if(categoryOnly == "app")
			{
				if(app.toMap().value("cat_int").toInt() <= 26) // if it's a app type
				{
					newResults.append(app);
				}
			}
			else
			{
				if(app.toMap().value("cat_int").toInt() == categoryOnly.toInt()) // if it's a specific type
				{
					newResults.append(app);
				}
			}
		}
	}

	_results.clear();
	_results = newResults;

	_resultsDataModel->clear();
	_resultsDataModel->insert(0, _results);

	emit resultsChanged(_results);
	emit resultsDataModelChanged(_resultsDataModel);
}

void DroidStoreAPI::parseTopAppsJSON(QString jsonString)
{
	JsonDataAccess jda;
	QVariant jsonDATA	= jda.loadFromBuffer(jsonString);

	_topApps 			= jsonDATA.toMap().value("appList").toList();
	_topAppsDataModel->clear();
	_topAppsDataModel->insert(0, _topApps);

	emit topAppsChanged(_topApps);
	emit topAppsDataModelChanged(_topAppsDataModel);
}

void DroidStoreAPI::parsePopularJSON(QString jsonString, QString categoryOnly)
{
	JsonDataAccess jda;
	QVariant jsonDATA	= jda.loadFromBuffer(jsonString);

	QVariantList popularList = jsonDATA.toMap().value("appList").toList();

	if(categoryOnly == "all")
	{
		QVariantList newList;

		for(int i = 0; i < 8; i++)
		{
			newList.append(popularList.at(i));
		}

		_popularAll = newList;
		_popularAllDataModel->clear();
		_popularAllDataModel->insert(0, _popularAll);

		emit popularAllChanged(_popularAll);
		emit popularAllDataModelChanged(_popularAllDataModel);
	}
	else if(categoryOnly == "game")
	{
		QVariantList newList;

		foreach(QVariant app, popularList)
		{
			if(app.toMap().value("cat_int").toInt() >= 25) // if it's an game type
			{
				newList.append(app);
			}

			if(newList.size() == 8)
			{
				break;
			}
		}

		_popularGames = newList;
		_popularGamesDataModel->clear();
		_popularGamesDataModel->insert(0, _popularGames);

		emit popularGamesChanged(_popularGames);
		emit popularGamesDataModelChanged(_popularGamesDataModel);
	}
	else if(categoryOnly == "app")
	{
		QVariantList newList;

		foreach(QVariant app, popularList)
		{
			if(app.toMap().value("cat_int").toInt() <= 26) // if it's an app type
			{
				newList.append(app);
			}

			if(newList.size() == 8)
			{
				break;
			}
		}

		_popularApps = newList;
		_popularAppsDataModel->clear();
		_popularAppsDataModel->insert(0, _popularApps);

		emit popularAppsChanged(_popularApps);
		emit popularAppsDataModelChanged(_popularAppsDataModel);
	}
}

void DroidStoreAPI::parseTrendingJSON(QString jsonString, QString categoryOnly)
{
	JsonDataAccess jda;
	QVariant jsonDATA	= jda.loadFromBuffer(jsonString);

	QVariantList trendingList = jsonDATA.toMap().value("appList").toList();

	QVariantList newList;

	for(int i = 0; i < 8; i++)
	{
		newList.append(trendingList.at(i));
	}

	if(categoryOnly == "all")
	{
		_trendingAll = newList;
		_trendingAllDataModel->clear();
		_trendingAllDataModel->insert(0, _trendingAll);

		emit trendingAllChanged(_trendingAll);
		emit trendingAllDataModelChanged(_trendingAllDataModel);
	}
	else if(categoryOnly == "game")
	{
		_trendingGames = newList;
		_trendingGamesDataModel->clear();
		_trendingGamesDataModel->insert(0, _trendingGames);

		emit trendingGamesChanged(_trendingGames);
		emit trendingGamesDataModelChanged(_trendingGamesDataModel);
	}
	else if(categoryOnly == "app")
	{
		_trendingApps = newList;
		_trendingAppsDataModel->clear();
		_trendingAppsDataModel->insert(0, _trendingApps);

		emit trendingAppsChanged(_trendingApps);
		emit trendingAppsDataModelChanged(_trendingAppsDataModel);
	}
}

void DroidStoreAPI::loadScreenshots(int index, QVariantList list)
{
	_screenshots = list.at(index).toMap().value("screenshots").toList();
	_screenshotsDataModel->clear();
	_screenshotsDataModel->insert(0, _screenshots);

	emit screenshotsChanged(_screenshots);
	emit screenshotsDataModelChanged(_screenshotsDataModel);
}

void DroidStoreAPI::search(QString query, QString limit)
{
	QString theURL = searchURL + "?limit="+ limit +"&q=" + query;
	QUrl url(theURL);

	QHttpMultiPart *multiPart = new QHttpMultiPart(QHttpMultiPart::FormDataType);
	QNetworkRequest request(url);
	QNetworkAccessManager* manager = new QNetworkAccessManager();
	QNetworkReply *reply = manager->post(request, multiPart);
	multiPart->setParent(reply);

	connect(reply, SIGNAL(finished()), this, SLOT(onComplete()));

	setLoading(true);
}

void DroidStoreAPI::loadTopApps(QString listname, QString country, QString language, QString category)
{
	QString theURL = topAppsURL + "?listName=" + listname + "&country=" + country + "&lang=" + language + "&category=" + category;
	qDebug() << "TOP APPS URL: " + theURL;
	QUrl url(theURL);

	QHttpMultiPart *multiPart = new QHttpMultiPart(QHttpMultiPart::FormDataType);
	QNetworkRequest request(url);
	QNetworkAccessManager* manager = new QNetworkAccessManager();
	QNetworkReply *reply = manager->post(request, multiPart);
	multiPart->setParent(reply);

	connect(reply, SIGNAL(finished()), this, SLOT(onComplete()));

	setLoading(true);
}

void DroidStoreAPI::onComplete()
{
	setLoading(false);

	QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
	QString response;

	if (reply)
	{
		if (reply->error() == QNetworkReply::NoError)
		{
			const int available = reply->bytesAvailable();

			if (available > 0)
			{
				const QByteArray buffer(reply->readAll());
				response = QString::fromUtf8(buffer);
			}
		}
		else
		{
			response = "error";
		}

		reply->deleteLater();
	}

	if (response.trimmed().isEmpty())
	{
		response = "error";
	}

	emit complete(response);
}

QVariantList DroidStoreAPI::getResults()
{
	return _results;
}

bb::cascades::ArrayDataModel* DroidStoreAPI::getResultsDataModel()
{
	return _resultsDataModel;
}

// TOP

QVariantList DroidStoreAPI::getTopApps()
{
	return _topApps;
}

bb::cascades::ArrayDataModel* DroidStoreAPI::getTopAppsDataModel()
{
	return _topAppsDataModel;
}

//

QVariantList DroidStoreAPI::getPopularAll()
{
	return _popularAll;
}

bb::cascades::ArrayDataModel* DroidStoreAPI::getPopularAllDataModel()
{
	return _popularAllDataModel;
}

//

QVariantList DroidStoreAPI::getPopularApps()
{
	return _popularApps;
}

bb::cascades::ArrayDataModel* DroidStoreAPI::getPopularAppsDataModel()
{
	return _popularAppsDataModel;
}

//

QVariantList DroidStoreAPI::getPopularGames()
{
	return _popularGames;
}

bb::cascades::ArrayDataModel* DroidStoreAPI::getPopularGamesDataModel()
{
	return _popularGamesDataModel;
}

//

QVariantList DroidStoreAPI::getTrendingAll()
{
	return _trendingAll;
}

bb::cascades::ArrayDataModel* DroidStoreAPI::getTrendingAllDataModel()
{
	return _trendingAllDataModel;
}

//

QVariantList DroidStoreAPI::getTrendingApps()
{
	return _trendingApps;
}

bb::cascades::ArrayDataModel* DroidStoreAPI::getTrendingAppsDataModel()
{
	return _trendingAppsDataModel;
}

//

QVariantList DroidStoreAPI::getTrendingGames()
{
	return _trendingGames;
}

bb::cascades::ArrayDataModel* DroidStoreAPI::getTrendingGamesDataModel()
{
	return _trendingGamesDataModel;
}

//

QVariantList DroidStoreAPI::getScreenshots()
{
	return _screenshots;
}

bb::cascades::ArrayDataModel* DroidStoreAPI::getScreenshotsDataModel()
{
	return _screenshotsDataModel;
}

//

QVariantList DroidStoreAPI::getDownloads()
{
	return _downloads;
}

bb::cascades::ArrayDataModel* DroidStoreAPI::getDownloadsDataModel()
{
	return _downloadsDataModel;
}

void DroidStoreAPI::setLoading(bool value)
{
	_loading = value;
	emit loadingChanged(_loading);
}

bool DroidStoreAPI::getLoading()
{
	return _loading;
}
