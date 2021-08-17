//
//  EpaperPage.swift
//  EpaperPage
//
//  Created by Accounting on 06/08/21.
//

import SwiftUI
import PSPDFKit

struct EpaperPage: View {
    @EnvironmentObject var downloadManager : DownloadManager
    @Environment(\.managedObjectContext) private var viewContext
    var body: some View {
        Button(action: {
            downloadManager.startDownload(url: URL(string: "https://filesamples.com/samples/document/pdf/sample3.pdf")!, coreDataContext: viewContext)
        }, label: {
            Text("download")
        }).buttonStyle(DefaultButtonStyle())
        
        switch downloadManager.downloadState {
        case .initial:
            Text("initial")
        case .progress(let progress):
            ProgressView("Downloading… \(progress)", value: progress, total: 1)
                .padding()
        case .finish:
            Text("finished")
        case .failed:
            Text("Failed")
        }
        
        Button(action: {
            downloadManager.cancleTasks()
        }, label: {
            Text("cancle download")
        })
    }
}
