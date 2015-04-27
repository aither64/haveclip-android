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
