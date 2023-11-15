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
      name: "ApolloLegacyCodegenLib",
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
        path: "ApolloCore"),
    .target(
      name: "ApolloLegacy",
      dependencies: [
        "ApolloLegacyCore",
      ],
      path: "Apollo"),
    .target(
      name: "ApolloLegacyCodegenLib",
      dependencies: [
        "ApolloLegacyCore",
        .product(name: "Stencil", package: "Stencil"),
      ],
      path: "ApolloCodegenLib")
    ]
)
