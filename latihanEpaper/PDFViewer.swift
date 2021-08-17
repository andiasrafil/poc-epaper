//
//  PDFView.swift
//  PDFView
//
//  Created by Accounting on 08/08/21.
//

import SwiftUI
import PSPDFKit
import PSPDFKitUI
import Combine
struct PDFViewer: View {
    @EnvironmentObject var downloadManager : DownloadManager
    let documentUrl : URL
    
    
    @State var pageMode : PageMode = .single
    @State private var pageIndex = PageIndex(0)
    @State private var viewMode = ViewMode.document
    private let actionEventPublisher = PassthroughSubject<PDFView.ActionEvent, Never>()
    
    var body: some View {
        VStack(alignment: .center, spacing: 10, content: {
            PDFView(
                document: downloadManager.downloadedDocument,
                pageIndex: $pageIndex,
                viewMode: $viewMode,
                actionEventPublisher: actionEventPublisher
            )
            {
//                $0.searchMode = .inline
//                $0.isRenderAnimationEnabled = false
//                $0.shouldHideNavigationBarWithUserInterface = false
//                $0.shouldHideStatusBarWithUserInterface = false
//                $0.annotationGroupingEnabled = false
//                $0.bookmarkIndicatorInteractionEnabled = false
//                $0.hideThumbnailBarForSinglePageDocuments = true
                $0.overrideClass(ThumbnailViewController.self, with: CustomThumbnail.self)
            }
            .scrollDirection(.horizontal)
            .pageTransition(.scrollPerSpread)
            .pageMode(pageMode)
            .spreadFitting(.fill)
            .pageLabelEnabled(false)
            .userInterfaceViewMode(.never)
        
        })
            .navigationBarItems(trailing: HStack{
                barButton("magnifyingglass.circle", event: {
                    .search(sender: $0)
                })

                Button(action: {
                    let textSearch = TextSearch(document: downloadManager.downloadedDocument!)
                    textSearch.search(for: "p")
                    let handler = NyobaDelegate(delegateTarget: textSearch, originalDelegate: textSearch.delegate)
                    textSearch.delegate = handler

                }, label: {
                    Image(systemName: "magnifyingglass.circle")
                })
                
                Button(action: {
                    if pageMode == .single {
                        pageMode = .double
                    } else {
                        pageMode = .single
                    }
                }, label: {
                    Image(systemName: pageMode == .single ? "case" : "case.fill")
                })
                
                if viewMode == .document {
                    barButton("square.grid.2x2") { _ in
                        viewMode = .thumbnails
                        return nil
                    }
                } else {
                    barButton("square.grid.2x2.fill") { _ in
                        //showAnnotationToolbar = false
                        viewMode = .document
                        return nil
                    }
                }
                
            })
        
//        Stepper("Current Page: \(pageMode == .single ? pageIndex + 1 : pageIndex + 2)", value: $pageIndex, in: 0...downloadManager.downloadedDocument!.pageCount - 1)
        HStack(alignment: .center, spacing: 10, content: {
            Text("Current Page \(pageIndex + 1)")
            Spacer()
            Button(action: {
                if pageIndex > 0 {
                    if pageIndex % 2 == 0 && pageMode == .double {
                        if pageIndex == 1 {
                            pageIndex -= 1
                        } else {
                            pageIndex -= 2
                        }
                    }
                    else if (pageIndex == 1) {
                        pageIndex -= 1
                    }
                    else {
                        pageIndex -= (pageMode == .single ? 1 : 2)
                    }
                }
            }, label: {
                Text("Prev")
            })
            Button(action: {
                var currentPage = pageIndex
                if currentPage < downloadManager.downloadedDocument!.pageCount - 1 {
                    if (pageIndex % 2 == 0 && pageMode == .double && pageIndex != 0){
                        currentPage += 1
                        pageIndex = currentPage
                    } else {
                        if((currentPage + (pageMode == .single ? 1 : 2)) < downloadManager.downloadedDocument!.pageCount){
                            currentPage += (pageMode == .single ? 1 : 2)
                            pageIndex = currentPage
                        } else {
                            currentPage += 1
                            pageIndex = currentPage
                        }
                    }
                }
            }, label: {
                Text("Next")
            })
        })
        .padding()
    }
    
    private func barButton(_ systemImage: String, event: @escaping (AnyObject?) -> PDFView.ActionEvent?) -> some View {
        AnchorButton {
            if let realizedEvent = event($0) {
                print("masukkkk \(realizedEvent)")
                actionEventPublisher.send(realizedEvent)
            }
            print("masuk ga sih")
        } content: {
            Image(systemName: systemImage)
                .padding(10) // padding increases the touch target
        }
    }
}



class NyobaDelegate : StandaloneDelegate<TextSearchDelegate>, TextSearchDelegate{
    func didFinish(_ textSearch: TextSearch, term searchTerm: String, searchResults: [SearchResult], isFullSearch: Bool, pageTextFound: Bool) {
        SearchHighlightView.appearance()
    }
}

class CustomThumbnail : ThumbnailViewController {
    override var filterOptions: [ThumbnailViewFilter]! {
        get {
            return [.showAll]
        }
        
        set {
            
        }
    }
    
}


