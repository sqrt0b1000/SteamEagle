// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SteamEagle",
    platforms: [
        .macOS(.v26)
    ],
    products: [
        .executable(
            name: "SteamEagle",
            targets: [
                "SteamEagle"
            ]
        )
        /*.library(
            name: "SteamEagle",
            targets: [
                "Contexts",
                "Builder",
                "HtmlTags",
            ]
        )*/
    ],
    dependencies: [
        .package(
            url: "https://github.com/ordo-one/package-benchmark", .upToNextMajor(from: "1.29.11")),

        .package(url: "https://github.com/vapor-community/htmlkit.git", branch: "main"),
    ],
    targets: [
        // Main Target
        .executableTarget(
            name: "SteamEagle",
            dependencies: [
                "Contexts",
                "HtmlTags",
            ],
        ),

        // Declaration of the different html tags to be used
        .target(
            name: "HtmlTags",
            dependencies: [
                "Contexts",
                "Renderer",
            ],
        ),

        // Declarations of different contexts of an webpage
        .target(
            name: "Contexts",
            dependencies: [],
        ),

        // Foundation allowing perfomative builds of whole pages
        .target(
            name: "Renderer",
            dependencies: [],
        ),

        //
        // - MARK: Test targests
        //
        .testTarget(
            name: "SteamEagleTests",
            dependencies: ["SteamEagle"]
        ),
    ]
)

// Benchmark of BenchmarkHTMLKit
package.targets += [
    .executableTarget(
        name: "BenchmarkHTMLKit",
        dependencies: [
            .product(name: "Benchmark", package: "package-benchmark"),
            "SteamEagle",
            "Contexts",
            "HtmlTags",
            "Renderer",
            .product(name: "HTMLKit", package: "htmlkit"),
        ],
        path: "Benchmarks/BenchmarkHTMLKit",
        plugins: [
            .plugin(name: "BenchmarkPlugin", package: "package-benchmark")
        ]
    )
]
