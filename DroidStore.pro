APP_NAME = DroidStore

QT += network
CONFIG += qt warn_on cascades10

LIBS += -lbb
LIBS += -lbbdata
LIBS += -lbbsystem
LIBS += -lbbdevice
LIBS += -lcamapi
LIBS += -lbbpim
LIBS += -lGLESv1_CM
LIBS += -lscreen
LIBS += -lbbcascadespickers

LIBS += -lcrypto -lcurl -lpackageinfo -lbbdevice -lQtLocationSubset

include(config.pri)
