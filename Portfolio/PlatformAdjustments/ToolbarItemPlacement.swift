//
//  ToolbarItemPlacement.swift
//  Portfolio
//
//  Created by Julia Gurbanova on 07.06.2024.
//

import SwiftUI

extension ToolbarItemPlacement {
    #if os(watchOS)
    static let automaticOrLeading = ToolbarItemPlacement.topBarLeading
    static let automaticOrTrailing = ToolbarItemPlacement.topBarTrailing
    #else
    static let automaticOrLeading = ToolbarItemPlacement.automatic
    static let automaticOrTrailing = ToolbarItemPlacement.automatic
    #endif
}
