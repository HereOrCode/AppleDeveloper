//
//  SearchField.swift
//  AppleDeveloper
//
//  Created by Apple on 2021/4/30.
//

import Cocoa

class SearchField: NSSearchField {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func setup() {
        
        self.focusRingType = .none
        
        self.wantsLayer = true
        self.layer?.borderWidth = 3
        self.layer?.cornerRadius = 6
    }

    func onFocusColor() {
        self.layer?.borderColor = NSColor(red: 0.53, green: 0.69, blue: 0.95, alpha: 1.00).cgColor
    }
    
    func onBlurColor() {
        self.layer?.borderColor = NSColor.clear.cgColor
    }
    
    override func mouseDown(with event: NSEvent) {
        onFocusColor()
        super.mouseDown(with: event)
       
    }
    
    override func textDidEndEditing(_ notification: Notification) {
        onBlurColor()
        super.textDidEndEditing(notification)
    }
    
    

}
