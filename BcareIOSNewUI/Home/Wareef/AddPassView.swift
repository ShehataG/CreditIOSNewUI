//
//  AddPassView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//
  
import Foundation
import PassKit
import SwiftUI
import UIKit


struct AddPassView: UIViewControllerRepresentable {
    typealias UIViewControllerType = PKAddPassesViewController
    @Environment(\.presentationMode) var presentationMode
    @Binding var pass: PKPass?
    func makeUIViewController(context: Context) -> PKAddPassesViewController {
        let passVC = PKAddPassesViewController(pass: self.pass!)
        return passVC!
    }
    func updateUIViewController(_ uiViewController: PKAddPassesViewController, context: Context) {
        // Nothing goes here
    }
}

