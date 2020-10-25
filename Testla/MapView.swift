//
//  MapView.swift
//  Testla
//
//  Created by Akın Özgen on 24.10.2020.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    func makeUIView(context: Context) -> some MKMapView {
        MKMapView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        let coords = CLLocationCoordinate2D(
            latitude: 39.3736497, longitude: -104.91099933
        )
        let span = MKCoordinateSpan(
            latitudeDelta: 0.2, longitudeDelta: 0.2
        )
        let region = MKCoordinateRegion(
            center: coords, span: span
        )
        uiView.setRegion(region, animated: true)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
