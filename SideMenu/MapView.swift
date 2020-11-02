//
//  MapView.swift
//  SideMenu
//
//  Created by Pat Murphy on 11/2/20.
//

import SwiftUI
import MapKit

struct MapView : UIViewRepresentable {
    
    @ObservedObject var menuState : MenuState

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        @objc func menuPressed(_ sender: UIButton) {
            DispatchQueue.main.async {
                self.parent.menuState.setMenuPosition(position:MenuPosition.right)
            }
        }
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        let button = UIButton(frame: CGRect(x:50, y:15, width:50.0, height:50.0))
        button.setTitle("Hello", for: .normal)
        button.setImage(UIImage(systemName:"line.horizontal.3")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = UIColor.white
        button.addTarget(context.coordinator, action: #selector(context.coordinator.menuPressed(_:)), for: .touchUpInside)
        mapView.addSubview(button)
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        let coordinate = CLLocationCoordinate2D(
            latitude: 37.269560, longitude: -121.867020)
        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)
    }
    
}
