//
//  SidebarViewController.swift
//  AppleDeveloper
//
//  Created by Apple on 2021/4/30.
//

import Cocoa

class SidebarViewController: NSViewController, NSSearchFieldDelegate {


    @IBOutlet weak var outlineView: SidebarOutlineView!

    let topLevelItems = ["Developer", "Browse", "Featured", "Frameworks"]
    let childrenDictionary = [
        "Developer": [
            [
                "icon": "safari",
                "name": "Discover"
            ],
            [
                "icon": "iphone.homebutton",
                "name": "WWDC"
            ]
        ],
        "Browse": [
            [
                "icon": "newspaper",
                "name": "News"
            ],
            [
                "icon": "bookmark",
                "name": "Bookmarks"
            ],
            [
                "icon": "arrow.down.circle",
                "name": "Downloaded"
            ],
            [
                "icon": "play.circle",
                "name": "Continue Watching"
            ]
        ],
        "Featured": [
            [
                "icon": "star.circle",
                "name": "Special Events"
            ]
        ],
        "Frameworks": [
            [
                "icon": "icloud.fill",
                "name": "Cloud and Local Storage"
            ],
            [
                "icon": "wifi",
                "name": "Networking"
            ],
            [
                "icon": "switch.2",
                "name": "Ul Frameworks"
            ]
        ]
    ]

    let OutlineHeaderIdentifier = "OutlineHeaderView"
    let OutlineItemIdentifier = "OutlineItemView"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.

        setup()
    }


    func setup() {
        
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.clear.cgColor

        // custom tableViewCell
        registerNib(nibNamed: "OutlineHeaderView")
        registerNib(nibNamed: "OutlineItemView")

        outlineView.backgroundColor = NSColor.clear

        outlineView.delegate = self
        outlineView.dataSource = self
        outlineView.target = self
        outlineView.action = #selector(outlineViewClicked(_:))

        outlineView.sizeLastColumnToFit()
        outlineView.reloadData()
        outlineView.floatsGroupRows = true
        outlineView.rowSizeStyle = .custom


        NSAnimationContext.beginGrouping()
        NSAnimationContext.current.duration = 0
        outlineView.expandItem(nil, expandChildren: true)
        NSAnimationContext.endGrouping()

    }

    private func registerNib(nibNamed: String) {
        let nib = NSNib(nibNamed: nibNamed, bundle: nil)
        outlineView.register(nib, forIdentifier: NSUserInterfaceItemIdentifier(nibNamed))
    }

    @objc private func outlineViewClicked(_ sender: NSOutlineView) {
        expandOrCollapseRow(outlineView: sender)

//        clickOutlineViewItem(outlineView: sender)
    }

    private func clickOutlineViewItem(outlineView: NSOutlineView) {

        if let clickedItem = outlineView.item(atRow: outlineView.clickedRow) {

            if (outlineView.parent(forItem: clickedItem) != nil) {
                printLog("child")
            } else {
                printLog("folder")
            }
        }
    }

    private func expandOrCollapseRow(outlineView: NSOutlineView) {

        if let clickedItem = outlineView.item(atRow: outlineView.clickedRow) {
            if outlineView.isItemExpanded(clickedItem) {
                outlineView.animator().collapseItem(clickedItem)
            } else {
                outlineView.animator().expandItem(clickedItem, expandChildren: true)
            }

            if (outlineView.parent(forItem: clickedItem) != nil) {
                print("child")
            } else {
                print("folder")
            }
        }
    }
}

extension SidebarViewController: NSOutlineViewDelegate, NSOutlineViewDataSource {

    /*
     *Must implement
     *outlineView:numberOfChildrenOfItem:
     *outlineView:isItemExpandable:
     *outlineView:child:ofItem:
     *outlineView:objectValueForTableColumn:byItem:
     */
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
  
