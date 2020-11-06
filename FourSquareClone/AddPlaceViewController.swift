//
//  AddPlaceViewController.swift
//  FourSquareClone
//
//  Created by Mahammad Jafarli on 11/6/20.
//  Copyright © 2020 Mahammad Jafarli. All rights reserved.
//

import UIKit

class AddPlaceViewController: UIViewController {
    @IBOutlet weak var placeName: UITextField!
    @IBOutlet weak var placeType: UITextField!
    @IBOutlet weak var placeAtmosphere: UITextField!
    @IBOutlet weak var placeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func nextButton(_ sender: Any) {
        performSegue(withIdentifier: "toMapVC", sender: nil)
    }
    
}
