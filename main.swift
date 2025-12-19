#!/usr/bin/swift
import Foundation
import AppKit

// Returns the name of the frontmost app, or <none> if no app is frontmost
func currentFocusApp() -> String {
   NSWorkspace.shared.frontmostApplication?.localizedName ?? "<none>"
}

var prev_name = currentFocusApp()
Swift.print("New focus: \(prev_name)")

// OPTIMIZATION: Use NSWorkspace notifications instead of polling to reduce CPU usage.
// Previous implementation used a 1s Timer which consumed unnecessary cycles.
// Event-driven approach waits for the OS to notify us of changes.
NSWorkspace.shared.notificationCenter.addObserver(
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
