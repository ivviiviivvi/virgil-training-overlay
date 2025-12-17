#!/usr/bin/swift
import Foundation
import AppKit.NSWorkspace

// Returns the name of the frontmost app, or <none> if no app is frontmost
func currentFocusApp() -> String {
   NSWorkspace.shared.frontmostApplication?.localizedName ?? "<none>"
}

var prev_name = currentFocusApp()
Swift.print("New focus: \(prev_name)")

// Register observer for app activation events (Event-driven instead of polling)
// This optimization eliminates unnecessary CPU wake-ups every second.
let observer = NSWorkspace.shared.notificationCenter.addObserver(
   forName: NSWorkspace.didActivateApplicationNotification,
   object: nil,
   queue: .main
) { _ in
   let new_name = currentFocusApp()
   if prev_name != new_name {
      Swift.print("New focus: \(new_name)")
      prev_name = new_name
   }
}

// Detect Ctrl-C to stop observing
let sigintSrc = DispatchSource.makeSignalSource(signal: SIGINT, queue: .main)
sigintSrc.setEventHandler {
   Swift.print("")
   exit(0)
}
sigintSrc.resume()

RunLoop.current.run(mode: .default, before: .distantFuture)
