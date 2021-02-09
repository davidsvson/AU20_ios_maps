//
//  ContentView.swift
//  MapsLesson
//
//  Created by David Svensson on 2021-02-09.
//

import SwiftUI
import MapKit

struct ContentView: View {
    let locationManager = LocationManager()
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.33233141, longitude: -122.0312186), span: MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04))
    
    @State private var places = [
        Place(name: "Neighbour", latitude: 37.33233141, longitude: -122.032),
        Place(name: "Nice place", latitude: 37.33233141, longitude: -122.030),
        Place(name: "Food", latitude: 37.33233141, longitude: -122.029)
    ]
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $region, annotationItems: places) { place in
               // MapPin(coordinate: place.coordinate)
               // MapMarker(coordinate: place.coordinate)
                MapAnnotation(coordinate: place.coordinate, anchorPoint: CGPoint(x: 0.5, y: 0.5)) {
                    Image(systemName: "bolt.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
            }
            Button(action: {
                zoomMap()
            }, label: {
                Text("Zoom")
            })
            Button(action: {
                addPin()
            }, label: {
                Text("Add pin")
            })
            Button(action: {
                locationManager.askForPermission()
            }, label: {
                Text("permission")
            })
        }
    }

    func zoomMap() {
        region.span = MKCoordinateSpan(latitudeDelta: region.span.latitudeDelta * 0.9,
                                       longitudeDelta: region.span.longitudeDelta * 0.9)
    }
    
    func addPin() {
      //  let newPlace = Place(name: "bike", latitude: 37.33233141, longitude: -122.0312186)
        if let location = locationManager.location {
            let newPlace = Place(name: "here", latitude: location.latitude, longitude: location.longitude)
            places.append(newPlace)
        }
    }
    
    
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
