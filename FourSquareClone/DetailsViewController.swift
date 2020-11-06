//
//  DetailsViewController.swift
//  FourSquareClone
//
//  Created by Mahammad Jafarli on 11/6/20.
//  Copyright © 2020 Mahammad Jafarli. All rights reserved.
//

import UIKit
import MapKit
import Parse

class DetailsViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailPlaceName: UILabel!
    @IBOutlet weak var detailPlaceType: UILabel!
    @IBOutlet weak var detailPlaceDesc: UILabel!
    @IBOutlet weak var detailPlaceMap: MKMapView!
    
    var choosenPlaceId = ""
    var choosenLatitude = Double()
    var choosenLongitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailPlaceMap.delegate = self
        getData()
    }
    
    func getData() {
        let query = PFQuery(className: "Places")
        query.whereKey("objectId", equalTo: choosenPlaceId)
        query.findObjectsInBackground { (objects, error) in
            if error != nil {
                
            }else {
                if objects != nil {
                    if objects!.count > 0 {
                        let choosenPlace = objects![0]
                            
                        if let placeName = choosenPlace.object(forKey: "name") as? String {
                            self.detailPlaceName.text = placeName
                        }
                        
                        if let placeType = choosenPlace.object(forKey: "type") as? String {
                            self.detailPlaceType.text = placeType
                        }
                        
                        if let placeDesc = choosenPlace.object(forKey: "description") as? String {
                            self.detailPlaceDesc.text = placeDesc
                        }
                        
                        if let placeLatitude = choosenPlace.object(forKey: "latitude") as? String {
                            if let latitudeDouble = Double(placeLatitude) {
                                self.choosenLatitude = latitudeDouble
                            }
                        }
                        
                        if let placeLongitude = choosenPlace.object(forKey: "longitude") as? String {
                            if let longitudeDouble = Double(placeLongitude) {
                                self.choosenLongitude = longitudeDouble
                            }
                        }
                        
                        if let imageData = choosenPlace.object(forKey: "image") as? PFFileObject {
                            imageData.getDataInBackground { (data, error) in
                                if error == nil {
                                    if data != nil{
                                        self.detailImage.image = UIImage(data: data!)
                                    }
                                }
                            }
                        }
                        
                        let location = CLLocationCoordinate2D(latitude: self.choosenLatitude, longitude: self.choosenLongitude)
                        let span = MKCoordinateSpan(latitudeDelta: 0.055, longitudeDelta: 0.055)
                        let region = MKCoordinateRegion(center: location, span: span)
                        self.detailPlaceMap.setRegion(region, animated: true)
                        
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = location
                        annotation.title = self.detailPlaceName.text
                        annotation.subtitle = self.detailPlaceType.text
                        self.detailPlaceMap.addAnnotation(annotation)
                        
                    }
                }
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = true
            let button = UIButton(type: .detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
        }else {
            pinView?.annotation = annotation
        }
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if self.choosenLongitude != 0.0 && self.choosenLatitude != 0.0 {
            let requestLocation = CLLocation(latitude: self.choosenLatitude, longitude: self.choosenLongitude)
            
            CLGeocoder().reverseGeocodeLocation(requestLocation) { (placeMarks, error) in
                if let placeMark = placeMarks {
                    if placeMark.count > 0 {
                        let mkPlaceMark = MKPlacemark(placemark: placeMark[0])
                        let mapItem = MKMapItem(placemark: mkPlaceMark)
                        mapItem.name = self.detailPlaceName.text
                        
                        let options = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
                        mapItem.openInMaps(launchOptions: options)
                        
                    }
                }
            }
            
        }
    }

}
