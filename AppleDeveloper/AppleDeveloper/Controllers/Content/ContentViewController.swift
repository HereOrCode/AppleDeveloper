//
//  ContentViewController.swift
//  AppleDeveloper
//
//  Created by Apple on 2021/4/30.
//

import Cocoa

class ContentViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.white.cgColor
    }
    
}
