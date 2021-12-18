import SwiftUI
import WebKit

typealias CallbackWhenLoaded = (IpynbStatus) -> Void

struct IpynbView: NSViewRepresentable {
    
    private let ipynbJson: String?
    private let htmlUrl: URL
    
    private let whenLoaded: CallbackWhenLoaded?
    
    init(_ ipynbUrl: URL, whenLoaded: CallbackWhenLoaded? = nil) {
        self.ipynbJson = try! String(contentsOf: ipynbUrl)
        self.htmlUrl = URL(
            fileURLWithPath: Bundle.main.path(forResource: "ipynb-viewer", ofType: "html")!,
            isDirectory: false)
        self.whenLoaded = whenLoaded
    }
    
    func makeNSView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.loadFileURL(htmlUrl, allowingReadAccessTo: htmlUrl)
        webView.allowsBackForwardNavigationGestures = true
        return webView
    }
    
    func updateNSView(_ webView: WKWebView, context: Context) {
        // do nothing.
    }
    
    func renderIpynb(_ webView: WKWebView) {
        guard let ipynbJson = ipynbJson else {
            whenLoaded?(.failed)
            return
        }
        webView.evaluateJavaScript("render(\(ipynbJson))", completionHandler: { (_, error) -> Void in
            whenLoaded?(error == nil ? .loaded : .failed)
        })
    }
    
    func makeCoordinator() -> IpynbCoordinator {
        return IpynbCoordinator(self)
    }
    
}

enum IpynbStatus {
    case loaded
    case failed
}
    
class IpynbCoordinator: NSObject, WKNavigationDelegate {
    
    var parent: IpynbView
    
    init(_ parent: IpynbView) {
        self.parent = parent
        super.init()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        parent.renderIpynb(webView)
    }
    
}
