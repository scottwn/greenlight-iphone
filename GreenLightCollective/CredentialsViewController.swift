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
    var filePath : String!
    var idPath : String!
    var namePath : String!
    var fm : FileManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // This is just ugly copypasta from ViewController.swift. Some day in the future we will do this more elegantly.
        filePath = NSURL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("picture.jpg")?.path
        idPath = NSURL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("id.txt")?.path
        namePath = NSURL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("name.txt")?.path
        fm = FileManager.default
        
        // Set credentials using locally stored data.
        photoImageView.image = UIImage(data: fm.contents(atPath: filePath!)!)
        memberIDLabel.text = String(data: fm.contents(atPath: idPath!)!, encoding: .utf8)
        memberNameLabel.text = String(data: fm.contents(atPath: namePath!)!, encoding: .utf8)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Actions
    @IBAction func logout(_ sender: Any) {
        // Delete credentials.
        do {
            try fm.removeItem(atPath: filePath)
            try fm.removeItem(atPath: idPath)
            try fm.removeItem(atPath: namePath)
        } catch _ {
            print("this is an error")
        }
    }
}
