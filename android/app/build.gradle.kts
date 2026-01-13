import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("keystore.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(keystorePropertiesFile.inputStream())
}


android {
    namespace = "io.sourcya.app"
    compileSdk = 36
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        isCoreLibraryDesugaringEnabled = true
    }
// Tell Gradle to exclude the Android library (without Admin)
// that is added by the objectbox_flutter_libs package for debug builds.
    configurations {
        named("debugImplementation") {
            exclude(group = "io.objectbox", module = "objectbox-android")
        }
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }



    defaultConfig {
        applicationId = "io.sourcya.app"
        minSdk = 23
        targetSdk = 36
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        manifestPlaceholders.putAll(
            mapOf(
                "auth0Domain" to "sourcya.eu.auth0.com",
                "auth0Scheme" to "https"
            )
        )
        multiDexEnabled = true
    }

    signingConfigs {
        val storeFilePath = keystoreProperties.getProperty("storeFile")?.let { file(it) }
        create("release") {
            if (System.getenv()["CI"].toBoolean()) {
                storeFile = file(System.getenv()["CM_KEYSTORE_PATH"])
                storePassword = System.getenv()["CM_KEYSTORE_PASSWORD"]
                keyAlias = System.getenv()["CM_KEY_ALIAS"]
                keyPassword = System.getenv()["CM_KEY_PASSWORD"]
            } else if (storeFilePath != null) {
                storeFile = storeFilePath
                storePassword = keystoreProperties.getProperty("storePassword")
                keyAlias = keystoreProperties.getProperty("keyAlias")
                keyPassword = keystoreProperties.getProperty("keyPassword")
            }
        }

        getByName("debug") {
            if (storeFilePath != null) {
                storeFile = storeFilePath
                storePassword = keystoreProperties.getProperty("storePassword")
                keyAlias = keystoreProperties.getProperty("keyAlias")
                keyPassword = keystoreProperties.getProperty("keyPassword")
            } else {
                println("Warning: keystore.properties not found. Using default debug signing.")
            }
        }
    }
    buildTypes {
        getByName("release") {
            isMinifyEnabled = false
            isShrinkResources = false
            signingConfig = signingConfigs.getByName("release")
        }
        getByName("debug") {
            isDebuggable = true
            signingConfig = signingConfigs.getByName("debug")
        }
    }

}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")
    val multidex_version = "2.0.1"
    implementation("androidx.multidex:multidex:$multidex_version")
    debugImplementation("io.objectbox:objectbox-android-objectbrowser:5.0.1")
}

flutter {
    source = "../.."
}
