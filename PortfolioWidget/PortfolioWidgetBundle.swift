//
//  PortfolioWidgetBundle.swift
//  PortfolioWidget
//
//  Created by Julia Gurbanova on 21.03.2024.
//

import WidgetKit
import SwiftUI

@main
struct PortfolioWidgetBundle: WidgetBundle {
    var body: some Widget {
        SimplePortfolioWidget()
        ComplexPortfolioWidget()
    }
}
