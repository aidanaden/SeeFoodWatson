//
//  ViewController.swift
//  SeeFoodv2
//
//  Created by Aidan Aden on 9/8/17.
//  Copyright © 2017 Aidan Aden. All rights reserved.
//

import UIKit
import VisualRecognitionV3
import SVProgressHUD

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let apiKey = "db33a3ab68682c6394e2cfa930cb6497126efe78"
    let version = "2017-08-09"
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let imagePicker = UIImagePickerController()
    
    var classificationResults = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(cameraTapped))
        rightBarButtonItem.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        
        setupViews()
    }
    
    func setupViews() {
        
        self.view.backgroundColor = .white
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = .clear
        
        view.addSubview(imageView)
        
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    @objc func cameraTapped() {
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        SVProgressHUD.show()
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            
            dismiss(animated: true, completion: nil)
            
            imageView.image = image
            
            let imageData = UIImageJPEGRepresentation(image, 0.01)
            
            guard let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
            let fileUrl = documentsUrl.appendingPathComponent("tempImage.jpg")
            
            try? imageData?.write(to: fileUrl, options: [])
    
            let visualRecognition = VisualRecognition(apiKey: apiKey, version: version)
            visualRecognition.classify(imageFile: fileUrl, success: { (classifiedImage) in
                
                if let classes = classifiedImage.images.first?.classifiers.first?.classes {
                    
                    self.classificationResults = []
                    
                    let resultsVC = ResultsController()
                    
                    for index in classes {
                        resultsVC.results.append(index.classification)
                    }
                    
                    DispatchQueue.main.async {
                        self.navigationItem.rightBarButtonItem?.isEnabled = true
                        SVProgressHUD.dismiss()
                        
                        resultsVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                        self.present(resultsVC, animated: true, completion: nil)
                    }
                    
                   
                }
            })
            
        }
        
        
    }
    
    
    
}












