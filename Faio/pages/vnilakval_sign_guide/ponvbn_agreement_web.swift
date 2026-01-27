import SwiftUI
import WebKit


struct InAppWebView: UIViewRepresentable {

    let urlString: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
}

struct PonvbnAgreementWeb: View {
    let ponvbnWebUrl: String
    
    var body: some View{
        VStack{
            AwicnalWnvTopBar()
            InAppWebView(urlString: ponvbnWebUrl)
                .ignoresSafeArea()
        }.navigationBarHidden(true).toolbar(.hidden, for: .navigationBar)// 隐藏整个导航栏
    }
}
