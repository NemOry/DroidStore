/****************************************************************************
** Meta object code from reading C++ file 'DroidStoreAPI.h'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.5)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../src/DroidStoreAPI/DroidStoreAPI.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'DroidStoreAPI.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.5. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_DroidStoreAPI[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
      34,   14, // methods
      21,  184, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
      22,       // signalCount

 // signals: signature, parameters, type, tag, flags
      24,   15,   14,   14, 0x05,
      42,   14,   14,   14, 0x05,
      71,   14,   14,   14, 0x05,
     100,   14,   14,   14, 0x05,
     133,   14,   14,   14, 0x05,
     165,   14,   14,   14, 0x05,
     198,   14,   14,   14, 0x05,
     231,   14,   14,   14, 0x05,
     265,   14,   14,   14, 0x05,
     299,   14,   14,   14, 0x05,
     334,   14,   14,   14, 0x05,
     365,   14,   14,   14, 0x05,
     386,   14,   14,   14, 0x05,
     441,   14,   14,   14, 0x05,
     496,   14,   14,   14, 0x05,
     555,   14,   14,   14, 0x05,
     613,   14,   14,   14, 0x05,
     672,   14,   14,   14, 0x05,
     731,   14,   14,   14, 0x05,
     791,   14,   14,   14, 0x05,
     851,   14,   14,   14, 0x05,
     912,   14,   14,   14, 0x05,

 // slots: signature, parameters, type, tag, flags
     969,   14,   14,   14, 0x08,

 // methods: signature, parameters, type, tag, flags
    1006,  982,   14,   14, 0x02,
    1051, 1040,   14,   14, 0x02,
    1077,  982,   14,   14, 0x02,
    1111,  982,   14,   14, 0x02,
    1158, 1146,   14,   14, 0x02,
    1217, 1182,   14,   14, 0x02,
    1282, 1262,   14,   14, 0x02,
    1325, 1320,   14,   14, 0x02,
    1358, 1347,   14,   14, 0x02,
    1392,   14,   14,   14, 0x02,
    1403,   14,   14,   14, 0x02,

 // properties: name, type, flags
    1429, 1416, 0x09495001,
    1437, 1416, 0x09495001,
    1445, 1416, 0x09495001,
    1457, 1416, 0x09495001,
    1468, 1416, 0x09495001,
    1480, 1416, 0x09495001,
    1492, 1416, 0x09495001,
    1505, 1416, 0x09495001,
    1518, 1416, 0x09495001,
    1532, 1416, 0x09495001,
    1547, 1542, 0x01495103,
    1585, 1555, 0x00495009,
    1602, 1555, 0x00495009,
    1619, 1555, 0x00495009,
    1640, 1555, 0x00495009,
    1660, 1555, 0x00495009,
    1681, 1555, 0x00495009,
    1702, 1555, 0x00495009,
    1724, 1555, 0x00495009,
    1746, 1555, 0x00495009,
    1769, 1555, 0x00495009,

 // properties: notify_signal_id
       1,
       2,
       3,
       4,
       5,
       6,
       7,
       8,
       9,
      10,
      11,
      12,
      13,
      14,
      15,
      16,
      17,
      18,
      19,
      20,
      21,

       0        // eod
};

static const char qt_meta_stringdata_DroidStoreAPI[] = {
    "DroidStoreAPI\0\0response\0complete(QString)\0"
    "resultsChanged(QVariantList)\0"
    "topAppsChanged(QVariantList)\0"
    "screenshotsChanged(QVariantList)\0"
    "popularAllChanged(QVariantList)\0"
    "trendingAllChanged(QVariantList)\0"
    "popularAppsChanged(QVariantList)\0"
    "trendingAppsChanged(QVariantList)\0"
    "popularGamesChanged(QVariantList)\0"
    "trendingGamesChanged(QVariantList)\0"
    "downloadsChanged(QVariantList)\0"
    "loadingChanged(bool)\0"
    "resultsDataModelChanged(bb::cascades::ArrayDataModel*)\0"
    "topAppsDataModelChanged(bb::cascades::ArrayDataModel*)\0"
    "screenshotsDataModelChanged(bb::cascades::ArrayDataModel*)\0"
    "popularAllDataModelChanged(bb::cascades::ArrayDataModel*)\0"
    "trendingAllDataModelChanged(bb::cascades::ArrayDataModel*)\0"
    "popularAppsDataModelChanged(bb::cascades::ArrayDataModel*)\0"
    "trendingAppsDataModelChanged(bb::cascades::ArrayDataModel*)\0"
    "popularGamesDataModelChanged(bb::cascades::ArrayDataModel*)\0"
    "trendingGamesDataModelChanged(bb::cascades::ArrayDataModel*)\0"
    "downloadsDataModelChanged(bb::cascades::ArrayDataModel*)\0"
    "onComplete()\0jsonString,categoryOnly\0"
    "parseResultsJSON(QString,QString)\0"
    "jsonString\0parseTopAppsJSON(QString)\0"
    "parsePopularJSON(QString,QString)\0"
    "parseTrendingJSON(QString,QString)\0"
    "query,limit\0search(QString,QString)\0"
    "listname,country,language,category\0"
    "loadTopApps(QString,QString,QString,QString)\0"
    "packageid,evozi_key\0"
    "getDownloadURL(QByteArray,QByteArray)\0"
    "data\0addDownload(QVariant)\0index,list\0"
    "loadScreenshots(int,QVariantList)\0"
    "resetAll()\0allChanged()\0QVariantList\0"
    "results\0topApps\0screenshots\0popularAll\0"
    "trendingAll\0popularApps\0trendingApps\0"
    "popularGames\0trendingGames\0downloads\0"
    "bool\0loading\0bb::cascades::ArrayDataModel*\0"
    "resultsDataModel\0topAppsDataModel\0"
    "screenshotsDataModel\0popularAllDataModel\0"
    "trendingAllDataModel\0popularAppsDataModel\0"
    "trendingAppsDataModel\0popularGamesDataModel\0"
    "trendingGamesDataModel\0downloadsDataModel\0"
};

void DroidStoreAPI::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        DroidStoreAPI *_t = static_cast<DroidStoreAPI *>(_o);
        switch (_id) {
        case 0: _t->complete((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 1: _t->resultsChanged((*reinterpret_cast< QVariantList(*)>(_a[1]))); break;
        case 2: _t->topAppsChanged((*reinterpret_cast< QVariantList(*)>(_a[1]))); break;
        case 3: _t->screenshotsChanged((*reinterpret_cast< QVariantList(*)>(_a[1]))); break;
        case 4: _t->popularAllChanged((*reinterpret_cast< QVariantList(*)>(_a[1]))); break;
        case 5: _t->trendingAllChanged((*reinterpret_cast< QVariantList(*)>(_a[1]))); break;
        case 6: _t->popularAppsChanged((*reinterpret_cast< QVariantList(*)>(_a[1]))); break;
        case 7: _t->trendingAppsChanged((*reinterpret_cast< QVariantList(*)>(_a[1]))); break;
        case 8: _t->popularGamesChanged((*reinterpret_cast< QVariantList(*)>(_a[1]))); break;
        case 9: _t->trendingGamesChanged((*reinterpret_cast< QVariantList(*)>(_a[1]))); break;
        case 10: _t->downloadsChanged((*reinterpret_cast< QVariantList(*)>(_a[1]))); break;
        case 11: _t->loadingChanged((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 12: _t->resultsDataModelChanged((*reinterpret_cast< bb::cascades::ArrayDataModel*(*)>(_a[1]))); break;
        case 13: _t->topAppsDataModelChanged((*reinterpret_cast< bb::cascades::ArrayDataModel*(*)>(_a[1]))); break;
        case 14: _t->screenshotsDataModelChanged((*reinterpret_cast< bb::cascades::ArrayDataModel*(*)>(_a[1]))); break;
        case 15: _t->popularAllDataModelChanged((*reinterpret_cast< bb::cascades::ArrayDataModel*(*)>(_a[1]))); break;
        case 16: _t->trendingAllDataModelChanged((*reinterpret_cast< bb::cascades::ArrayDataModel*(*)>(_a[1]))); break;
        case 17: _t->popularAppsDataModelChanged((*reinterpret_cast< bb::cascades::ArrayDataModel*(*)>(_a[1]))); break;
        case 18: _t->trendingAppsDataModelChanged((*reinterpret_cast< bb::cascades::ArrayDataModel*(*)>(_a[1]))); break;
        case 19: _t->popularGamesDataModelChanged((*reinterpret_cast< bb::cascades::ArrayDataModel*(*)>(_a[1]))); break;
        case 20: _t->trendingGamesDataModelChanged((*reinterpret_cast< bb::cascades::ArrayDataModel*(*)>(_a[1]))); break;
        case 21: _t->downloadsDataModelChanged((*reinterpret_cast< bb::cascades::ArrayDataModel*(*)>(_a[1]))); break;
        case 22: _t->onComplete(); break;
        case 23: _t->parseResultsJSON((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 24: _t->parseTopAppsJSON((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 25: _t->parsePopularJSON((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 26: _t->parseTrendingJSON((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 27: _t->search((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 28: _t->loadTopApps((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3])),(*reinterpret_cast< QString(*)>(_a[4]))); break;
        case 29: _t->getDownloadURL((*reinterpret_cast< QByteArray(*)>(_a[1])),(*reinterpret_cast< QByteArray(*)>(_a[2]))); break;
        case 30: _t->addDownload((*reinterpret_cast< QVariant(*)>(_a[1]))); break;
        case 31: _t->loadScreenshots((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< QVariantList(*)>(_a[2]))); break;
        case 32: _t->resetAll(); break;
        case 33: _t->allChanged(); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData DroidStoreAPI::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject DroidStoreAPI::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_DroidStoreAPI,
      qt_meta_data_DroidStoreAPI, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &DroidStoreAPI::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *DroidStoreAPI::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *DroidStoreAPI::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_DroidStoreAPI))
        return static_cast<void*>(const_cast< DroidStoreAPI*>(this));
    return QObject::qt_metacast(_clname);
}

int DroidStoreAPI::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 34)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 34;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QVariantList*>(_v) = getResults(); break;
        case 1: *reinterpret_cast< QVariantList*>(_v) = getTopApps(); break;
        case 2: *reinterpret_cast< QVariantList*>(_v) = getScreenshots(); break;
        case 3: *reinterpret_cast< QVariantList*>(_v) = getPopularAll(); break;
        case 4: *reinterpret_cast< QVariantList*>(_v) = getTrendingAll(); break;
        case 5: *reinterpret_cast< QVariantList*>(_v) = getPopularApps(); break;
        case 6: *reinterpret_cast< QVariantList*>(_v) = getTrendingApps(); break;
        case 7: *reinterpret_cast< QVariantList*>(_v) = getPopularGames(); break;
        case 8: *reinterpret_cast< QVariantList*>(_v) = getTrendingGames(); break;
        case 9: *reinterpret_cast< QVariantList*>(_v) = getDownloads(); break;
        case 10: *reinterpret_cast< bool*>(_v) = getLoading(); break;
        case 11: *reinterpret_cast< bb::cascades::ArrayDataModel**>(_v) = getResultsDataModel(); break;
        case 12: *reinterpret_cast< bb::cascades::ArrayDataModel**>(_v) = getTopAppsDataModel(); break;
        case 13: *reinterpret_cast< bb::cascades::ArrayDataModel**>(_v) = getScreenshotsDataModel(); break;
        case 14: *reinterpret_cast< bb::cascades::ArrayDataModel**>(_v) = getPopularAllDataModel(); break;
        case 15: *reinterpret_cast< bb::cascades::ArrayDataModel**>(_v) = getTrendingAllDataModel(); break;
        case 16: *reinterpret_cast< bb::cascades::ArrayDataModel**>(_v) = getPopularAppsDataModel(); break;
        case 17: *reinterpret_cast< bb::cascades::ArrayDataModel**>(_v) = getTrendingAppsDataModel(); break;
        case 18: *reinterpret_cast< bb::cascades::ArrayDataModel**>(_v) = getPopularGamesDataModel(); break;
        case 19: *reinterpret_cast< bb::cascades::ArrayDataModel**>(_v) = getTrendingGamesDataModel(); break;
        case 20: *reinterpret_cast< bb::cascades::ArrayDataModel**>(_v) = getDownloadsDataModel(); break;
        }
        _id -= 21;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 10: setLoading(*reinterpret_cast< bool*>(_v)); break;
        }
        _id -= 21;
    } else if (_c == QMetaObject::ResetProperty) {
        _id -= 21;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 21;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 21;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 21;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 21;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 21;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void DroidStoreAPI::complete(QString _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void DroidStoreAPI::resultsChanged(QVariantList _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void DroidStoreAPI::topAppsChanged(QVariantList _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}

// SIGNAL 3
void DroidStoreAPI::screenshotsChanged(QVariantList _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 3, _a);
}

// SIGNAL 4
void DroidStoreAPI::popularAllChanged(QVariantList _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 4, _a);
}

// SIGNAL 5
void DroidStoreAPI::trendingAllChanged(QVariantList _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 5, _a);
}

// SIGNAL 6
void DroidStoreAPI::popularAppsChanged(QVariantList _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 6, _a);
}

// SIGNAL 7
void DroidStoreAPI::trendingAppsChanged(QVariantList _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 7, _a);
}

// SIGNAL 8
void DroidStoreAPI::popularGamesChanged(QVariantList _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 8, _a);
}

// SIGNAL 9
void DroidStoreAPI::trendingGamesChanged(QVariantList _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 9, _a);
}

// SIGNAL 10
void DroidStoreAPI::downloadsChanged(QVariantList _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 10, _a);
}

// SIGNAL 11
void DroidStoreAPI::loadingChanged(bool _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 11, _a);
}

// SIGNAL 12
void DroidStoreAPI::resultsDataModelChanged(bb::cascades::ArrayDataModel * _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 12, _a);
}

// SIGNAL 13
void DroidStoreAPI::topAppsDataModelChanged(bb::cascades::ArrayDataModel * _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 13, _a);
}

// SIGNAL 14
void DroidStoreAPI::screenshotsDataModelChanged(bb::cascades::ArrayDataModel * _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 14, _a);
}

// SIGNAL 15
void DroidStoreAPI::popularAllDataModelChanged(bb::cascades::ArrayDataModel * _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 15, _a);
}

// SIGNAL 16
void DroidStoreAPI::trendingAllDataModelChanged(bb::cascades::ArrayDataModel * _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 16, _a);
}

// SIGNAL 17
void DroidStoreAPI::popularAppsDataModelChanged(bb::cascades::ArrayDataModel * _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 17, _a);
}

// SIGNAL 18
void DroidStoreAPI::trendingAppsDataModelChanged(bb::cascades::ArrayDataModel * _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 18, _a);
}

// SIGNAL 19
void DroidStoreAPI::popularGamesDataModelChanged(bb::cascades::ArrayDataModel * _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 19, _a);
}

// SIGNAL 20
void DroidStoreAPI::trendingGamesDataModelChanged(bb::cascades::ArrayDataModel * _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 20, _a);
}

// SIGNAL 21
void DroidStoreAPI::downloadsDataModelChanged(bb::cascades::ArrayDataModel * _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 21, _a);
}
QT_END_MOC_NAMESPACE
