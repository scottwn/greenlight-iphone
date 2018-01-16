//
//  AppResources.swift
//  GreenLightCollective
//
//  Created by Scott Neagle on 1/16/18.
//  Copyright © 2018 Scott Neagle. All rights reserved.
//

import Foundation

struct AppResources {
    let fm: FileManager
    let filePath, idPath, namePath: String
    
    init() {
        fm = FileManager.default
        if let resourceDirectory = fm.urls(for: .applicationSupportDirectory, in: .userDomainMask).first {
            if !fm.fileExists(atPath: resourceDirectory.path) {
                print("creating \(resourceDirectory)")
                do {
                    try fm.createDirectory(at: resourceDirectory, withIntermediateDirectories: true)
                } catch {
                    print("problem creating application support directory")
                }
            }
            filePath = resourceDirectory.appendingPathComponent("picture.jpg").path
            idPath = resourceDirectory.appendingPathComponent("id.txt").path
            namePath = resourceDirectory.appendingPathComponent("name.txt").path
        } else {
            print("problem getting directory from urls; using home directory")
            filePath = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("picture.jpg").path
            idPath = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("id.txt").path
            namePath = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("name.txt").path
        }
    }
}
