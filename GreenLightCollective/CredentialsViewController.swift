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
  
    override func viewDidLoad() {
        super.viewDidLoad()
    // Set credentials using locally stored data.
        if let photoData = fm.contents(atPath: filePath!), let idData = fm.contents(atPath: idPath!), let nameData = fm.contents(atPath: namePath!) {
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
            try fm.removeItem(atPath: filePath!)
            try fm.removeItem(atPath: idPath!)
            try fm.removeItem(atPath: namePath!)
        } catch _ {
            print("error deleting files")
        }
    }
}
