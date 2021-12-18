import SwiftUI

struct ContentView: View {
    
    private let ipynbUrl: URL
    
    @State var ipynbFailed: Bool = false
    
    init(ipynbUrl: URL) {
        self.ipynbUrl = ipynbUrl
    }
    
    public var body: some View {
        VStack {
            IpynbView(ipynbUrl, whenLoaded: { (status) -> Void in
                ipynbFailed = status == .failed
            })
            if ipynbFailed {
                Text("An error has occurred.")
            }
        }
        .frame(minWidth: 240, maxWidth: .infinity, minHeight: 240, maxHeight: .infinity)
        .padding(4)
    }
}
