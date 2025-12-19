#!/usr/bin/swift
import Foundation
import AppKit

// Formats the timestamp for log context
func timestamp() -> String {
   let formatter = DateFormatter()
   formatter.dateFormat = "HH:mm:ss"
   return "[\(formatter.string(from: Date()))]"
}

// Sanitizes input to prevent log injection/control character issues
func sanitize(_ name: String) -> String {
   return name.components(separatedBy: .controlCharacters).joined()
}

// Prints the focused app with timestamp
func logFocus(_ appName: String) {
   Swift.print("\(timestamp()) New focus: \(sanitize(appName))")
}

// Initial check
if let currentApp = NSWorkspace.shared.frontmostApplication?.localizedName {
   logFocus(currentApp)
}

// Switch to event-driven observation (NSWorkspace.didActivateApplicationNotification)
// This reduces CPU usage compared to polling and provides instant feedback (better UX).
NSWorkspace.shared.notificationCenter.addObserver(
   forName: NSWorkspace.didActivateApplicationNotification,
   object: nil,
   queue: .main
) { notification in
   if let app = notification.userInfo?[NSWorkspace.applicationUserInfoKey] as? NSRunningApplication,
      let name = app.localizedName {
      logFocus(name)
   }
}

// Handle Ctrl-C
let sigintSrc = DispatchSource.makeSignalSource(signal: SIGINT, queue: .main)
sigintSrc.setEventHandler {
   Swift.print("")
   exit(0)
}
sigintSrc.resume()

RunLoop.current.run()
