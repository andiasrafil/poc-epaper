//
//  PdfDownloadManger.swift
//  latihanEpaper
//
//  Created by Accounting on 05/08/21.
//

import Foundation
import OSLog
import Combine
import PSPDFKit
import PSPDFKitUI
import CoreData

enum DownloadState {
    case initial
    case progress(Double)
    case finish
    case failed
}

class DownloadManager: NSObject, ObservableObject {
    
    static var shared = DownloadManager()

    private var urlSession: URLSession!
    
    @Published var tasks: URLSessionTask? = nil
    @Published var downloadProgress : Double = 0
    
    @Published var downloadState : DownloadState = .initial
    var documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    var downloadedDocument : Document? = nil
    var context : NSManagedObjectContext? = nil

    override private init() {
        super.init()

        let config = URLSessionConfiguration.background(withIdentifier: "\(Bundle.main.bundleIdentifier!).background")
        

        // Warning: Make sure that the URLSession is created only once (if an URLSession still
        // exists from a previous download, it doesn't create a new URLSession object but returns
        // the existing one with the old delegate object attached)
        urlSession = URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue())

//        updateTasks()
    }

    func startDownload(url: URL, coreDataContext: NSManagedObjectContext) {
        tasks = urlSession.downloadTask(with: url)
        tasks?.resume()
        context = coreDataContext
        
    }

//    private func updateTasks() {
//        urlSession.getAllTasks { tasks in
//            DispatchQueue.main.async {
//                self.tasks = tasks
//            }
//        }
//    }
    
    func cancleTasks() {
        tasks?.cancel()
    }
}

extension DownloadManager: URLSessionDelegate, URLSessionDownloadDelegate {
    
    func urlSession(_: URLSession, downloadTask: URLSessionDownloadTask, didWriteData _: Int64, totalBytesWritten _: Int64, totalBytesExpectedToWrite _: Int64) {
        DispatchQueue.main.async { [self] in
            downloadState = .progress(downloadTask.progress.fractionCompleted)
        }
        os_log("Progress %f for %@", type: .debug, downloadTask.progress.fractionCompleted, downloadTask)
    }

    func urlSession(_: URLSession, downloadTask _: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        os_log("Download finished: %@", type: .info, location.absoluteString)
        DispatchQueue.main.async { [self] in
            downloadState = .finish
        }
        //let passphrase = "eQwUpUG9NuzJbF/4g0xdIBGXj/9fpF9MbmfizwLEANk="
        let fileName = documentDirectory.appendingPathComponent("andi.pdf")
        try? FileManager.default.removeItem(at: fileName)
        do {
            
            //let file = try Data(contentsOf: location)
            
            try FileManager.default.copyItem(at: location, to: fileName)
//            let cryptoWrapper = AESCryptoDataProvider(url: fileName, passphraseProvider: { passphrase })
//
//            downloadedDocument = Document(dataProviders: [cryptoWrapper!])
//            downloadedDocument?.uid = fileName.lastPathComponent
            
            downloadedDocument = Document(url: fileName)
            let _ = LocalEpaper(path: "\(fileName)", name: "andi", context: context!)
            try? context?.save()
          
        } catch(let error) {
            os_log("error saving data \(error.localizedDescription)")
        }
        // The file at location is temporary and will be gone afterwards
    }

    func urlSession(_: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            os_log("Download error: %@", type: .error, String(describing: error))
            if "cancelled".contains(error.localizedDescription) {
                DispatchQueue.main.async { [self] in
                    downloadState = .finish
                }
            }
        } else {
            os_log("Task finished: %@", type: .info, task)
        }
    }
}
