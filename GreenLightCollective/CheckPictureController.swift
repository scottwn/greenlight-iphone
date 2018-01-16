//
//  CheckPictureController.swift
//  GreenLightCollective
//
//  Created by Scott Neagle on 1/10/18.
//  Copyright © 2018 Scott Neagle. All rights reserved.
//

import UIKit

class CheckPictureController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.green
        if pictureExists() {
            print("picture exists")
            // Show credentials.
            perform(#selector(showCredentials), with: nil, afterDelay: 0.01)
        } else {
            print("no picture found")
            // Show login controller.
            perform(#selector(showLogin), with: nil, afterDelay: 0.01)
        }
    }
    
    func pictureExists() -> Bool
    {
        print("checking if \(filePath!) exists")
        return fm.fileExists(atPath: filePath!)
    }
    
    @objc func showLogin()
    {
        let viewController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginController") as UIViewController
        self.present(viewController, animated: false, completion: {
            // We might want to do stuff here.
        })
    }
    
    @objc func showCredentials()
    {
        let viewController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CredentialsController") as UIViewController
        present(viewController, animated: false, completion: {
            // We might want to do stuff here.
        })
    }
}
