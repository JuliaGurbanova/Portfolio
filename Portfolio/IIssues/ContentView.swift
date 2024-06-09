//
//  ContentView.swift
//  Portfolio
//
//  Created by Julia Gurbanova on 24.08.2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.requestReview) var requestReview
    @StateObject var viewModel: ViewModel

    private let newIssueActivity = "me.gurbanova.julia.Portfolio.newIssue"

    var body: some View {
        List(selection: $viewModel.selectedIssue) {
            ForEach(viewModel.dataController.issuesForSelectedFilter()) { issue in
                IssueRow(issue: issue)
            }
            .onDelete(perform: viewModel.delete)
        }
        .navigationTitle("Issues")
        .searchable(
            text: $viewModel.filterText,
            tokens: $viewModel.filterTokens,
            suggestedTokens: .constant(viewModel.suggestedFilterTokens),
            prompt: "Filter issues, or type # to add tags"
        ) { tag in
            Text(tag.tagName)
        }
        .toolbar(content: ContentViewToolbar.init)
        .onAppear(perform: askForReview)
        .onOpenURL(perform: viewModel.openURL)
        .userActivity(newIssueActivity) { activity in
            activity.isEligibleForPrediction = true
            activity.title = "New Issue"
        }
        .onContinueUserActivity(newIssueActivity, perform: resumeActivity)
    }

    init(dataController: DataController) {
        let viewModel = ViewModel(dataController: dataController)
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    func askForReview() {
        if viewModel.shouldRequestReview {
            requestReview()
        }
    }

    func resumeActivity(_ userActivity: NSUserActivity) {
        viewModel.dataController.newIssue()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(dataController: .preview)
    }
}
