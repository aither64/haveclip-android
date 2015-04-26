#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQuick>

#include <QSslSocket>
#include <QDebug>

 #include <openssl/crypto.h>

#include "quickandroid.h"

#include "haveclip-core/src/Settings.h"
#include "haveclip-core/src/ClipboardManager.h"
#include "haveclip-core/src/CertificateInfo.h"
#include "haveclip-core/src/CertificateGenerator.h"
#include "haveclip-core/src/Models/nodediscoverymodel.h"
#include "haveclip-core/src/Models/nodemodel.h"
#include "haveclip-core/src/Helpers/qmlnode.h"
#include "haveclip-core/src/Helpers/qmlclipboardmanager.h"
#include "haveclip-core/src/Helpers/qmlhelpers.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setOrganizationName("HaveFun.cz");
    QCoreApplication::setOrganizationDomain("havefun.cz");
    QCoreApplication::setApplicationName("HaveClip");

    QApplication app(argc, argv);

	const char* url = "cz.havefun.haveclip";

	qmlRegisterType(QUrl("qrc:/qml/components/LabelTextField.qml"), url, 1, 0, "LabelTextField");
	qmlRegisterType(QUrl("qrc:/qml/components/TextSlider.qml"), url, 1, 0, "TextSlider");

	qRegisterMetaType<Communicator::CommunicationStatus>("Communicator::CommunicationStatus");
	qRegisterMetaType<ConnectionManager::CodeValidity>("ConnectionManager::CodeValidity");

	qmlRegisterType<QmlNode>(url, 1, 0, "Node");
	qmlRegisterType<CertificateInfo>(url, 1, 0, "SslCertificate");
	qmlRegisterType<CertificateGenerator>(url, 1, 0, "CertificateGenerator");
	qmlRegisterType<NodeModel>(url, 1, 0, "NodeModel");
	qmlRegisterType<NodeDiscoveryModel>(url, 1, 0, "NodeDiscoveryModel");
	qmlRegisterType<ConnectionManager>(url, 1, 0, "ConnectionManager");
	qmlRegisterType<Communicator>(url, 1, 0, "Communicator");

	QQuickView view;

	view.engine()->addImportPath("qrc:///");
	QuickAndroid::registerTypes();

	qDebug() << "OpenSSL" << QSslSocket::supportsSsl() << QSslSocket::sslLibraryVersionString() << QSslSocket::sslLibraryBuildVersionString();
	qDebug() << "Real version:" << SSLeay_version(SSLEAY_VERSION) << SSLeay_version(SSLEAY_BUILT_ON);

	QScopedPointer<Settings> settings(Settings::create());
	settings->init();

	ClipboardManager manager;
	manager.delayedStart(500);

	QmlClipboardManager qmlManager;
	QmlHelpers helpers;

	QQmlContext *context = view.engine()->rootContext();

	context->setContextProperty("settings", Settings::get());
	context->setContextProperty("manager", &qmlManager);
	context->setContextProperty("historyModel", manager.history());
	context->setContextProperty("conman", manager.connectionManager());
	context->setContextProperty("helpers", &helpers);

	view.setResizeMode(QQuickView::SizeRootObjectToView);
	view.setSource(QUrl(QStringLiteral("qrc:/qml/main.qml")));
	view.show();

    qDebug() << "HaveClip version" << VERSION;

    return app.exec();
}
