#!/usr/bin/swift
import Foundation
import AppKit.NSWorkspace

if CommandLine.arguments.contains("-h") || CommandLine.arguments.contains("--help") {
   print("Usage: mac-tooltip")
   print("Monitors and prints the name of the frontmost application.")
   print("\nPress Ctrl-C to stop monitoring.")
   exit(0)
}

// Returns the name of the frontmost app, or <none> if no app is frontmost
func currentFocusApp() -> String {
   NSWorkspace.shared.frontmostApplication?.localizedName ?? "<none>"
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
