//
//  SidebarOutlineView.swift
//  AppleDeveloper
//
//  Created by Apple on 2021/4/30.
//

import Cocoa

class SidebarOutlineView: NSOutlineView {
    
    override var indentationPerLevel: CGFloat {
        set{}
        get{
            return 0
        }
    }

//    override func draw(_ dirtyRect: NSRect) {
//        super.draw(dirtyRect)
//
//        // Drawing code here.
//    }

    override func makeView(withIdentifier identifier: NSUserInterfaceItemIdentifier, owner: Any?) -> NSView? {

        let view = super.makeView(withIdentifier: identifier, owner: owner)

        if identifier == NSOutlineView.disclosureButtonIdentifier {
            if let button = view as? NSButton {
                button.image?.isTemplate = false
                button.alternateImage?.isTemplate = false
            }
        }

        return view
    }

//    override func didAddSubview(_ subview: NSView) {
//        print("type view: ", type(of: subview))
//    }


//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(getNotificationMouseExited), name: .mouseExited, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(getNotificationMouseEntered), name: .mouseEntered, object: nil)
//    }

//    @objc func getNotificationMouseExited() {
//        let items = getViewWithIdentifier(NSOutlineView.disclosureButtonIdentifier)
//
//        if items.count > 0 {
//            for view in items {
//                let button = view as! NSButton
//                button.isHidden = true
//            }
//        }
//    }

//    @objc func getNotificationMouseEntered() {
//
//        let items = getViewWithIdentifier(NSOutlineView.disclosureButtonIdentifier)
//
//        if items.count > 0 {
//            for view in items {
//                let button = view as! NSButton
//                button.isHidden = false
//            }
//        }
//    }



    // Modify the origin of the disclosureButton
    override func layout() {
        
        let items = getViewWithIdentifier(NSOutlineView.disclosureButtonIdentifier)

        if items.count > 0 {

            for view in items {
                let button = view as! NSButton

                button.image?.isTemplate = false
                button.alternateImage?.isTemplate = false

                let frameWidth = self.frame.size.width
                let x = frameWidth - button.frame.size.width
                let y = button.frame.origin.y

                button.setFrameOrigin(NSMakePoint(x, y))
            }
        }
        
    }

    private func getViewWithIdentifier(_ identifier: NSUserInterfaceItemIdentifier) -> NSArray {
        let viewsArray = NSMutableArray()
        for view in self.subviews {
            for subView in view.subviews {
                if subView.identifier == identifier {
                    viewsArray.add(subView)
                }
            }
        }

        return viewsArray
    }

//    override var acceptsFirstResponder: Bool {
//        set { }
//        get {
//            return false
//        }
//    }

}
