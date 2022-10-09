import SwiftUI

struct ContentView: View {
    
    private static let idealWidth: CGFloat = 768
    
    let ipynbUrl: URL
    
    @State var ipynbFailed: Bool = false
    
    init(ipynbUrl: URL) {
        self.ipynbUrl = ipynbUrl
    }
    
    public var body: some View {
        VStack {
            GeometryReader { makeIpynbView($0) }
            if ipynbFailed {
                Text("An error has occurred.")
            }
        }
    }
    
    private func makeIpynbView(_ geometry: GeometryProxy) -> some View {
        let scale = min(1, geometry.size.width / ContentView.idealWidth)
        print(geometry.size.width)
        return IpynbWrapper(ipynbUrl: ipynbUrl, ipynbFailed: $ipynbFailed)
            .frame(width: geometry.size.width / scale, height: geometry.size.height / scale)
            .scaleEffect(scale)
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color.red)
    }
    
}

// ウィンドウのサイズが変わったときに毎回 IpynbView.init が走ってしまうのを抑制する
private struct IpynbWrapper: View {
    
    let ipynbUrl: URL
    
    @Binding var ipynbFailed: Bool
    
    var body: some View {
        IpynbView(ipynbUrl, whenLoaded: { status in
            ipynbFailed = status == .failed
        })
    }
    
}
