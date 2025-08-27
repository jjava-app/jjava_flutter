plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services") version "4.4.2" apply false
}

android {
    namespace = "com.example.jjava_flutter"
    compileSdk = 33   // 안정 버전

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.jjava_flutter"
        minSdkVersion flutter.minSdkVersion           // Flutter 최소 지원 버전
        targetSdk = 33    // 최적화 대상
        versionCode = 1
        versionName = "1.0"
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

dependencies {
    // Firebase BOM (모든 Firebase SDK 버전 관리용)
    implementation(platform("com.google.firebase:firebase-bom:34.1.0"))

    // Firebase Analytics
    implementation("com.google.firebase:firebase-analytics")

    // Firebase Authentication 예시
    implementation("com.google.firebase:firebase-auth")
}

flutter {
    source = "../.."
}
