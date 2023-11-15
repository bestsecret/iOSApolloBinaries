// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ApolloLegacy",
    products: [
    .library(
      name: "ApolloLegacyCore",
      targets: ["ApolloCore"]),
    .library(
      name: "ApolloLegacy",
      targets: ["Apollo"]),
    .library(
      name: "ApolloLegacyCodegenLib",
      targets: ["ApolloCodegenLib"]),
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
        name: "ApolloCore",
        dependencies: []),
    .target(
      name: "Apollo",
      dependencies: [
        "ApolloCore",
      ]),
    .target(
      name: "ApolloCodegenLib",
      dependencies: [
        "ApolloCore",
        .product(name: "Stencil", package: "Stencil"),
      ])
    ]
)
