/*
 * DroidStoreAPI.h
 *
 *  Created on: Dec 13, 2013
 *      Author: Oliver
 */

#ifndef DROIDSTOREAPI_H_
#define DROIDSTOREAPI_H_

#include <QtCore/QObject>
#include <bb/cascades/ArrayDataModel>

using bb::cascades::ArrayDataModel;

class DroidStoreAPI : public QObject
{
    Q_OBJECT

    // LIST
    Q_PROPERTY (QVariantList results READ getResults NOTIFY resultsChanged)
    Q_PROPERTY (QVariantList topApps READ getTopApps NOTIFY topAppsChanged)
	Q_PROPERTY (QVariantList screenshots READ getScreenshots NOTIFY screenshotsChanged)

	Q_PROPERTY (QVariantList popularAll READ getPopularAll NOTIFY popularAllChanged)
	Q_PROPERTY (QVariantList trendingAll READ getTrendingAll NOTIFY trendingAllChanged)

	Q_PROPERTY (QVariantList popularApps READ getPopularApps NOTIFY popularAppsChanged)
	Q_PROPERTY (QVariantList trendingApps READ getTrendingApps NOTIFY trendingAppsChanged)

	Q_PROPERTY (QVariantList popularGames READ getPopularGames NOTIFY popularGamesChanged)
	Q_PROPERTY (QVariantList trendingGames READ getTrendingGames NOTIFY trendingGamesChanged)

	Q_PROPERTY (QVariantList downloads READ getDownloads NOTIFY downloadsChanged)

    // BOOL
    Q_PROPERTY (bool loading READ getLoading WRITE setLoading NOTIFY loadingChanged)

    // ARRAY DATA MODEL
	Q_PROPERTY (bb::cascades::ArrayDataModel* resultsDataModel READ getResultsDataModel NOTIFY resultsDataModelChanged)
	Q_PROPERTY (bb::cascades::ArrayDataModel* topAppsDataModel READ getTopAppsDataModel NOTIFY topAppsDataModelChanged)
	Q_PROPERTY (bb::cascades::ArrayDataModel* screenshotsDataModel READ getScreenshotsDataModel NOTIFY screenshotsDataModelChanged)

	Q_PROPERTY (bb::cascades::ArrayDataModel* popularAllDataModel READ getPopularAllDataModel NOTIFY popularAllDataModelChanged)
	Q_PROPERTY (bb::cascades::ArrayDataModel* trendingAllDataModel READ getTrendingAllDataModel NOTIFY trendingAllDataModelChanged)

	Q_PROPERTY (bb::cascades::ArrayDataModel* popularAppsDataModel READ getPopularAppsDataModel NOTIFY popularAppsDataModelChanged)
	Q_PROPERTY (bb::cascades::ArrayDataModel* trendingAppsDataModel READ getTrendingAppsDataModel NOTIFY trendingAppsDataModelChanged)

	Q_PROPERTY (bb::cascades::ArrayDataModel* popularGamesDataModel READ getPopularGamesDataModel NOTIFY popularGamesDataModelChanged)
	Q_PROPERTY (bb::cascades::ArrayDataModel* trendingGamesDataModel READ getTrendingGamesDataModel NOTIFY trendingGamesDataModelChanged)

	Q_PROPERTY (bb::cascades::ArrayDataModel* downloadsDataModel READ getDownloadsDataModel NOTIFY downloadsDataModelChanged)

public:
    DroidStoreAPI(QObject* parent = 0);

    Q_INVOKABLE void parseResultsJSON(QString jsonString, QString categoryOnly);
    Q_INVOKABLE void parseTopAppsJSON(QString jsonString);
    Q_INVOKABLE void parsePopularJSON(QString jsonString, QString categoryOnly);
	Q_INVOKABLE void parseTrendingJSON(QString jsonString, QString categoryOnly);

    Q_INVOKABLE void search(QString query, QString limit);
    Q_INVOKABLE void loadTopApps(QString listname, QString country, QString language, QString category);

    Q_INVOKABLE void getDownloadURL(QByteArray packageid, QByteArray evozi_key);
    Q_INVOKABLE void addDownload(QVariant data);

