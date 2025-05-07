//
//  AppleMapView.swift
//  MprayerSWUI
//
//  Created by Ahmed Mahmoud on 4/5/23.
//

import SwiftUI
import AVKit
import MapKit

struct AppleMapView: UIViewRepresentable {
    @Binding var mapRegion:MKCoordinateRegion
    @Binding var dragEnded:Int
    let showsUserLocation:Bool
    let mapView = MKMapView(frame: .zero)
    func makeUIView(context: Context) -> MKMapView {
        mapView.region = mapRegion
        mapView.showsUserLocation = showsUserLocation
        mapView.delegate = context.coordinator
        let region = mapView.regionThatFits(mapRegion)
        mapView.setRegion(region, animated: false)
        return mapView
    }
    func updateUIView(_ uiView: MKMapView, context: Context) {
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: AppleMapView
        init(_ parent: AppleMapView) {
            self.parent = parent
        }
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            self.parent.mapRegion = mapView.region
        }
        private var regionDidChangeFromUserInteraction: Bool {
            self.parent.mapView.subviews
                .compactMap { $0.gestureRecognizers }
                .reduce([], +)
                .contains(where: { $0.state == .ended })
        }
        func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
            guard regionDidChangeFromUserInteraction else {
                return
            }
        }
        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            guard regionDidChangeFromUserInteraction else {
                return
            }
            parent.dragEnded += 1
        }
    }
}
