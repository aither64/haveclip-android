/*
  HaveClip

  Copyright (C) 2013-2015 Jakub Skokan <aither@havefun.cz>

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQuick>

#include <QSslSocket>
#include <QDebug>

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
#include "settingwatcher.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setOrganizationName("HaveFun.cz");
    QCoreApplication::setOrganizationDomain("havefun.cz");
    QCoreApplication::setApplicationName("HaveClip");

	QGuiApplication app(argc, argv);

	const char* url = "cz.havefun.haveclip";

	qmlRegisterType(QUrl("qrc:/qml/components/GroupBox.qml"), url, 1, 0, "GroupBox");
	qmlRegisterType(QUrl("qrc:/qml/components/LabelTextField.qml"), url, 1, 0, "LabelTextField");
	qmlRegisterType(QUrl("qrc:/qml/components/TextSlider.qml"), url, 1, 0, "TextSlider");
	qmlRegisterType(QUrl("qrc:/qml/components/TextSwitch.qml"), url, 1, 0, "TextSwitch");

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

	QScopedPointer<Settings> settings(Settings::create());
	settings->init();

	ClipboardManager manager;
	manager.delayedStart(500);

	QmlClipboardManager qmlManager;
	QmlHelpers helpers;

	SettingWatcher watcher;

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
