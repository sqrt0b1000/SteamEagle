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
                "Builder",
                "HtmlTags",
            ],
        ),

        .target(
            name: "Contexts",
        ),
        .target(
            name: "Builder",
            dependencies: [
                "Contexts"
            ],
        ),
        .target(
            name: "HtmlTags",
            dependencies: [
                "Contexts",
                "Builder",
            ],
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
            "Builder",
            "HtmlTags",
            .product(name: "HTMLKit", package: "htmlkit"),
        ],
        path: "Benchmarks/BenchmarkHTMLKit",
        plugins: [
            .plugin(name: "BenchmarkPlugin", package: "package-benchmark")
        ]
    )
]

