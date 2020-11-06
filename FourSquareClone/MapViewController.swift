//
//  MapViewController.swift
//  FourSquareClone
//
//  Created by Mahammad Jafarli on 11/6/20.
//  Copyright © 2020 Mahammad Jafarli. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancelMap))

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveData))
    }
    @objc func cancelMap() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func saveData() {
        
    }

}
