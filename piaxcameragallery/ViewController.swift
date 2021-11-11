//
//  ViewController.swift
//  piaxcameragallery
//
//  Created by Bill Martensson on 2021-11-11.
//

import UIKit
import PhotosUI

class ViewController: UIViewController, UIImagePickerControllerDelegate, PHPickerViewControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var theimageview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func letDoCamera(_ sender: Any) {
        
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
    
    @IBAction func letsDoGallery(_ sender: Any) {
        
        /*
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
        */
        
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 3
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }

        // print out the image size as a test
        print(image.size)
        
        theimageview.image = image
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("AVBRÖT VÄLJA BILD")
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        let itemProviders = results.map(\.itemProvider)
        for item in itemProviders {
            if item.canLoadObject(ofClass: UIImage.self) {
                item.loadObject(ofClass: UIImage.self) { (image, error) in
                    DispatchQueue.main.async {
                        if let image = image as? UIImage {
                            self.theimageview.image = nil
                            self.theimageview.image = image
                        }
                    }
                }
            }
        }
    }
    
}

