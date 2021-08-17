//
//  ContentView.swift
//  latihanEpaper
//
//  Created by Accounting on 04/08/21.
//

import SwiftUI
import CoreData
import PSPDFKit
import PSPDFKitUI
import PDFKit


struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: LocalEpaper.fetch(), animation: .default)
    private var epapers: FetchedResults<LocalEpaper>
    @StateObject var downloadManager = DownloadManager.shared
    @ViewBuilder
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: {
                    EpaperPage()
                        .environmentObject(downloadManager)
                }, label: {
                    Text("PINDAH PAGE DULU")
                })
                
                //openPDF
                if !epapers.isEmpty {
                    openPDF
                }
                
                
            }
        }
    }
    
    var openPDF : some View {
        NavigationLink(destination: {
            PDFViewer(documentUrl: URL(string: epapers[0].path!)!)
                .environmentObject(downloadManager)
        }, label: {
            Text("open")
        })
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
