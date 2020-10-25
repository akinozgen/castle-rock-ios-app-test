//
//  ContentView.swift
//  Testla
//
//  Created by Akın Özgen on 24.10.2020.
//

import SwiftUI
import MapKit
import UIKit

struct ContentView: View {
    @Environment(\.openURL) var openURL
    
    var place = "Castle Rock"
    var address = "Castle Rock, US"
    var state = "Colorado."
    var info = "Castle Rock is a butte in the Colorado Piedmont region of the Great Plains. An area landmark, it is the namesake of the town of Castle Rock, Colorado. The butte's caprock consists of rhyolite, rock which is strongly resistant to erosion. About 58 million years ago, a volcanic eruption took place that covered the area around Castle Rock with 20 feet (6.1 m) of rhyolite. \n\nAfter a few million years, mass flooding and erosion of the volcanic rock gave way to the castle-shaped butte visible today. \n\n Public hiking trails on the butte are in Rock Park, at the intersection of Front Street and Canyon Drive in the city of Castle Rock. The trailhead and parking are about two blocks south of the intersection on Front Street, for a 1.4-mile roundtrip hike to the summit of the town's namesake. Other trailheads can be found along Canyon Drive and Sunset Drive."
    @State private var mapHeight = 220;
    
    func openMapForPlace(lat:Float64, lng:Float64, _place: String) {
        let coordinates = CLLocationCoordinate2DMake(lat,lng)
        let regionSpan =   MKCoordinateRegion(center: coordinates, latitudinalMeters: 1000, longitudinalMeters: 1000)
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = _place
        mapItem.openInMaps(launchOptions:[
        MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center)
        ] as [String : Any])
    }
    
    var body: some View {
        VStack {
            MapView()
                .frame(height: CGFloat.init(self.mapHeight))
                .transition(.slide)
                .edgesIgnoringSafeArea(.top)
        
            CircleImage()
                .offset(y: CGFloat(mapHeight - 305))
                .transition(.scale)
                .padding(.bottom, CGFloat(mapHeight - 305))
            
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                
                    VStack(alignment: .leading, spacing: nil) {

                        Text(place)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 5.0, trailing: 0))
                            .font(.headline)
                        
                        HStack {
                            Text(address)
                                .font(.subheadline)
                            Spacer()
                            Text(state)
                                .font(.callout)
                        }.padding(.bottom, 5)
                        
                        Text(info)
                            .font(.body)
                        
                        Link("View full article on WikiPedia", destination: URL(string: "https://en.wikipedia.org/wiki/Castle_Rock_(Colorado)")!)
                        
                        HStack (alignment: .center, spacing: nil) {
                            Spacer()
                            Button("Visit Guide") {
                                openMapForPlace(lat: 39.3736497, lng: -104.91099933, _place: self.place)
                            }
                            .padding()
                            .font(.headline)
                            Spacer()
                        }
                        
                        
                    }.padding()
                        
                }
            }
            Spacer()
        }
        .gesture(DragGesture(minimumDistance: 1, coordinateSpace: .local)
            .onEnded({ value in
                if value.translation.height < 0 {
                    withAnimation {
                        mapHeight = 60;
                    }
                }
                
                if value.translation.height > 0 {
                    withAnimation {
                        mapHeight = 220;
                    }
                }
            }))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
