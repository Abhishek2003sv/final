// app-level build.gradle.kts
plugins {
    id("com.android.application")
    id("com.google.gms.google-services") // Add this line to apply the Firebase plugin
}

android {
    compileSdk = 33
    defaultConfig {
        applicationId = "com.example.my_flutter_app"
        minSdk = 21
        targetSdk = 33
        versionCode = 1
        versionName = "1.0"
        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
    }

    buildTypes {
        release {
            minifyEnabled false
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
        }
    }
}

dependencies {
    implementation "com.google.firebase:firebase-analytics:21.0.0"  // Firebase Analytics (Optional)
    // Add other Firebase SDKs you need like Firebase Auth, Firestore, etc.
}
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if true;
    }
  }
}
