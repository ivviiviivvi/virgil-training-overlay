#!/usr/bin/swift
import Foundation
import AppKit

// MARK: - Helper Functions

/// Sanitizes the application name to prevent log injection by removing control characters.
/// - Parameter name: The raw application name.
/// - Returns: The sanitized application name.
func getSanitizedAppName(_ name: String?) -> String {
    let safeName = name ?? "<none>"
    // Security: Truncate to 128 chars to prevent DoS with massive strings.
    // Performance: Checking fewer characters is faster.
    let truncated = safeName.prefix(128)

    // Security: Remove control characters to prevent log injection vulnerabilities.
    // Optimization: Use filter and append to unicodeScalars to avoid overhead of components(separatedBy:).joined().
    let filteredScalars = truncated.unicodeScalars.filter { !CharacterSet.controlCharacters.contains($0) }

    var result = ""
    result.unicodeScalars.append(contentsOf: filteredScalars)
    return result
}

// MARK: - State

var lastPrintedName = ""

/// Prints the new focus application name if it has changed.
/// - Parameter rawName: The raw name of the application.
func handleFocusChange(_ rawName: String?) {
    let newName = getSanitizedAppName(rawName)

    // Optimization: Only print if the name actually changed.
    if newName != lastPrintedName {
        // Output format adherence: Strictly preserve "New focus: <App Name>"
        Swift.print("New focus: \(newName)")
        lastPrintedName = newName
    }
}

// MARK: - Main Logic

// Performance: We switched from a polling Timer to NSWorkspace notifications.
// This event-driven approach significantly reduces CPU usage and battery drain
// by only waking up the process when the active application actually changes.

let workspace = NSWorkspace.shared
let notificationCenter = workspace.notificationCenter

// Initial check to set the state and print current focus
handleFocusChange(workspace.frontmostApplication?.localizedName)

// Observe application activation events
notificationCenter.addObserver(
    forName: NSWorkspace.didActivateApplicationNotification,
    object: nil,
    queue: .main
) { notification in
// Retrieve the application from the notification's user info
let app = notification.userInfo?[NSWorkspace.applicationUserInfoKey] as? NSRunningApplication
handleFocusChange(app?.localizedName)
}

// MARK: - Signal Handling

// Detect Ctrl-C to stop observing and exit gracefully
let sigintSrc = DispatchSource.makeSignalSource(signal: SIGINT, queue: .main)
sigintSrc.setEventHandler {
    Swift.print("")
    exit(0)
}
sigintSrc.resume()

// Start the run loop to process notifications
RunLoop.current.run()
