import Cocoa
import Quartz
import SwiftUI

// A4 -> W : H = 1 : sqrt(2)
private let width = CGFloat(768)
private let height = Int(Double(width) * sqrt(2))

class PreviewViewController: NSViewController, QLPreviewingController {
    
    override var nibName: NSNib.Name? {
        return NSNib.Name("PreviewViewController")
    }
    
    override func loadView() {
        super.loadView()
        view.autoresizingMask = [.width, .height]
    }

    func preparePreviewOfFile(at url: URL, completionHandler handler: @escaping (Error?) -> Void) {
        let host = NSHostingView(rootView: ContentView(ipynbUrl: url))
        host.frame = view.frame
        host.autoresizingMask = [.width, .height]
        
        view.addSubview(host)
        
        handler(nil)
    }
    
}
