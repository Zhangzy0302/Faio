import ScreenShield
import SwiftUI
@preconcurrency import WebKit

@MainActor
struct XmaalwiDAiWebView: UIViewRepresentable {

  let urlString: String
  var onLoadingStart: (() -> Void)?
  var onLoadingFinish: ((Int) -> Void)?
  var onClose: (() -> Void)?
  var onRecharge: ((String, String) -> Void)?

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  func makeUIView(context: Context) -> WKWebView {

    let config = WKWebViewConfiguration()
    let contentController = WKUserContentController()

    // JS 回调
    contentController.add(context.coordinator, name: "rechargePay")
    contentController.add(context.coordinator, name: "Close")
    contentController.add(context.coordinator, name: "openBrowser")

    config.userContentController = contentController
    config.mediaTypesRequiringUserActionForPlayback = []
    config.allowsInlineMediaPlayback = true

    let webView = WKWebView(frame: .zero, configuration: config)

    webView.uiDelegate = context.coordinator
    webView.navigationDelegate = context.coordinator
    webView.isOpaque = false
    webView.backgroundColor = .clear
    webView.scrollView.backgroundColor = .clear
    webView.scrollView.contentInsetAdjustmentBehavior = .never
    webView.scrollView.contentInset = .zero
    webView.scrollView.scrollIndicatorInsets = .zero
    // 网页内左滑返回
    webView.allowsBackForwardNavigationGestures = true

    // ✅ 直接用 urlString
    if let url = URL(string: urlString) {
      webView.load(URLRequest(url: url))
    }

    return webView
  }

  func updateUIView(_ webView: WKWebView, context: Context) {
  }

  @MainActor
  class Coordinator: NSObject, WKNavigationDelegate, WKScriptMessageHandler, WKUIDelegate {

    var parent: XmaalwiDAiWebView
    var startTime: Date?

    init(_ parent: XmaalwiDAiWebView) {
      self.parent = parent
    }

    // MARK: - 加载开始
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
      startTime = Date()
      parent.onLoadingStart?()
    }

    // MARK: - 加载结束
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

      if let start = startTime {
        let duration = Int(Date().timeIntervalSince(start) * 1000)
        parent.onLoadingFinish?(duration)
      }
    }

    // MARK: - 外链拦截
    func webView(
      _ webView: WKWebView,
      decidePolicyFor navigationAction: WKNavigationAction,
      decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
    ) {

      if let url = navigationAction.request.url,
        !["http", "https", "file", "about", "javascript"].contains(url.scheme)
      {

        UIApplication.shared.open(url)
        decisionHandler(.cancel)
        return
      }

      decisionHandler(.allow)
    }

    func webView(
      _ webView: WKWebView,
      requestMediaCapturePermissionFor origin: WKSecurityOrigin,
      initiatedByFrame frame: WKFrameInfo,
      type: WKMediaCaptureType,
      decisionHandler: @escaping (WKPermissionDecision) -> Void
    ) {
      decisionHandler(.grant)
    }

    // MARK: - JS 通信
    func userContentController(
      _ userContentController: WKUserContentController,
      didReceive message: WKScriptMessage
    ) {

      if message.name == "rechargePay",
        let dict = message.body as? [String: Any],
        let orderCode = dict["orderCode"] as? String,
        let batchNo = dict["batchNo"] as? String
      {

        parent.onRecharge?(orderCode, batchNo)
      }

      if message.name == "Close" {
        parent.onClose?()
      }
        if message.name == "openBrowser" {

            var urlString: String?

            if let dict = message.body as? [String: Any] {
                urlString = dict["url"] as? String
            } else if let str = message.body as? String {
                urlString = str
            }

            guard var urlString else { return }

            if !urlString.hasPrefix("http") {
                urlString = "https://" + urlString
            }

            if let url = URL(string: urlString) {
                DispatchQueue.main.async {
                    UIApplication.shared.open(url)
                }
            }
        }
         
    }

  }
}

struct PonvbnAgreementWeb: View {
  @Binding var appPath: NavigationPath
  let ponvbnWebUrl: String

  @EnvironmentObject var iapManager: IAPManager

  @State private var loadingProgress: Double = 0
  @State private var isLoading: Bool = true
  var body: some View {

    ZStack {
      if TeabzbaAppStorage.teabzbaIsB && isLoading {
        GeometryReader { geo in
          Image("vnzwa_guide_bg")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: .infinity, maxHeight: .infinity).ignoresSafeArea()
        }
        LinearGradient(
          gradient: Gradient(colors: [
            Color(red: 29 / 255, green: 29 / 255, blue: 29 / 255), Color.black.opacity(0),
          ]),
          startPoint: .bottom,
          endPoint: .top
        ).ignoresSafeArea()
      }

      VStack(spacing: 0) {

        if !TeabzbaAppStorage.teabzbaIsB {
          ZStack(alignment: .center) {

            HStack {
              // 左侧返回
              Button {
                appPath.removeLast()
              } label: {
                Image("vnzwa_icon_back")
                  .resizable()
                  .frame(width: 40, height: 40)
              }.buttonStyle(.plain)

            }.frame(height: 40, alignment: .leading)

          }.frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
            .padding(.top, 16)
        }

        XmaalwiDAiWebView(
          urlString: ponvbnWebUrl,
          onLoadingStart: {
            isLoading = true
          },
          onLoadingFinish: { duration in
            isLoading = false

            if TeabzbaAppStorage.teabzbaIsB {
              Task {
                try await UgZhyaiwLDKalApiCall()
                  .ugZhyaiwLDKalLoadingTimeRecord(duration)
              }
            }
          },
          onClose: {
            TeabzbaAppStorage.teabzbaUserToken = ""
            appPath.removeLast(appPath.count)
          },
          onRecharge: { orderCode, batchNo in
            waknxaPaksUsersOrdercode = orderCode
            Task {
              iapManager.recharge(batchNo)
            }
          }
        ).ignoresSafeArea()

      }

      // 加载遮罩（等价 Flutter loading UI）
      if isLoading {

        VStack(spacing: 30) {

          ProgressView()
            .scaleEffect(1.5)
            .foregroundColor(.white)

          Text("loading...")
            .font(.system(size: 16, weight: .medium))
            .foregroundColor(.white)
        }
        .padding()
        .background(.black.opacity(0.9))
        .cornerRadius(16)
      }
    }
    .navigationBarHidden(true)
    .background {
      if !TeabzbaAppStorage.teabzbaIsB {
        EnableSwipeBack()
      }
    }
    .protectScreenshot()  // Protect the view
    .ignoresSafeArea()
    .onAppear {
      ScreenShield.shared.protectFromScreenRecording()  // Protect Screen-Recording
    }
  }
}
