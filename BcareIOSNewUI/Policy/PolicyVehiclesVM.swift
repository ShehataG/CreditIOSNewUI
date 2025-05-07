//
//  PolicyVehiclesVM.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class PolicyVehiclesVM : MainObservable {
    @Published var submitGetFile = false
    @Published var downloadUrl:URL?

    override init() {
        super.init()
    }
   
    func downloadFile(_ item:PoliciesResult)  {
        if noNetwork() {
            showNoNetwork()
            return
        }
        let parameters:[String:Any] = [
            "fileId": item.policyFileId!,
            "language": langText,
            "channel": "ios"
        ]
        Task {
            submitGetFile = true
            let (result,error) = await JSONPlaceholderService.downloadPolicyFile.request(type:DownloadPolicyItem.self,parameters: parameters)
            self.submitGetFile = false
            switch result {
            case .success(let res):
                if res.errorCode == 1 {
                    self.savePdf(fileName: item.policyFileId!, str: res.result)
                }
                else {
                    self.showError(res.errorDescription)
                }
                 break
            case .failure(_):
                if let error = error {
                    print(error)
                    self.showError(error.description)
                }
                break
            }
        }
    }
    func savePdf(fileName:String,str:String) {
        let pdfData = Data(base64Encoded: str, options: .ignoreUnknownCharacters)!
        let resourceDocPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last! as URL
        let pdfNameFromUrl = "BCare-\(fileName).pdf"
        let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrl)
        do {
            try? FileManager.default.removeItem(at: actualPath)
            try pdfData.write(to: actualPath, options: .atomic)
            downloadUrl = actualPath
            print("Pdf is successfully saved!")
        } catch {
            print("Pdf could not be saved")
        }
    }
}
