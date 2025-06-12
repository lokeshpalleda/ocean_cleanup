// Top-level build file where you can add configuration options common to all sub-projects/modules.

plugins {
    id("com.android.application") version "8.4.0" apply false // ✅ Compatible version
   // id("com.google.gms.google-services") version "4.4.1" apply false // ✅ Firebase services
    id("org.jetbrains.kotlin.android") version "1.8.22" apply false 
}

allprojects {
    repositories {
        google() // Required for Android and Firebase dependencies
        mavenCentral()
    }
}

// Optional: Customize build directory (safe to remove if not required)
val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.set(newBuildDir)

subprojects {
    val newSubprojectBuildDir = newBuildDir.dir(project.name)
    project.layout.buildDirectory.set(newSubprojectBuildDir)

    // Ensure app is evaluated before libraries if needed
    evaluationDependsOn(":app")
}

// Optional clean task
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
