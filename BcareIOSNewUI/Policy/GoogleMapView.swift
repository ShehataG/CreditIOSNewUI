//
//  GoogleMapView.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 25/05/2024.
//

import Foundation
import SwiftUI
import Combine
import GoogleMaps
import CoreLocation

struct GoogleMapView: UIViewRepresentable {
//    let marker = GMSMarker()
    @Binding var coordinate:CLLocationCoordinate2D
    @Binding var dragEnded:Int
    func makeUIView(context: Self.Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 18.0)
        let options = GMSMapViewOptions()
        options.frame = CGRect.zero
        options.camera = camera
        let mapView = GMSMapView(options: options)
        mapView.settings.consumesGesturesInView = false
        mapView.delegate = context.coordinator
        return mapView
    }
    func updateUIView(_ mapView: GMSMapView, context: Self.Context) {
//        marker.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.latitude)
//        marker.title = "Riyadh"
//        marker.snippet = "Saudi"
//        marker.map = mapView
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, @preconcurrency GMSMapViewDelegate {
        var parent: GoogleMapView
        init(_ parent: GoogleMapView) {
            self.parent = parent
        }
        @MainActor func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
            let coordiate = position.target //.projection.coordinate(for: mapView.center)
            parent.$coordinate.wrappedValue = CLLocationCoordinate2D(latitude: coordiate.latitude, longitude: coordiate.longitude)
            parent.dragEnded += 1
        }
    }
}


struct GoogleStaticMapView: UIViewRepresentable {
    let coordinate:CLLocationCoordinate2D
    func makeUIView(context: Self.Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 18.0)
        let options = GMSMapViewOptions()
        options.frame = CGRect.zero
        options.camera = camera
        let mapView = GMSMapView(options: options)
        mapView.settings.consumesGesturesInView = false
        return mapView
    }
    func updateUIView(_ mapView: GMSMapView, context: Self.Context) {
    }
}
