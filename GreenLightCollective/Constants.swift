//
//  Constants.swift
//  GreenLightCollective
//
//  Created by Scott Neagle on 1/16/18.
//  Copyright © 2018 Scott Neagle. All rights reserved.
//

import Foundation

let fm = FileManager.default
let filePath = fm.urls(for: .applicationSupportDirectory, in: .userDomainMask).first?.appendingPathComponent("picture.jpg").path
let idPath = fm.urls(for: .applicationSupportDirectory, in: .userDomainMask).first?.appendingPathComponent("id.txt").path
let namePath = fm.urls(for: .applicationSupportDirectory, in: .userDomainMask).first?.appendingPathComponent("name.txt").path
let resourceURL = "https://greenlight-courses.herokuapp.com/resources"
