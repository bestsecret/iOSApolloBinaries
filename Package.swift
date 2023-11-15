// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ApolloLegacy",
    products: [
    .library(
      name: "ApolloCore",
      targets: ["ApolloLegacyCore"]),
    .library(
      name: "Apollo",
      targets: ["ApolloLegacy"]),
    .library(
      name: "ApolloCodegenLib",
      targets: ["ApolloLegacyCodegenLib"]),
    ],
    dependencies: [
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
        dependencies: [],
        path: "Sources/ApolloCore"),
    .target(
      name: "ApolloLegacy",
      dependencies: [
        "ApolloLegacyCore"],
      path: "Sources/Apollo"),
    .target(
      name: "ApolloLegacyCodegenLib",
      dependencies: [
        "ApolloLegacyCore",
        .product(name: "Stencil", package: "Stencil"),
      ],
      path: "Sources/ApolloCodegenLib")
    ]
)
