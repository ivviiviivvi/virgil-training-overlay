#!/usr/bin/swift
import Foundation
import AppKit

// MARK: - CLI Argument Handling

// Security: Check arguments before initializing NSWorkspace to prevent unnecessary resource allocation.
// This prevents resource exhaustion (DoS) if the user simply wants help.
if CommandLine.arguments.contains("-h") || CommandLine.arguments.contains("--help") {
    let scriptName = URL(fileURLWithPath: CommandLine.arguments[0]).lastPathComponent
    print("Usage: \(scriptName)")
    print("Tracks the frontmost application and outputs: New focus: <App Name>")
    exit(0)
}

// MARK: - Helper Functions

/// Sanitizes the application name to prevent log injection by removing control characters.
/// - Parameter name: The raw application name.
/// - Returns: The sanitized application name.
func getSanitizedAppName(_ name: String?) -> String {
    let safeName = name ?? "<none>"

    // Security: Truncate to 128 characters to prevent DoS via excessively long application names.
    // This limits the memory impact of processing malicious or malformed app names.
    let truncated = safeName.prefix(128)

    // Optimization: Pre-allocate capacity to avoid reallocations.
    var result = ""
    result.reserveCapacity(truncated.unicodeScalars.count)

    // Security: Filter out control characters to prevent log injection.
    // Using unicodeScalars is safer and more performant than string splitting.
    // We check each scalar against the control character set.
    for scalar in truncated.unicodeScalars {
        if !CharacterSet.controlCharacters.contains(scalar) {
            result.append(Character(scalar))
        }
    }

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
