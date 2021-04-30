//
//  OutlineHeaderView.swift
//  AppleDeveloper
//
//  Created by Apple on 2021/4/30.
//

import Cocoa

class OutlineHeaderView: NSTableCellView {
    

    @IBOutlet weak var headerLabel: NSTextField!
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
}
