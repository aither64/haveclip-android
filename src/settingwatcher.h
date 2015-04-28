#ifndef SETTINGWATCHER_H
#define SETTINGWATCHER_H

#include <QObject>

class SettingWatcher : public QObject
{
	Q_OBJECT
public:
	explicit SettingWatcher(QObject *parent = 0);

public slots:
	void toggleTracking(bool enabled);
};

#endif // SETTINGWATCHER_H
