plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
   // id("com.google.gms.google-services") // ✅ Needed for Firebase
}

android {
    namespace = "com.example.ocean_clean"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.ocean_clean"
        minSdk = 23
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // implementation("com.google.firebase:firebase-analytics") // ✅ Optional: for Analytics
    // implementation("com.google.firebase:firebase-auth")       // ✅ For Firebase Auth
    // implementation("com.google.firebase:firebase-firestore")  // ✅ For Firestore
}
