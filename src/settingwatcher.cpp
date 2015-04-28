#include "settingwatcher.h"
#include "haveclip-core/src/Settings.h"

#include <QAndroidJniObject>

SettingWatcher::SettingWatcher(QObject *parent) :
	QObject(parent)
{
	Settings *s = Settings::get();

	connect(s, SIGNAL(trackingEnabledChanged(bool)),
			this, SLOT(toggleTracking(bool)));

	if (s->isTrackingEnabled())
		toggleTracking(true);
}

void SettingWatcher::toggleTracking(bool enabled)
{
	QAndroidJniObject::callStaticMethod<void>(
		"cz/havefun/haveclip/ClipboardService",
		"toggleListener",
		"(Z)V",
		enabled
	);
}
