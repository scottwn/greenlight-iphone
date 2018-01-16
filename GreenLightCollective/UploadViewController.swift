//
//  UploadViewController.swift
//  GreenLightCollective
//
//  Created by Scott Neagle on 1/16/18.
//  Copyright © 2018 Scott Neagle. All rights reserved.
//

import UIKit
import Alamofire

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: Properties
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        //Save selectedImage as picture.jpg and upload to database.
        if let imageJPG = UIImageJPEGRepresentation(selectedImage, 0.5) {
            fm.createFile(atPath: filePath!, contents: imageJPG)
            Alamofire.upload(
                multipartFormData: { multipartFormData in
                    multipartFormData.append(fm.contents(atPath: idPath!)!, withName: "id")
                    multipartFormData.append(imageJPG, withName: "picture")
            },
            to: resourceURL,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    print(upload.response!)
                case .failure(let encodingError):
                    print(encodingError)
                }
            })
        } else {
            print("JPG representation error")
        }
        self.performSegue(withIdentifier: "credentialsSegue", sender: self)
    }
    
    //MARK: Actions
    
    @IBAction func selectImage(_ sender: UITapGestureRecognizer) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .camera
        imagePickerController.cameraDevice = .front
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
        //Maybe do something to make the picture a square.
    }
    
}
