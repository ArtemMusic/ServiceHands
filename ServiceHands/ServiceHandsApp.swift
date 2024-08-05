//
//  ServiceHandsApp.swift
//  ServiceHands
//
//  Created by Artem on 8/5/24.
//

import SwiftUI
import SwiftData

@main
struct ServiceHandsApp: App {
    var body: some Scene {
        WindowGroup{
            ContentView()
                .modelContainer(for: Card.self, inMemory: false)
        }
    }
}
