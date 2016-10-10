//
//  RCWindowController.swift
//  BlackBackground
//
//  Created by Art Rimbaud on 19/05/15.
//  Copyright (c) 2015 rimbaudcode. All rights reserved.
//

import Cocoa

class RCWindowController: NSWindowController {

  enum RCWindowPositionOnDesktop: Int {
    case belowIcons = 0
    case aboveIcons = 1
  }

  struct RCScreenFrameSize {
    let width = NSScreen.main()?.frame.size.width
    let height = NSScreen.main()?.frame.size.width
  }

  struct RCWindowAlphaValue {
    let initialAlphaValue: CGFloat
    let finalAlphaValue: CGFloat
  }

  struct RCWindowOrigin {
    let XOrigin: CGFloat
    let YOrigin: CGFloat
  }

  let kRCWindowAnimationDuration = 2.0
  let alphaValue = RCWindowAlphaValue(initialAlphaValue: 0.0, finalAlphaValue: 1.0)
  let screenFrameSize = RCScreenFrameSize()
  let windowOrigin = RCWindowOrigin(XOrigin: 0.0, YOrigin: 0.0)

}

extension RCWindowController {

  override func awakeFromNib() {
    setWindowProperties()
    setWindowPositionOnSpaces()
    setWindowPositionOnDestop()
    animateWindowDisplayAtLaunch()
    showMenuBar(true)
    launchOSXFinder()
  }

}

private extension RCWindowController {

  func setWindowProperties() {
    let screenFrame = NSMakeRect(windowOrigin.XOrigin, windowOrigin.YOrigin, screenFrameSize.width!, screenFrameSize.height!)

    window?.backgroundColor = NSColor.black
    window?.isOpaque = false
    window?.hasShadow = false
    window?.styleMask = NSBorderlessWindowMask // hide titlebar

    // scale window to fit the screen size
    window?.setFrame(screenFrame, display: true, animate: true)
  }

  func setWindowPositionOnSpaces() {
    window?.collectionBehavior = NSWindowCollectionBehavior.canJoinAllSpaces
  }

  func setWindowPositionOnDestop() {
    //window?.level = Int(CGWindowLevelForKey(CGWindowLevelKey.DesktopIconWindowLevelKey))
    window?.level = Int(CGWindowLevelForKey(CGWindowLevelKey.baseWindow))
  }

  func animateWindowDisplayAtLaunch() {
    NSAnimationContext.beginGrouping()
    NSAnimationContext.current().duration = kRCWindowAnimationDuration
    window?.alphaValue = alphaValue.initialAlphaValue
    window?.animator().alphaValue = alphaValue.finalAlphaValue
    NSAnimationContext.endGrouping()
  }

  func showMenuBar(_ show:Bool) {
    NSMenu.setMenuBarVisible(show)
  }

  func launchOSXFinder() {
    NSWorkspace.shared().launchApplication("Finder")
  }

}

