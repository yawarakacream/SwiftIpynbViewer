import Foundation
import SwiftUI

class ViewerWindow: NSWindow {
    
    // A4 -> W : H = 1 : sqrt(2)
    static let width = 768
    static let height = Int(Double(width) * sqrt(2))
    
    init(_ ipynbUrl: URL) {
        super.init(
            contentRect: NSRect(x: 0, y: 0, width: ViewerWindow.width, height: ViewerWindow.height),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        
        let contentView = ContentView(ipynbUrl: ipynbUrl)
        
        self.isReleasedWhenClosed = true
        self.center()
        self.contentView = NSHostingView(rootView: contentView)
        self.makeKeyAndOrderFront(nil)
        self.title = ipynbUrl.path
    }

}
