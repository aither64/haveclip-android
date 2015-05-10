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

#include <jni.h>
#include <QDebug>

#include "haveclip-core/src/ClipboardManager.h"

extern "C" {
	JNIEXPORT void JNICALL
	Java_cz_havefun_haveclip_ClipboardService_updateClipboard(JNIEnv *env, jobject obj);
}

JNIEXPORT void JNICALL
Java_cz_havefun_haveclip_ClipboardService_updateClipboard(JNIEnv *env, jobject obj)
{
	Q_UNUSED(env);
	Q_UNUSED(obj);

	ClipboardManager::instance()->clipboardChanged();
}
