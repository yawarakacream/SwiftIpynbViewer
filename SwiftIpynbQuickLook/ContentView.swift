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
        return IpynbWrapper(ipynbUrl: ipynbUrl, ipynbFailed: $ipynbFailed)
            .scaleEffect(scale)
            .frame(width: geometry.size.width / scale, height: geometry.size.height / scale)
    }
    
//    private func makeView(_ geometry: GeometryProxy) -> some View {
//        let scale = min(1, geometry.size.width / ContentView.idealWidth)
//        let result = VStack {
//            IpynbView(ipynbUrl, whenLoaded: { status in
//                ipynbFailed = status == .failed
//            })
//            .scaleEffect(scale)
//            .frame(width: geometry.size.width / scale, height: geometry.size.height / scale)
//            if ipynbFailed {
//                Text("An error has occurred.")
//            }
//        }
//        .frame(width: geometry.size.width, height: geometry.size.height)
//        return result
//    }
    
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
