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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

    //MARK: Actions
    @IBAction func logout(_ sender: Any) {
    }
}
