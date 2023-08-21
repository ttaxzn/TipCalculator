//
//  TipCalculatorApp.swift
//  TipCalculator
//
//  Created by Tea Abuselidze on 8/17/23.
//

import SwiftUI

@main
struct TipCalculatorApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ContentViewModel())
        }
    }
}
