package cz.havefun.haveclip;

import android.content.Intent;
import android.os.Bundle;


public class HaveClipActivity extends org.qtproject.qt5.android.bindings.QtActivity
{
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        Intent intent = new Intent(this, ClipboardService.class);
        startService(intent);
    }
}
