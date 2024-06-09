//
//  InlineNavigationBar.swift
//  Portfolio
//
//  Created by Julia Gurbanova on 19.05.2024.
//

import SwiftUI

extension View {
    func inlineNavigationBar() -> some View {
        #if os(macOS)
        self
        #else
        self.navigationBarTitleDisplayMode(.inline)
        #endif
    }
}
