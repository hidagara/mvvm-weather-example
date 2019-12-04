//
//  MapView.swift
//  mvvm-weather-example
//
//  Created by Roman Guseynov on 04.12.2019.
//  Copyright © 2019 Roman Guseynov. All rights reserved.
//

import Foundation
import SwiftUI
import MapKit
struct MapView: UIViewRepresentable {
    
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        uiView.addAnnotation(annotation)
        uiView.setRegion(region, animated: true)
    }
    
    
    typealias UIViewType = MKMapView
    
    private let coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MapView.UIViewType {
        MKMapView()
    }
    
    
}

