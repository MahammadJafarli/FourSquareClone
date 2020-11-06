//
//  AddPlaceViewController.swift
//  FourSquareClone
//
//  Created by Mahammad Jafarli on 11/6/20.
//  Copyright © 2020 Mahammad Jafarli. All rights reserved.
//

import UIKit

class AddPlaceViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var placeName: UITextField!
    @IBOutlet weak var placeType: UITextField!
    @IBOutlet weak var placeAtmosphere: UITextField!
    @IBOutlet weak var placeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placeImage.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        placeImage.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func chooseImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        placeImage.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButton(_ sender: Any) {
        
        if placeName.text != "" && placeType.text != "" && placeAtmosphere.text != "" {
            if let choosenImage = placeImage.image{
                let placeModel = PlaceModel.sharedInstance
                placeModel.placeName = placeName.text!
                placeModel.placeType = placeType.text!
                placeModel.placeDesc = placeAtmosphere.text!
                placeModel.placeImage = choosenImage
            }
            performSegue(withIdentifier: "toMapVC", sender: nil)
        }else {
            let alert = UIAlertController(title: "Error", message: "Enter data", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }
    
    }
    
}
