package com.mechwv.meet_the_people

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import com.yandex.mapkit.MapKitFactory

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
//        MapKitFactory.setLocale("YOUR_LOCALE") // Your preferred language. Not required, defaults to system language
        MapKitFactory.setApiKey("8306a4eb-5287-465b-86ce-7b86b03637a6") // Your generated API key
        super.configureFlutterEngine(flutterEngine)
    }
//    fun onCreate() {
//        MapKitFactory.setApiKey("8306a4eb-5287-465b-86ce-7b86b03637a6")
//    }
}
