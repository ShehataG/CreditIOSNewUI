//
//  RequestsListVM.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class RequestsListVM : MainObservable {
    @Published var bookings:[BookingsClientItem]?
    @Published var submitLoadingFile = false
    @Published var checkDownloads = 0
    @Published var downloadUrl:URL?
    var cacheUrls:[String:URL] = [:]
    
    override init() {
        super.init()
    }
    func downloadFile(_ ref:String) {
        if let res = cacheUrls[ref] {
            refreshUrl(res)
        }
        else {
            getMojazFile(ref)
        }
    }
    func refreshUrl(_ actualPath:URL) {
        downloadUrl = actualPath
        checkDownloads += 1
    }
    func getMojazFile(_ ref:String) {
        if submitLoadingFile {
            return
        }
        let parameters:[String:String] = [
            "ReferenceId": ref
        ]
        if noNetwork() {
            showNoNetwork()
            return
        }
        Task {
            submitLoadingFile = true
            let (result,error) = await JSONPlaceholderService.mojazFile.getFileData(parameters: parameters)
            switch result {
            case .success(let res):
                print(res)
                self.savePdf(res,ref:ref)
                break
            case .failure(_):
                if let error = error {
                    print(error)
                    self.showError(error.description)
                }
                break
            }
            self.submitLoadingFile = false
         }
    }
    func savePdf(_ pdfData:Data,ref:String) {
        let fileName = Date().timeIntervalSince1970.toString()
        let resourceDocPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last! as URL
        let pdfNameFromUrl = "BCare-Mojaz-\(fileName).pdf"
        let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrl)
        do {
            try? FileManager.default.removeItem(at: actualPath)
            try pdfData.write(to: actualPath, options: .atomic)
            cacheUrls[ref] = actualPath
            refreshUrl(actualPath)
            print("Pdf is successfully saved!")
        } catch {
            print("Pdf could not be saved")
        }
    }
}
