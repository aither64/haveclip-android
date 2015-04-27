package cz.havefun.haveclip;

import android.app.Service;
import android.content.ClipData;
import android.content.ClipDescription;
import android.content.ClipboardManager;
import android.content.ClipboardManager.OnPrimaryClipChangedListener;
import android.content.Intent;
import android.os.IBinder;


public class ClipboardService extends Service {
    private ClipboardManager m_manager;

    private OnPrimaryClipChangedListener listener = new OnPrimaryClipChangedListener() {
        public void onPrimaryClipChanged() {
            checkClipboard();
        }
    };

    private native void updateClipboard();

    @Override
    public void onCreate() {
        m_manager = (ClipboardManager) getSystemService(CLIPBOARD_SERVICE);
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        m_manager.addPrimaryClipChangedListener(listener);

        return START_STICKY;
    }

    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    private void checkClipboard() {
        if (!m_manager.hasPrimaryClip())
            return;

        ClipData data = m_manager.getPrimaryClip();
        ClipDescription desc = data.getDescription();

        if (desc.hasMimeType(ClipDescription.MIMETYPE_TEXT_PLAIN)
            || desc.hasMimeType(ClipDescription.MIMETYPE_TEXT_HTML)) {
            updateClipboard();
        }
    }
}
