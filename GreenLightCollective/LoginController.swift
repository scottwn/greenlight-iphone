//
//  ViewController.swift
//  GreenLightCollective
//
//  Created by Scott Neagle on 12/31/17.
//  Copyright © 2017 Scott Neagle. All rights reserved.
//

import UIKit
import Alamofire

class LoginController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var idText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    let resource = AppResources()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayCredentials(segue: String) {
        let idData = self.idText.text?.data(using: .utf8)
        resource.fm.createFile(atPath: resource.idPath, contents: idData)
        Alamofire.request(resourceURL, method: .get, parameters: ["email" : emailText.text ?? "", "id" : idText.text ?? "", "resource-type" : "name"]).response { response in
            self.resource.fm.createFile(atPath: self.resource.namePath, contents: response.data)
            self.performSegue(withIdentifier: segue, sender: self)
        }
    }

    //MARK: Actions
    @IBAction func signUp(_ sender: UIButton) {
        UIApplication.shared.open((URL(string: "https://greenlight-courses.herokuapp.com/signup")!), options: [:], completionHandler: nil)
    }
    
    @IBAction func login(_ sender: UIButton) {
        if let emailString = emailText.text, let idString = idText.text {
            print("making Alamofire request with email \(emailString) and id \(idString)")
        }
        Alamofire.request(resourceURL, method: .get, parameters: ["email" : emailText.text ?? "", "id" : idText.text ?? "", "resource-type" : "picture"]).response { response in
            
            if let requestString = response.request, let responseString = response.response, let errorString = response.error {
                print("Request: \(requestString)")
                print("Response: \(responseString)")
                print("Error: \(errorString)")
            }
            
            if response.response?.allHeaderFields["Content-Type"] as! String == "image/jpeg" {
                print("picture exists")
                if let dataSize = response.data?.count {
                    print("response contains \(dataSize) bytes")
                }
                print("creating file at \(self.resource.filePath)")
                self.resource.fm.createFile(atPath: self.resource.filePath, contents: response.data)
                self.displayCredentials(segue: "loginSegue")
            } else if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                if data.count == 0 {
                    print("null response")
                    // Prompt user to upload picture
                    self.displayCredentials(segue: "uploadSegue")
                } else {
                    // Send user an alert.
                    let alert = UIAlertController(title: "Login Problem", message: utf8Text, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in NSLog("The \"OK\" alert occured.")}))
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                print("unknown response")
            }
        }
    }
}

