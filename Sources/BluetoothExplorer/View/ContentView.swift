//
//  ContentView.swift
//  
//
//  Created by Alsey Coleman Miller on 25/12/21.
//

import Foundation
import TokamakDOM
import JavaScriptKit
import BluetoothWeb

struct ContentView: View {
    
    @ObservedObject
    var store: Store = .shared
    
    @State
    var device: WebCentral.Peripheral?
    
    @State
    var isScanning = false
    
    @State
    var isSupported: Bool?
    
    var body: some View {
        switch isSupported {
        case .none:
            AnyView(Text("Loading..."))
                .task { await checkSupportedBrowser() }
        case .some(false):
            AnyView(UnsupportedView())
        case .some(true):
            if isScanning {
                AnyView(Text("Scanning for devices..."))
            } else {
                AnyView(
                    NavigationView {
                        VStack {
                            Button("Scan") {
                                Task { await scan() }
                            }
                            if let peripheral = self.device {
                                PeripheralView(peripheral: peripheral)
                            }
                        }
                    }
                )
            }
        }
    }
}

extension ContentView {
    
    func checkSupportedBrowser() async {
        isSupported = await WebCentral.shared?.isAvailable ?? false
    }
    
    func scan() async {
        do { device = try await store.scan() }
        catch { print(error) }
    }
}