#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQuick>

#include <QSslSocket>
#include <QDebug>

#include "haveclip-core/src/Settings.h"
#include "haveclip-core/src/ClipboardManager.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setOrganizationName("HaveFun.cz");
    QCoreApplication::setOrganizationDomain("havefun.cz");
    QCoreApplication::setApplicationName("HaveClip");

    QApplication app(argc, argv);

    qmlRegisterType(QUrl("qrc:/qml/pages/BasePage.qml"), "cz.haveclip", 1, 0, "BasePage");
    qmlRegisterType(QUrl("qrc:/qml/pages/HistoryPage.qml"), "cz.haveclip", 1, 0, "HistoryPage");
    qmlRegisterType(QUrl("qrc:/qml/pages/Settings.qml"), "cz.haveclip", 1, 0, "SettingsPage");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));

    qDebug() << "OpenSSL" << QSslSocket::supportsSsl() << QSslSocket::sslLibraryVersionString() << QSslSocket::sslLibraryBuildVersionString();

    QScopedPointer<Settings> settings(Settings::create());
    settings->init();

    ClipboardManager manager;
    manager.delayedStart(500);

    qDebug() << "HaveClip version" << VERSION;

    return app.exec();
}