        if item == nil {
            return topLevelItems.count
        } else {
            return childrenDictionary[item as! String]?.count ?? 0
        }
    }

    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        
        if item == nil {
            return topLevelItems[index]
        }
        
        return childrenDictionary[item as! String]![index] as Dictionary<String, String>
    }

    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {

        if (outlineView.parent(forItem: item) == nil) {
            return true
        }
        return false
    }

    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {

        if outlineView.parent(forItem: item) == nil {
            let item = item as! String
            let outlineHeaderView = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier.init(OutlineHeaderIdentifier), owner: self) as! OutlineHeaderView

            outlineHeaderView.headerLabel.textColor = NSColor(red: 0.68, green: 0.69, blue: 0.69, alpha: 1.00)
            outlineHeaderView.headerLabel.font = NSFont.systemFont(ofSize: 11)
            outlineHeaderView.headerLabel.stringValue = (item as NSString).localizedUppercase


            return outlineHeaderView
        } else {
            let item = item as! Dictionary<String, String>
            let outlineItemView = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier.init(OutlineItemIdentifier), owner: self) as! OutlineItemView

            outlineItemView.label.textColor = NSColor(red: 0.53, green: 0.53, blue: 0.53, alpha: 1.00)
            outlineItemView.label.font = NSFont.systemFont(ofSize: 13)
            outlineItemView.label.stringValue = item["name"] ?? "Apple"
            
            let image: NSImage!

            if #available(macOS 11.0, *) {
                image = NSImage(systemSymbolName: item["icon"] ?? "applelogo", accessibilityDescription: nil)!
            } else {
                image = NSImage(named: "apple")
            }
            
            outlineItemView.icon.image = image.tint(color: NSColor(red: 0.00, green: 0.51, blue: 1.00, alpha: 1.00))


            return outlineItemView
        }
        
//        if topLevelItems.contains(item) {
//            let item = item as! String
//            let outlineHeaderView = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier.init(OutlineHeaderIdentifier), owner: self) as! OutlineHeaderView
//
//            outlineHeaderView.headerLabel.textColor = NSColor(red: 0.68, green: 0.69, blue: 0.69, alpha: 1.00)
//            outlineHeaderView.headerLabel.font = NSFont.systemFont(ofSize: 11)
//            outlineHeaderView.headerLabel.stringValue = (item as NSString).localizedUppercase
//
//
//            return outlineHeaderView
//
//        } else {
//            let item = item as! Dictionary<String, String>
//            let outlineItemView = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier.init(OutlineItemIdentifier), owner: self) as! OutlineItemView
//
//            outlineItemView.label.textColor = NSColor(red: 0.53, green: 0.53, blue: 0.53, alpha: 1.00)
//            outlineItemView.label.font = NSFont.systemFont(ofSize: 13)
//            outlineItemView.label.stringValue = item["name"] ?? "Apple"
//
//            let parent = outlineView.parent(forItem: item)
//            let index = (topLevelItems as NSArray).index(of: parent as! String)
//            let iconOffset = index % 4
//            let image: NSImage = NSImage(systemSymbolName: item["icon"] ?? "applelogo", accessibilityDescription: nil)!
//
//
////            image.isTemplate = false
//
//            outlineItemView.icon.image = image.tint(color: NSColor(red: 0.00, green: 0.51, blue: 1.00, alpha: 1.00))
//
//
//            return outlineItemView
//        }


    }

    func outlineView(_ outlineView: NSOutlineView, heightOfRowByItem item: Any) -> CGFloat {

        if outlineView.parent(forItem: item) != nil {
            return 33
        } else {
            return 30
        }
    }

    func outlineView(_ outlineView: NSOutlineView, shouldShowOutlineCellForItem item: Any) -> Bool {
//        let item = item as! NSString
//
//        if item.isEqual(to: "Favorites") {
//            return false
//        } else {
//            return true
//        }

        return true
    }

    func outlineView(_ outlineView: NSOutlineView, rowViewForItem item: Any) -> NSTableRowView? {

        let rowView = OutlineRowView()

        if outlineView.parent(forItem: item) != nil {
            rowView.isParent = false
        } else {
            rowView.isParent = true
        }

        return rowView
    }
}
