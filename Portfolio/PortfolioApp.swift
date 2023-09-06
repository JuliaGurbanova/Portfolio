//
//  PortfolioApp.swift
//  Portfolio
//
//  Created by Julia Gurbanova on 24.08.2023.
//

import SwiftUI

@main
struct PortfolioApp: App {
    @StateObject var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            NavigationSplitView {
                SidebarView()
            } content: {
                ContentView()
            } detail: {
                DetailView()
            }
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
        }
    }
}
