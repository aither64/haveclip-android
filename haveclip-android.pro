TEMPLATE = app
TARGET = HaveClip

QT += qml quick gui androidextras

INCLUDEPATH += $$PWD/../openssl-1.0.2a/include
LIBS += -L$$PWD/../openssl-1.0.2a -lcrypto -lssl
PRE_TARGETDEPS += $$PWD/../openssl-1.0.2a/libcrypto.a $$PWD/../openssl-1.0.2a/libssl.a

SOURCES += src/main.cpp \
    haveclip-core/src/CertificateInfo.cpp \
    haveclip-core/src/Cli.cpp \
    haveclip-core/src/ClipboardContainer.cpp \
    haveclip-core/src/ClipboardItem.cpp \
    haveclip-core/src/ClipboardManager.cpp \
    haveclip-core/src/ConfigMigration.cpp \
    haveclip-core/src/History.cpp \
    haveclip-core/src/Node.cpp \
    haveclip-core/src/RemoteClient.cpp \
    haveclip-core/src/RemoteControl.cpp \
    haveclip-core/src/Settings.cpp \
    haveclip-core/src/ConfigMigrations/V2Migration.cpp \
    haveclip-core/src/Network/AutoDiscovery.cpp \
    haveclip-core/src/Network/Command.cpp \
    haveclip-core/src/Network/Communicator.cpp \
    haveclip-core/src/Network/ConnectionManager.cpp \
    haveclip-core/src/Network/Conversation.cpp \
    haveclip-core/src/Network/Receiver.cpp \
    haveclip-core/src/Network/Sender.cpp \
    haveclip-core/src/Network/Commands/ClipboardUpdateConfirm.cpp \
    haveclip-core/src/Network/Commands/ClipboardUpdateReady.cpp \
    haveclip-core/src/Network/Commands/ClipboardUpdateSend.cpp \
    haveclip-core/src/Network/Commands/Confirm.cpp \
    haveclip-core/src/Network/Commands/Introduce.cpp \
    haveclip-core/src/Network/Commands/Ping.cpp \
    haveclip-core/src/Network/Commands/SecurityCode.cpp \
    haveclip-core/src/Network/Conversations/ClipboardUpdate.cpp \
    haveclip-core/src/Network/Conversations/Introduction.cpp \
    haveclip-core/src/Network/Conversations/Verification.cpp \
    haveclip-core/src/RemoteControls/RemoteBase.cpp \
    haveclip-core/src/RemoteControls/Sync.cpp \
    haveclip-core/src/Helpers/qmlclipboardmanager.cpp \
    haveclip-core/src/Helpers/qmlhelpers.cpp \
    haveclip-core/src/Helpers/qmlnode.cpp \
    haveclip-core/src/Models/nodediscoverymodel.cpp \
    haveclip-core/src/Models/nodemodel.cpp \
    haveclip-core/src/CertificateGenerator.cpp \
    haveclip-core/src/CertificateGeneratorThread.cpp \
    src/android.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

contains(ANDROID_TARGET_ARCH,x86) {
    ANDROID_EXTRA_LIBS =
}

INCLUDEPATH += /home/android/workspace/qca/include

HEADERS += \
    haveclip-core/src/CertificateInfo.h \
    haveclip-core/src/Cli.h \
    haveclip-core/src/ClipboardContainer.h \
    haveclip-core/src/ClipboardItem.h \
    haveclip-core/src/ClipboardManager.h \
    haveclip-core/src/ConfigMigration.h \
    haveclip-core/src/History.h \
    haveclip-core/src/Node.h \
    haveclip-core/src/RemoteClient.h \
    haveclip-core/src/RemoteControl.h \
    haveclip-core/src/Settings.h \
    haveclip-core/src/Version.h \
    haveclip-core/src/ConfigMigrations/V2Migration.h \
    haveclip-core/src/Network/AutoDiscovery.h \
    haveclip-core/src/Network/Command.h \
    haveclip-core/src/Network/Communicator.h \
    haveclip-core/src/Network/ConnectionManager.h \
    haveclip-core/src/Network/Conversation.h \
    haveclip-core/src/Network/Receiver.h \
    haveclip-core/src/Network/Sender.h \
    haveclip-core/src/Network/Commands/ClipboardUpdateConfirm.h \
    haveclip-core/src/Network/Commands/ClipboardUpdateReady.h \
    haveclip-core/src/Network/Commands/ClipboardUpdateSend.h \
    haveclip-core/src/Network/Commands/Confirm.h \
    haveclip-core/src/Network/Commands/Introduce.h \
    haveclip-core/src/Network/Commands/Ping.h \
    haveclip-core/src/Network/Commands/SecurityCode.h \
    haveclip-core/src/Network/Conversations/ClipboardUpdate.h \
    haveclip-core/src/Network/Conversations/Introduction.h \
    haveclip-core/src/Network/Conversations/Verification.h \
    haveclip-core/src/RemoteControls/RemoteBase.h \
    haveclip-core/src/RemoteControls/Sync.h \
    haveclip-core/src/Helpers/qmlclipboardmanager.h \
    haveclip-core/src/Helpers/qmlhelpers.h \
    haveclip-core/src/Helpers/qmlnode.h \
    haveclip-core/src/Models/nodediscoverymodel.h \
    haveclip-core/src/Models/nodemodel.h \
    haveclip-core/src/CertificateGenerator.h \
    haveclip-core/src/CertificateGeneratorThread.h

DISTFILES += \
    android/AndroidManifest.xml \
    README.md \
    android/src/cz/havefun/haveclip/ClipboardService.java \
    android/src/cz/havefun/haveclip/HaveClipActivity.java

android: ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

include(quickandroid/quickandroid.pri)
