// See README.md for license details.

ThisBuild / scalaVersion     := "2.12.15"
ThisBuild / version          := "0.1.0"
ThisBuild / organization     := "%ORGANIZATION%"

lazy val root = (project in file("."))
  .settings(
    name := "SE",
    libraryDependencies ++= Seq(
      "edu.berkeley.cs" %% "chisel3" % "3.5.2",
      "edu.berkeley.cs" %% "chiseltest" % "0.5.2"
    ),
    addCompilerPlugin("edu.berkeley.cs" % "chisel3-plugin" % "3.5.2" cross CrossVersion.full),
    scalacOptions ++= Seq(
      "-Xsource:2.13",
      "-language:reflectiveCalls",
      "-deprecation",
      "-feature",
      "-Xcheckinit"//,
    )
  )