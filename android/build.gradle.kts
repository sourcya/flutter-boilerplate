allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

// This directly targets the :webcrypto project
project(":webcrypto") {
    afterEvaluate {
        // Check if it's an Android project (app or library)
        if (plugins.hasPlugin("com.android.application") || plugins.hasPlugin("com.android.library")) {

            // Configure the 'android' extension
            extensions.configure<com.android.build.api.dsl.CommonExtension<*, *, *, *, *, *>>("android") {

                // Set namespace if it's missing (good practice)
                if (namespace == null || namespace == "") {
                    namespace = "$group"
                }

                compileSdk = 36
                buildToolsVersion = "36.0.0"
                ndkVersion = "28.0.12433566"
            }
        }
    }
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}