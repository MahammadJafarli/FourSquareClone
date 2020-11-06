//
//  DetailsViewController.swift
//  FourSquareClone
//
//  Created by Mahammad Jafarli on 11/6/20.
//  Copyright © 2020 Mahammad Jafarli. All rights reserved.
//

import UIKit
import MapKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailPlaceName: UILabel!
    @IBOutlet weak var detailPlaceType: UILabel!
    @IBOutlet weak var detailPlaceDesc: UILabel!
    @IBOutlet weak var detailPlaceMap: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
