#!/usr/bin/swift
import Foundation
import AppKit.NSWorkspace

// Sanitize input to prevent log injection (CWE-117)
func sanitize(_ input: String) -> String {
   return input.components(separatedBy: .controlCharacters).joined(separator: "")
}

// Returns the name of the frontmost app, or <none> if no app is frontmost
func currentFocusApp() -> String {
   let name = NSWorkspace.shared.frontmostApplication?.localizedName ?? "<none>"
   return sanitize(name)
}

var prev_name = currentFocusApp()
Swift.print("New focus: \(prev_name)")

// Schedule a timer to check every second
let updateTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
   let new_name = currentFocusApp()
   if prev_name != new_name {
      Swift.print("New focus: \(new_name)")
      prev_name = new_name
   }
})

// Detect Ctrl-C to stop observing
let sigintSrc = DispatchSource.makeSignalSource(signal: SIGINT, queue: .main)
sigintSrc.setEventHandler {
   Swift.print("")
   exit(0)
}
sigintSrc.resume()

RunLoop.current.run(mode: .default, before: .distantFuture)
