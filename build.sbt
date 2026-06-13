// See README.md for license details.

ThisBuild / scalaVersion     := "2.13.8"
ThisBuild / version          := "0.1.0"
ThisBuild / organization     := "%ORGANIZATION%"

lazy val root = (project in file("."))
  .settings(
    name := "SE",
    fork := true,
    javaOptions ++= Seq("-Xmx3G", "-Xss8m", "-XX:+UseG1GC"),
    libraryDependencies ++= Seq(
      "edu.berkeley.cs" %% "chisel3" % "3.5.2",
    ),
    addCompilerPlugin("edu.berkeley.cs" % "chisel3-plugin" % "3.5.2" cross CrossVersion.full),
    scalacOptions ++= Seq(
      "-Ymacro-annotations",
      "-language:reflectiveCalls",
      "-deprecation",
      "-feature",
      "-Xcheckinit"//,
    )
  )