#include <bb/cascades/Application>
#include <QLocale>
#include <QTranslator>
#include "applicationui.hpp"
#include <Qt/qdeclarativedebug.h>
#include "DroidStoreAPI.h"
#include "WebImageView.h"
#include "Downloader.hpp"

#include <Flurry.h>
#include <bb/ApplicationInfo>

using namespace bb::cascades;

const QString AUTHOR = "Nemory Development Studios";
const QString APPNAME = "Droid Store";

Q_DECL_EXPORT int main(int argc, char **argv)
{
	#if !defined(QT_NO_DEBUG)
		Flurry::Analytics::SetDebugLogEnabled(true);
	#endif

	Flurry::Analytics::SetAppVersion(bb::ApplicationInfo().version());
	Flurry::Analytics::StartSession("QV45PTN3HZTZSK5P3HXQ");

	QSettings settings(AUTHOR, APPNAME);
	QString colortheme = "bright";

	if (!settings.value("colortheme").isNull())
	{
		colortheme = settings.value("colortheme").toString();
	}

	qputenv("CASCADES_THEME", colortheme.toUtf8());

	qmlRegisterType<DroidStoreAPI>("nemory.DroidStoreAPI", 1, 0, "DroidStoreAPI");
	qmlRegisterType<Downloader>("nemory.Downloader", 1, 0, "Downloader");
	qmlRegisterType<WebImageView>("org.labsquare", 1, 0, "WebImageView");

    Application app(argc, argv);
    new ApplicationUI(&app);
    return Application::exec();
}
