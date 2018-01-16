//
//  Constants.swift
//  GreenLightCollective
//
//  Created by Scott Neagle on 1/16/18.
//  Copyright © 2018 Scott Neagle. All rights reserved.
//

import Foundation

let filePath = NSURL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("picture.jpg")?.path
let idPath = NSURL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("id.txt")?.path
let namePath = NSURL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("name.txt")?.path
let resourceURL = "https://greenlight-courses.herokuapp.com/resources"
let fm = FileManager.default
