//
//  OutlineRowView.swift
//  AppleDeveloper
//
//  Created by Apple on 2021/4/30.
//

import Cocoa

class OutlineRowView: NSTableRowView {

    var isParent: Bool! = false

//    override var isEmphasized: Bool {
//        set { }
//        get {
//            return true;
//        }
//    }


    override func drawSelection(in dirtyRect: NSRect) {

//        checkSelectionHighlightStyle()

        if (self.selectionHighlightStyle != .none) && (!isParent) {
            fillColor()
        }

    }

    override func setFrameSize(_ newSize: NSSize) {
        super.setFrameSize(newSize)
        let dict = ["isParent": isParent!]
        let trackingArea = NSTrackingArea(rect: self.bounds, options: [.mouseEnteredAndExited, .activeInKeyWindow], owner: self, userInfo: dict)
        self.addTrackingArea(trackingArea)
    }

//    override func mouseExited(with event: NSEvent) {
//        if isParent {
//            print("mouseExited")
//            NotificationCenter.default.post(name: .mouseExited, object: nil)
//        }
//    }

//    override func mouseEntered(with event: NSEvent) {
//
//        if isParent {
//            print("mouseEntered")
//            NotificationCenter.default.post(name: .mouseEntered, object: nil)
//        }
//
//    }

    func fillColor() {
        let selectionRect = NSInsetRect(self.bounds, 2.5, 2.5)
//            NSColor.init(calibratedWhite: 0.65, alpha: 1).setStroke()
        NSColor(red: 0.81, green: 0.81, blue: 0.81, alpha: 1.00).setFill()

        let selectionPath = NSBezierPath(roundedRect: selectionRect, xRadius: 2.5, yRadius: 2.5)
        selectionPath.fill()
        selectionPath.stroke()
    }

//    func fillClearColor() {
//        let selectionRect = NSInsetRect(self.bounds, 2.5, 2.5)
//            NSColor.init(calibratedWhite: 0.65, alpha: 1).setStroke()
//        NSColor.clear.setFill()
//
//        let selectionPath = NSBezierPath(roundedRect: selectionRect, xRadius: 2.5, yRadius: 2.5)
//        selectionPath.fill()
//        selectionPath.stroke()
//    }

    func checkSelectionHighlightStyle() {
        switch self.selectionHighlightStyle {
        case .none:
            printLog("none")
        case .regular:
            printLog("regular")
        case .sourceList:
            printLog("sourceList")
        default:
            printLog("default")
        }
    }
    
}
