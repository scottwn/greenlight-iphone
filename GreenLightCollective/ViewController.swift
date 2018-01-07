//
//  ViewController.swift
//  GreenLightCollective
//
//  Created by Scott Neagle on 12/31/17.
//  Copyright © 2017 Scott Neagle. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var idText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayCredentials() {
        Alamofire.request("https://greenlight-courses.herokuapp.com/resources", method: .get, parameters: ["email" : emailText.text ?? "", "id" : idText.text ?? "", "resource-type" : "name"]).response { response in
            let namePath = NSURL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("name.txt")?.path
            let fm = FileManager.default
            fm.createFile(atPath: namePath!, contents: response.data)
            self.performSegue(withIdentifier: "loginSegue", sender: self)
        }
    }

    //MARK: Actions
    @IBAction func signUp(_ sender: UIButton) {
        UIApplication.shared.open((URL(string: "https://greenlight-courses.herokuapp.com")!), options: [:], completionHandler: nil)
    }
    
    @IBAction func login(_ sender: UIButton) {
        if let emailString = emailText.text, let idString = idText.text {
            print("making Alamofire request with email \(emailString) and id \(idString)")
        }
        Alamofire.request("https://greenlight-courses.herokuapp.com/resources", method: .get, parameters: ["email" : emailText.text ?? "", "id" : idText.text ?? "", "resource-type" : "picture"]).response { response in
            
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
                let filePath = NSURL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("picture.jpg")?.path
                let idPath = NSURL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("id.txt")?.path
                let fm = FileManager.default
                let idData = self.idText.text?.data(using: .utf8)
                print("creating file at \(filePath!)")
                fm.createFile(atPath: filePath!, contents: response.data)
                fm.createFile(atPath: idPath!, contents: idData)
                self.displayCredentials()
            } else if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                if data.count == 0 {
                    print("null response")
                    // Prompt user to upload picture
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

