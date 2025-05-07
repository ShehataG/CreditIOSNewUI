//
//  AppleStaticMapView.swift
//  MprayerSWUI
//
//  Created by Ahmed Mahmoud on 4/5/23.
//

import SwiftUI
import AVKit
import MapKit

struct AppleStaticMapView: UIViewRepresentable {
    let mapRegion:MKCoordinateRegion
    let showsUserLocation:Bool
    let mapView = MKMapView(frame: .zero)
    func makeUIView(context: Context) -> MKMapView {
        mapView.region = mapRegion
        mapView.showsUserLocation = showsUserLocation
        let region = mapView.regionThatFits(mapRegion)
        mapView.setRegion(region, animated: false)
        return mapView
    }
    func updateUIView(_ uiView: MKMapView, context: Context) {
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject {
        var parent: AppleStaticMapView
        init(_ parent: AppleStaticMapView) {
            self.parent = parent
        }
    }
}
