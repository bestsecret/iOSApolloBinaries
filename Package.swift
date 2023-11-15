// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ApolloLegacy",
    products: [
    .library(
      name: "ApolloLegacyCore",
      targets: ["ApolloLegacyCore"]),
    .library(
      name: "ApolloLegacy",
      targets: ["ApolloLegacy"]),
    .library(
        name: "ApolloLegacy-Dynamic",
        type: .dynamic,
        targets: ["ApolloLegacy"]),
    .library(
      name: "ApolloLegacyCodegenLib",
      targets: ["ApolloLegacyCodegenLib"]),
    .library(
        name: "ApolloLegacySQLite",
        targets: ["ApolloLegacySQLite"]),
    .library(
        name: "ApolloLegacyWebSocket",
        targets: ["ApolloLegacyWebSocket"]),
    ],
    dependencies: [
    .package(
      url: "https://github.com/stephencelis/SQLite.swift.git",
      .upToNextMinor(from: "0.12.2")),
    .package(
      url: "https://github.com/daltoniam/Starscream",
      .upToNextMinor(from: "3.1.1")),
    .package(
      url: "https://github.com/stencilproject/Stencil.git",
      .upToNextMinor(from: "0.14.0")),
    ],
    targets: [
      .target(
        name: "ApolloLegacyCore",
        dependencies: []),
    .target(
      name: "ApolloLegacy",
      dependencies: [
        "ApolloLegacyCore",
      ]),
    .target(
      name: "ApolloLegacyCodegenLib",
      dependencies: [
        "ApolloLegacyCore",
        .product(name: "Stencil", package: "Stencil"),
      ]),
    .target(
      name: "ApolloLegacySQLite",
      dependencies: [
        "ApolloLegacy",
        .product(name: "SQLite", package: "SQLite.swift"),
      ]),
    .target(
      name: "ApolloLegacySQLiteTestSupport",
      dependencies: [
        "ApolloLegacySQLite",
        "ApolloLegacyTestSupport"
      ]),
    .target(
      name: "ApolloLegacyWebSocket",
      dependencies: [
        "ApolloLegacy",
        "ApolloLegacyCore",
        .product(name: "Starscream", package: "Starscream"),
      ]),
    .target(
      name: "ApolloLegacyTestSupport",
      dependencies: [
        "ApolloLegacy",
      ]),
    .target(
      name: "GitHubAPI",
      dependencies: [
        "ApolloLegacy",
      ]),
    .target(
      name: "StarWarsLegacyAPI",
      dependencies: [
        "ApolloLegacy",
      ]),
    .target(
      name: "UploadLegacyAPI",
      dependencies: [
        "ApolloLegacy",
      ]),
    .testTarget(
      name: "ApolloLegacyTests",
      dependencies: [
        "ApolloLegacyTestSupport",
        "StarWarsLegacyAPI",
        "UploadLegacyAPI"
      ]),
    .testTarget(
      name: "ApolloLegacyCacheDependentTests",
      dependencies: [
        "ApolloLegacySQLiteTestSupport",
        "StarWarsLegacyAPI",
      ]),
    .testTarget(
      name: "ApolloLegacyCodegenTests",
      dependencies: [
        "ApolloLegacyTestSupport",
        "ApolloLegacyCodegenLib"
      ]),
    .testTarget(
      name: "ApolloSQLiteTests",
      dependencies: [
        "ApolloLegacySQLiteTestSupport",
        "StarWarsLegacyAPI"
      ]),
    .testTarget(
      name: "ApolloLegacyWebsocketTests",
      dependencies: [
        "ApolloLegacyWebSocket",
        "ApolloLegacyTestSupport",
        "StarWarsLegacyAPI",
      ]),
    ]
)
