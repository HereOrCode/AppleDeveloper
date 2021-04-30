//
//  OutlineItemView.swift
//  AppleDeveloper
//
//  Created by Apple on 2021/4/30.
//

import Cocoa

class OutlineItemView: NSTableCellView {

    
    @IBOutlet weak var icon: NSImageView!
    
    @IBOutlet weak var label: NSTextField!
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}
