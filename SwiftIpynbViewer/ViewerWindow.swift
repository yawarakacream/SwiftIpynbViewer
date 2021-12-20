import Foundation
import SwiftUI

// A4 -> W : H = 1 : sqrt(2)
private let width = 768
private let height = Int(Double(width) * sqrt(2))

class ViewerWindow: NSWindow {
    
    init(_ ipynbUrl: URL) {
        super.init(
            contentRect: NSRect(x: 0, y: 0, width: width, height: height),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        
        self.isReleasedWhenClosed = true
        self.title = ipynbUrl.path
        self.contentView = NSHostingView(rootView: ContentView(ipynbUrl: ipynbUrl))
        self.center()
        self.makeKeyAndOrderFront(nil)
    }

}
