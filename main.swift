#!/usr/bin/swift
import Foundation
import AppKit

// Sanitize input to remove control characters and prevent log injection
func sanitize(_ input: String) -> String {
    return input.components(separatedBy: .controlCharacters).joined(separator: "")
}

// Returns the formatted timestamp
func timestamp() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm:ss"
    return formatter.string(from: Date())
}

// Print the focus change with timestamp and sanitized name
func printFocus(_ name: String) {
    let cleanName = sanitize(name)
    Swift.print("[\(timestamp())] New focus: \(cleanName)")
}

// Initial print
if let app = NSWorkspace.shared.frontmostApplication {
    printFocus(app.localizedName ?? "<none>")
}

// Observer for application activation
NSWorkspace.shared.notificationCenter.addObserver(
    forName: NSWorkspace.didActivateApplicationNotification,
    object: nil,
    queue: .main
) { notification in
    if let app = notification.userInfo?[NSWorkspace.applicationUserInfoKey] as? NSRunningApplication {
        printFocus(app.localizedName ?? "<none>")
    }
}

// Detect Ctrl-C to stop observing
let sigintSrc = DispatchSource.makeSignalSource(signal: SIGINT, queue: .main)
sigintSrc.setEventHandler {
   Swift.print("")
   exit(0)
}
sigintSrc.resume()

RunLoop.current.run()
