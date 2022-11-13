// swift-tools-version:5.5
import PackageDescription
let package = Package(
    name: "BluetoothWeb",
    platforms: [.macOS(.v12)],
    products: [
        .executable(
            name: "BluetoothExplorer",
            targets: ["BluetoothExplorer"]
        ),
        .library(
            name: "BluetoothWeb",
            targets: ["BluetoothWeb"]
        )
    ],
    dependencies: [
        .package(
            name: "Tokamak",
            url: "https://github.com/TokamakUI/Tokamak",
            from: "0.11.0"
        ),
        .package(
            name: "JavaScriptKit",
            url: "https://github.com/swiftwasm/JavaScriptKit",
            from: "0.17.0"
        )
    ],
    targets: [
        .executableTarget(
            name: "BluetoothExplorer",
            dependencies: [
                .product(
                    name: "TokamakShim",
                    package: "Tokamak"
                ),
                "BluetoothWeb"
            ]
        ),
        .target(
            name: "BluetoothWeb",
            dependencies: [
                .product(
                    name: "JavaScriptKit",
                    package: "JavaScriptKit"
                ),
            ]
        )
    ]
)
