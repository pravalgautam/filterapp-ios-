//
//  ViewController.swift
//  FILTERAPP
//
//  Created by Praval Gautam on 19/03/23.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    let context = CIContext()
    var original : UIImage?
    @IBOutlet var imageView : UIImageView!
  
    @IBAction func chooseButton() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            navigationController?.present(picker, animated: true)
            
        }
    }
    @IBAction func applySepia(){
        guard let original = original else{
            return
        }
     let filter = CIFilter(name: "CISepiaTone")
        filter?.setValue(0.5, forKey: kCIInputIntensityKey)
        filter?.setValue(CIImage(image: original), forKey: kCIInputImageKey)
        let output =  filter?.outputImage
        imageView.image = UIImage(cgImage: self.context.createCGImage(output! , from: output!.extent)!)
    }
    
    @IBAction func applyNoir(){
        guard let original = original else{
            return
        }
     let filter = CIFilter(name: "CIPhotoEffectNoir")

     display(filter: filter!)
        
    }
    @IBAction func applyVintage(){
        guard let original = original else{
            return
        }
     let filter = CIFilter(name:"CIPhotoEffectProcess" )
     display(filter: filter!)
        
    }
    func display(filter: CIFilter){
        filter.setValue(CIImage(image: original!), forKey: kCIInputImageKey)
        let output =  filter.outputImage
        imageView.image = UIImage(cgImage: self.context.createCGImage(output! , from: output!.extent)!)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        navigationController?.dismiss(animated: true)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as?
            UIImage{
            
            imageView.image = image
            original = image
        }
    }

}

