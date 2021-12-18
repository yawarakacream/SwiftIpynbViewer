import Cocoa
import SwiftUI

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    private var windows: [NSWindow] = []
    
    private var urls: [URL]?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        if urls == nil {
            let panel = NSOpenPanel()
            
            panel.canChooseDirectories = false
            panel.allowsMultipleSelection = true
            panel.allowedFileTypes = ["ipynb"]
            
            if panel.runModal() == .OK {
                urls = panel.urls
            }
        }
        
        guard let urls = urls else {
            NSApplication.shared.terminate(true)
            return
        }
        
        urls.forEach { windows.append(ViewerWindow($0)) }
        
        if windows.isEmpty {
            NSApplication.shared.terminate(true)
            return
        }
    }
    
    func application(_ application: NSApplication, open urls: [URL]) {
        self.urls = urls
    }
    
    func application(_ sender: NSApplication, openFile filename: String) -> Bool {
        return filename.hasSuffix(".ipynb")
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        NSApplication.shared.terminate(true)
        return true
    }
    
}
