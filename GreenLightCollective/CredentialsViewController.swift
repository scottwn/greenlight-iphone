//
//  CredentialsViewController.swift
//  GreenLightCollective
//
//  Created by Scott Neagle on 1/7/18.
//  Copyright © 2018 Scott Neagle. All rights reserved.
//

import UIKit

class CredentialsViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var memberNameLabel: UILabel!
    @IBOutlet weak var memberIDLabel: UILabel!
    let resource = AppResources()
  
    override func viewDidLoad() {
        super.viewDidLoad()
    // Set credentials using locally stored data.
        if let photoData = resource.fm.contents(atPath: resource.filePath), let idData = resource.fm.contents(atPath: resource.idPath), let nameData = resource.fm.contents(atPath: resource.namePath) {
            photoImageView.image = UIImage(data: photoData)
            memberIDLabel.text = String(data: idData, encoding: .utf8)
            memberNameLabel.text = String(data: nameData, encoding: .utf8)
        } else {
            print("problem loading credentials")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Actions
    @IBAction func logout(_ sender: Any) {
        // Delete credentials.
        do {
            try resource.fm.removeItem(atPath: resource.filePath)
            try resource.fm.removeItem(atPath: resource.filePath)
            try resource.fm.removeItem(atPath: resource.filePath)
        } catch _ {
            print("error deleting files")
        }
    }
}
