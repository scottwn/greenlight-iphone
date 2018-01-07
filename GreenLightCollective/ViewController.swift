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

    //MARK: Actions
    @IBAction func signUp(_ sender: UIButton) {
        UIApplication.shared.open((URL(string: "https://greenlight-courses.herokuapp.com")!), options: [:], completionHandler: nil)
    }
    
    @IBAction func login(_ sender: UIButton) {
        print("making Alamofire request with email \(emailText.text) and id \(idText.text)")
        Alamofire.request("https://greenlight-courses.herokuapp.com/resources", method: .get, parameters: ["email" : emailText.text ?? "", "id" : idText.text ?? ""]).response { response in
            print("Request: \(response.request)")
            print("Response: \(response.response)")
            print("Error: \(response.error)")
            
            if response.response?.allHeaderFields["Content-Type"] as! String == "image/jpeg" {
                print("picture exists")
            } else if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                if data.count == 0 {
                    print("null response")
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

