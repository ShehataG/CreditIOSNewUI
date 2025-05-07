//
//  VehiclesGeneralView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI
import SanarKit

struct VehMedGeneralView: View {
    @EnvironmentObject var servicesStatusVM: ServicesStatusVM
    @State var noNet = false
    var body: some View {
        if servicesStatusVM.done {
            VStack(spacing:0) {
                VehiclesGeneralView()
                MedicalGeneralView()
            }
        }
        else {
            if noNetwork() {
                NetworkView() {
                    Task {
                        await servicesStatusVM.getConfigs()
                    }
                }
            }
            else {
                LoadingView()
            }
        }
    }
}