    Q_INVOKABLE void loadScreenshots(int index, QVariantList list);
    Q_INVOKABLE void resetAll();
    Q_INVOKABLE void allChanged();

Q_SIGNALS:

    void complete(QString response);

	// QVARIANT LIST
	void resultsChanged(QVariantList);
	void topAppsChanged(QVariantList);
	void screenshotsChanged(QVariantList);

	void popularAllChanged(QVariantList);
	void trendingAllChanged(QVariantList);

	void popularAppsChanged(QVariantList);
	void trendingAppsChanged(QVariantList);

	void popularGamesChanged(QVariantList);
	void trendingGamesChanged(QVariantList);

	void downloadsChanged(QVariantList);

	// BOOL
	void loadingChanged(bool);

	// ARRAY DATA MODEL
	void resultsDataModelChanged(bb::cascades::ArrayDataModel*);
	void topAppsDataModelChanged(bb::cascades::ArrayDataModel*);
	void screenshotsDataModelChanged(bb::cascades::ArrayDataModel*);

	void popularAllDataModelChanged(bb::cascades::ArrayDataModel*);
	void trendingAllDataModelChanged(bb::cascades::ArrayDataModel*);

	void popularAppsDataModelChanged(bb::cascades::ArrayDataModel*);
	void trendingAppsDataModelChanged(bb::cascades::ArrayDataModel*);

	void popularGamesDataModelChanged(bb::cascades::ArrayDataModel*);
	void trendingGamesDataModelChanged(bb::cascades::ArrayDataModel*);

	void downloadsDataModelChanged(bb::cascades::ArrayDataModel*);

private Q_SLOTS:

    void onComplete();

private :

    // BOOL
    bool _loading;
    void setLoading(bool value);
    bool getLoading();

	// VARIANT LIST
    QVariantList _results;
	QVariantList getResults();

	QVariantList _topApps;
	QVariantList getTopApps();

	QVariantList _screenshots;
	QVariantList getScreenshots();

	QVariantList _popularAll;
	QVariantList getPopularAll();

	QVariantList _popularApps;
	QVariantList getPopularApps();

	QVariantList _popularGames;
	QVariantList getPopularGames();

	QVariantList _trendingAll;
	QVariantList getTrendingAll();

	QVariantList _trendingApps;
	QVariantList getTrendingApps();

	QVariantList _trendingGames;
	QVariantList getTrendingGames();

	QVariantList _downloads;
	QVariantList getDownloads();

	// ARRAY DATA MODEL
	bb::cascades::ArrayDataModel* _resultsDataModel;
	bb::cascades::ArrayDataModel* getResultsDataModel();

	bb::cascades::ArrayDataModel* _topAppsDataModel;
	bb::cascades::ArrayDataModel* getTopAppsDataModel();

	bb::cascades::ArrayDataModel* _screenshotsDataModel;
	bb::cascades::ArrayDataModel* getScreenshotsDataModel();

	bb::cascades::ArrayDataModel* _popularAllDataModel;
	bb::cascades::ArrayDataModel* getPopularAllDataModel();

	bb::cascades::ArrayDataModel* _popularAppsDataModel;
	bb::cascades::ArrayDataModel* getPopularAppsDataModel();

	bb::cascades::ArrayDataModel* _popularGamesDataModel;
	bb::cascades::ArrayDataModel* getPopularGamesDataModel();

	bb::cascades::ArrayDataModel* _trendingAllDataModel;
	bb::cascades::ArrayDataModel* getTrendingAllDataModel();

	bb::cascades::ArrayDataModel* _trendingAppsDataModel;
	bb::cascades::ArrayDataModel* getTrendingAppsDataModel();

	bb::cascades::ArrayDataModel* _trendingGamesDataModel;
	bb::cascades::ArrayDataModel* getTrendingGamesDataModel();

	bb::cascades::ArrayDataModel* _downloadsDataModel;
	bb::cascades::ArrayDataModel* getDownloadsDataModel();

};

#endif /* DROIDSTOREAPI_H_ */
