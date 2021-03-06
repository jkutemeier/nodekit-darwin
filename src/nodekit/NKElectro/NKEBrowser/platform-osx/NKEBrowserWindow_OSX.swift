/*
* nodekit.io
*
* Copyright (c) 2016 OffGrid Networks. All Rights Reserved.
* Portions Copyright (c) 2013 GitHub, Inc. under MIT License
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*      http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

#if os(OSX)
    
import Foundation

import Cocoa

extension NKE_BrowserWindow {

    internal func createWindow(options: Dictionary<String, AnyObject>) -> AnyObject {

        let isTaskBarPopup = (options[NKEBrowserOptions.kTaskBarPopup] as? Bool) ?? false ;
        
        let TaskBarIcon = (options[NKEBrowserOptions.kTaskBarIcon] as? String) ?? "" ;
        
        if !isTaskBarPopup {
        
            let width: CGFloat = CGFloat((options[NKEBrowserOptions.kWidth] as? Int) ?? NKEBrowserDefaults.kWidth)
            
            let height: CGFloat = CGFloat((options[NKEBrowserOptions.kHeight] as? Int) ?? NKEBrowserDefaults.kHeight)
            
            let title: String = (options[NKEBrowserOptions.kTitle] as? String) ?? NKEBrowserDefaults.kTitle
            
            let windowRect: NSRect = (NSScreen.mainScreen()!).frame
            
            let frameRect: NSRect = NSMakeRect(
                (NSWidth(windowRect) - width)/2,
                (NSHeight(windowRect) - height)/2,
                width, height)
            
            let window = NSWindow(contentRect: frameRect, styleMask: NSTitledWindowMask | NSClosableWindowMask | NSResizableWindowMask, backing: NSBackingStoreType.Buffered, defer: false, screen: NSScreen.mainScreen())
            
            objc_setAssociatedObject(self, unsafeAddressOf(NSWindow), window, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            window.title = title
            
            window.makeKeyAndOrderFront(nil)
            
            return window
            
        } else
        
        {
            let window = NSPopover()
        
            window.contentViewController = NSViewController()
            
            objc_setAssociatedObject(self, unsafeAddressOf(NSWindow), window, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            let nke_popover = NKE_Popover(Popover: window, imageName: TaskBarIcon)
            
            objc_setAssociatedObject(self, unsafeAddressOf(NKE_Popover), nke_popover, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            return window
        }
        
    }
    
}

extension NKE_BrowserWindow: NKE_BrowserWindowProtocol {
   
    func destroy() -> Void { NotImplemented(); }
    
    func close() -> Void {
    
        guard let window = self._window as? NSWindow else {return;}
        
        window.close()
        
        self._window = nil
        
        NKE_BrowserWindow._windowArray[self._id] = nil
        
        _context = nil
        
        _webView = nil
    
    }

   
    func focus() -> Void { NotImplemented(); }
    
    func isFocused() -> Bool { NotImplemented(); return false; }
    
    func show() -> Void { NotImplemented(); }
    
    func showInactive() -> Void { NotImplemented(); }
    
    func hide() -> Void { NotImplemented(); }
    
    func isVisible() -> Bool { NotImplemented(); return true; }
    
    func maximize() -> Void { NotImplemented(); }
    
    func unmaximize() -> Void { NotImplemented(); }
    
    func isMaximized() -> Bool { NotImplemented(); return false; }
    
    func minimize() -> Void { NotImplemented(); }
    
    func isMinimized() -> Bool { NotImplemented(); return false; }
    
    func setFullScreen(flag: Bool) -> Void { NotImplemented(); }
    
    func isFullScreen() -> Bool { NotImplemented(); return false; }
    
    func setAspectRatio(aspectRatio: NSNumber, extraSize: [Int]) -> Void { NotImplemented(); } //OS X
    
    func setBounds(options: [NSObject : AnyObject]!) -> Void { NotImplemented(); }
    
    func getBounds() -> [NSObject : AnyObject]! { NotImplemented(); return [NSObject : AnyObject](); }
    
    func setSize(width: Int, height: Int) -> Void { NotImplemented(); }
    
    func getSize() -> [NSObject : AnyObject]! { NotImplemented(); return [NSObject : AnyObject](); }
    
    func setContentSize(width: Int, height: Int) -> Void { NotImplemented(); }
    
    func getContentSize() -> [Int] { NotImplemented(); return [Int](); }
    
    func setMinimumSize(width: Int, height: Int) -> Void { NotImplemented(); }
    
    func getMinimumSize() -> [Int] { NotImplemented(); return [Int](); }
    
    func setMaximumSize(width: Int, height: Int) -> Void { NotImplemented(); }
    
    func getMaximumSize() -> [Int] { NotImplemented(); return [Int](); }
    
    func setResizable(resizable: Bool) -> Void { NotImplemented(); }
    
    func isResizable() -> Bool { NotImplemented(); return false; }
    
    func setAlwaysOnTop(flag: Bool) -> Void { NotImplemented(); }
    
    func isAlwaysOnTop() -> Bool { NotImplemented(); return false; }
    
    func center() -> Void { NotImplemented(); }
    
    func setPosition(x: Int, y: Int) -> Void { NotImplemented(); }
    
    func getPosition() -> [Int] { NotImplemented(); return [Int]() }
    
    func setTitle(title: String) -> Void { NotImplemented(); }
    
    func getTitle() -> Void { NotImplemented(); }
    
    func flashFrame(flag: Bool) -> Void { NotImplemented(); }
    
    func setSkipTaskbar(skip: Bool) -> Void { NotImplemented(); }
    
    func setKiosk(flag: Bool) -> Void { NotImplemented(); }
    
    func isKiosk() -> Bool { NotImplemented(); return false; }
    
    // func hookWindowMessage(message: Int,callback: AnyObject) -> Void //WINDOWS
    
    // func isWindowMessageHooked(message: Int) -> Void //WINDOWS
    
    // func unhookWindowMessage(message: Int) -> Void //WINDOWS
    
    // func unhookAllWindowMessages() -> Void //WINDOWS
    
    func setRepresentedFilename(filename: String) -> Void { NotImplemented(); } //OS X
    
    func getRepresentedFilename() -> String { NotImplemented(); return "" } //OS X
    
    func setDocumentEdited(edited: Bool) -> Void { NotImplemented(); } //OS X
    
    func isDocumentEdited() -> Bool { NotImplemented(); return false; } //OS X
    
    func focusOnWebView() -> Void { NotImplemented(); }
    
    func blurWebView() -> Void { NotImplemented(); }
    
    func capturePage(rect: [NSObject : AnyObject]!, callback: AnyObject) -> Void { NotImplemented(); }
    
    func print(options: [NSObject : AnyObject]) -> Void { NotImplemented(); }
    
    func printToPDF(options: [NSObject : AnyObject], callback: AnyObject) -> Void { NotImplemented(); }
    
    func loadURL(url: String, options: [NSObject : AnyObject]) -> Void { NotImplemented(); }
    
    func reload() -> Void { NotImplemented(); }
    
    // func setMenu(menu) -> Void //LINUX WINDOWS
    
    func setProgressBar(progress: Double) -> Void { NotImplemented(); }
    
    // func setOverlayIcon(overlay, description) -> Void //WINDOWS 7+
    
    // func setThumbarButtons(buttons) -> Void //WINDOWS 7+
    
    func showDefinitionForSelection() -> Void { NotImplemented(); } //OS X
    
    func setAutoHideMenuBar(hide: Bool) -> Void { NotImplemented(); }
    
    func isMenuBarAutoHide() -> Bool { NotImplemented(); return false;  }
    
    func setMenuBarVisibility(visible: Bool) -> Void { NotImplemented(); }
    
    func isMenuBarVisible() -> Bool { NotImplemented(); return false; }
    
    func setVisibleOnAllWorkspaces(visible: Bool) -> Void { NotImplemented(); }
    
    func isVisibleOnAllWorkspaces() -> Bool { NotImplemented(); return false; }
    
    func setIgnoreMouseEvents(ignore: Bool) -> Void { NotImplemented(); } //OS X

    private static func NotImplemented() -> Void {

        NSException(name: "NotImplemented", reason: "This function is not implemented", userInfo: nil).raise()
    
    }
    
    private func NotImplemented() -> Void {
   
        NSException(name: "NotImplemented", reason: "This function is not implemented", userInfo: nil).raise()
    
    }

}

class NKE_Popover : NSObject {
    
    let statusItem: NSStatusItem
  
    let popover: NSPopover
    
    var popoverMonitor: AnyObject?
    
    init( Popover: NSPopover, imageName: String) {
    
        popover = Popover
        
        statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSSquareStatusItemLength)
        
        super.init()
        
        setupStatusButton(imageName)
    
    }
    
    func setupStatusButton(imageName: String) {
    
        if let statusButton = statusItem.button {
            
            let mainBundle: NSBundle = NSBundle.mainBundle()
        
            guard let image: NSImage = mainBundle.imageForResource(imageName) else { return }
            
            statusButton.image = image
            
            statusButton.target = self
            
            statusButton.action = #selector(NKE_Popover.onPress(_:))
            
            statusButton.sendActionOn(Int((NSEventMask.RightMouseDownMask).rawValue))
         
            let dummyControl = DummyControl()
            
            dummyControl.frame = statusButton.bounds
            
            statusButton.addSubview(dummyControl)
            
            statusButton.superview!.subviews = [statusButton, dummyControl]
            
            dummyControl.action = #selector(NKE_Popover.onPress(_:))
            
            dummyControl.target = self
        
        }
    
    }
    
    func quitApp(sender: AnyObject) {
    
        NSApplication.sharedApplication().terminate(self)
    
    }
    
    func onPress(sender: AnyObject) {
    
        let event:NSEvent! = NSApp.currentEvent!
        
        if (event.type == NSEventType.RightMouseDown) {
        
            let menu = NSMenu()
            
            let quitMenuItem = NSMenuItem(title:"Quit", action:#selector(NKE_Popover.quitApp(_:)), keyEquivalent:"")
            
            quitMenuItem.target = self
           
            menu.addItem(quitMenuItem)
            
            statusItem.popUpStatusItemMenu(menu)
        
        }
        
        else{
            
            if popover.shown == false {
        
                openPopover()
            
            } else {
            
                closePopover()
            
            }
            
        
        }
    
    }
    
    func openPopover() {
        
        if let statusButton = statusItem.button {
       
            statusButton.highlight(true)
            
            popover.showRelativeToRect(NSZeroRect, ofView: statusButton, preferredEdge: NSRectEdge.MinY)
            
            popoverMonitor = NSEvent.addGlobalMonitorForEventsMatchingMask(.LeftMouseDownMask, handler: {
                
                (event: NSEvent) -> Void in
                
                self.closePopover()
           
            })
        
        }
    
    }
    
    func closePopover() {
    
        popover.close()
        
        if let statusButton = statusItem.button {
        
            statusButton.highlight(false)
        
        }
        
        if let monitor : AnyObject = popoverMonitor {
        
            NSEvent.removeMonitor(monitor)
            
            popoverMonitor = nil
        
        }
    
    }

}

class DummyControl : NSControl {

    override func mouseDown(theEvent: NSEvent) {
    
        superview!.mouseDown(theEvent)
        
        sendAction(action, to: target)
    
    }

}

#endif