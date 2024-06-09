//
//  NumberBadge.swift
//  Portfolio
//
//  Created by Julia Gurbanova on 07.06.2024.
//

import SwiftUI

extension View {
    func numberBadge(_ number: Int) -> some View {
        #if os(watchOS)
        self
        #else
        self.badge(number)
        #endif
    }
}
