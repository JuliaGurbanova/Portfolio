//
//  NoIssueView.swift
//  Portfolio
//
//  Created by Julia Gurbanova on 12.09.2023.
//

import SwiftUI

struct NoIssueView: View {
    @EnvironmentObject var dataController: DataController
    
    var body: some View {
        VStack {
            Text("No Issue Selected")
                .font(.title)
                .foregroundStyle(.secondary)
            
            Button("New Issue", action: dataController.newIssue)
        }
    }
}

struct NoIssueView_Previews: PreviewProvider {
    static var previews: some View {
        NoIssueView()
    }
}
