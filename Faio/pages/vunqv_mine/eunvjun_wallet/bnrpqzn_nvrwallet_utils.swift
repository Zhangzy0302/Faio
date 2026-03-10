import FBSDKCoreKit
import StoreKit
import SwiftUI

struct BeuaxjcaiProduct {
  let beuaxjcaiKeyId: String
  let beuaxjcaiGetDiamond: Int
  let beuaxjcaiPrice: Double
}

let ghuencziwProducts: [BeuaxjcaiProduct] = [
  BeuaxjcaiProduct(
    beuaxjcaiKeyId: "kovjqczbbagfcwtp", beuaxjcaiGetDiamond: 400, beuaxjcaiPrice: 0.99),
  BeuaxjcaiProduct(
    beuaxjcaiKeyId: "ygdtyfsetyaptuzu", beuaxjcaiGetDiamond: 800, beuaxjcaiPrice: 1.99),
  BeuaxjcaiProduct(
    beuaxjcaiKeyId: "iinptqvcxprqbjaq", beuaxjcaiGetDiamond: 2450, beuaxjcaiPrice: 4.99),
  BeuaxjcaiProduct(
    beuaxjcaiKeyId: "vxqusifauhoifyrh", beuaxjcaiGetDiamond: 5150, beuaxjcaiPrice: 9.99),
  BeuaxjcaiProduct(
    beuaxjcaiKeyId: "xqmdrvaewpkslhtn", beuaxjcaiGetDiamond: 6400, beuaxjcaiPrice: 12.99),
  BeuaxjcaiProduct(
    beuaxjcaiKeyId: "wyelujafcagiojjj", beuaxjcaiGetDiamond: 10800, beuaxjcaiPrice: 19.99),
  BeuaxjcaiProduct(
    beuaxjcaiKeyId: "bczufnoykqjewrsa", beuaxjcaiGetDiamond: 11200, beuaxjcaiPrice: 20.99),
  BeuaxjcaiProduct(
    beuaxjcaiKeyId: "xwbzewwucitehljp", beuaxjcaiGetDiamond: 29400, beuaxjcaiPrice: 49.99),
  BeuaxjcaiProduct(
    beuaxjcaiKeyId: "mptxkvdnshfcaeor", beuaxjcaiGetDiamond: 39500, beuaxjcaiPrice: 79.99),
  BeuaxjcaiProduct(
    beuaxjcaiKeyId: "wkxvtywoyadaqvue", beuaxjcaiGetDiamond: 63700, beuaxjcaiPrice: 99.99),
]

final class IAPManager: NSObject, ObservableObject {

    @Published var products: [SKProduct] = []
    @Published var isPurchasing: Bool = false
    @Published var isLoadingProducts: Bool = false // 新增状态

    let userVM: FaioUserViewModel

    // 重试机制相关属性
    private var retryTimer: Timer?
    private var retryCount = 0
    private let maxRetryAttempts = 5
    private let retryInterval: TimeInterval = 2.0 // 初始重试间隔

    init(userVM: FaioUserViewModel) {
        self.userVM = userVM
        super.init()
        SKPaymentQueue.default().add(self)
        print("IAPManager init:", ObjectIdentifier(self))
    }

    deinit {
        stopRetryTimer()
        SKPaymentQueue.default().remove(self)
    }

    // MARK: - 拉取商品（StoreKit1）- 带重试
    func fetchProducts() {
        // 重置重试计数
        retryCount = 0
        isLoadingProducts = true
        
        let request = SKProductsRequest(
            productIdentifiers: Set(ghuencziwProducts.map { $0.beuaxjcaiKeyId }))
        request.delegate = self
        request.start()
        
    }

    // MARK: - 重试逻辑
    private func startRetryTimer() {
        // 避免重复启动定时器
        stopRetryTimer()
        
        let delay = retryInterval * pow(2.0, Double(retryCount)) // 指数退避
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            guard let self = self else { return }
            
            print("Retrying to fetch products for the \(self.retryCount + 1) th time...")
            
            let request = SKProductsRequest(
                productIdentifiers: Set(ghuencziwProducts.map { $0.beuaxjcaiKeyId }))
            request.delegate = self
            request.start()
            
            self.retryCount += 1
        }
    }
    
    private func stopRetryTimer() {
        retryTimer?.invalidate()
        retryTimer = nil
    }

    // MARK: - 发起购买（StoreKit1）
    func recharge(_ productKeyId: String) {
        // 在购买前检查是否有商品信息
        if products.isEmpty {
            fetchProducts()
            // 可以选择等待商品加载完成后再发起购买，或者稍后重试
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                guard let self = self else { return }
                // 稍后重试购买
                if !self.products.isEmpty {
                    self.attemptRecharge(productKeyId)
                } else {
                    FaioHUD.error("Failed to load product information. Please try again later")
                }
            }
            return
        }
        
        attemptRecharge(productKeyId)
    }
    
    private func attemptRecharge(_ productKeyId: String) {
        FaioHUD.showLoading()
        isPurchasing = true

        print("IAPManager recharge:", ObjectIdentifier(self))

        guard let product = products.first(where: { $0.productIdentifier == productKeyId }) else {
            FaioHUD.error("Product not found")
            FaioHUD.hideLoading()
            isPurchasing = false
            return
        }

        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }

    // MARK: - Facebook 埋点
    private func logFacebookPurchase(price: Double) {
        AppEvents.shared.logPurchase(
            amount: price,
            currency: "USD",
            parameters: [AppEvents.ParameterName(rawValue: "fb_mobile_purchase"): "true"]
        )
    }

    // MARK: - 找本地配置
    private func findWalletItem(productID: String) -> BeuaxjcaiProduct? {
        ghuencziwProducts.first { $0.beuaxjcaiKeyId == productID }
    }
}

extension IAPManager: SKPaymentTransactionObserver {

    func paymentQueue(
        _ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]
    ) {
        for transaction in transactions {
            switch transaction.transactionState {

            case .purchased:
                handlePurchased(transaction)

            case .failed:
                handleFailed(transaction)

            case .restored:
                SKPaymentQueue.default().finishTransaction(transaction)

            case .purchasing:
                break

            case .deferred:
                FaioHUD.toast("Purchase pending")

            @unknown default:
                break
            }
        }
    }

    private func handlePurchased(_ transaction: SKPaymentTransaction) {
        guard let model = findWalletItem(productID: transaction.payment.productIdentifier) else {
            FaioHUD.error("Product config not found")
            SKPaymentQueue.default().finishTransaction(transaction)
            FaioHUD.hideLoading()
            isPurchasing = false
            return
        }

        // 如果需要服务器校验
        if TeabzbaAppStorage.teabzbaIsB {
            Task {
                let purchaseID = transaction.transactionIdentifier ?? ""
                let serverVerificationData: String
                if let receiptURL = Bundle.main.appStoreReceiptURL,
                   let receiptData = try? Data(contentsOf: receiptURL)
                {
                    serverVerificationData = receiptData.base64EncodedString()
                } else {
                    serverVerificationData = ""
                }
                let isVerified = try await UgZhyaiwLDKalApiCall().ugZhyaiwLDKalPayCall(
                    purchaseID: purchaseID,
                    serverVerificationData: serverVerificationData,  // StoreKit1 没有 JWS，通常传空或自签
                    orderCode: waknxaPaksUsersOrdercode
                )

                if isVerified {
                    logFacebookPurchase(price: model.beuaxjcaiPrice)
                    await AdjustManager.shared.trackPurchase(dollar: model.beuaxjcaiPrice)
                    SKPaymentQueue.default().finishTransaction(transaction)
                    FaioHUD.success("Purchase success")
                } else {
                    SKPaymentQueue.default().finishTransaction(transaction)
                    FaioHUD.error("Purchase unverified")
                }

                FaioHUD.hideLoading()
                isPurchasing = false
            }
        } else {
            // 无服务器校验：本地加钻
            Task { @MainActor in
                userVM.increaseUserDiamond(diamond: model.beuaxjcaiGetDiamond)
            }

            logFacebookPurchase(price: model.beuaxjcaiPrice)

            SKPaymentQueue.default().finishTransaction(transaction)
            FaioHUD.success("Purchase success")
            FaioHUD.hideLoading()
            isPurchasing = false
        }
    }

    private func handleFailed(_ transaction: SKPaymentTransaction) {

        if let error = transaction.error as? SKError {

            switch error.code {
            case .paymentCancelled:
                print("Purchase cancelled")

            default:
                FaioHUD.error("Purchase failed")
            }
        } else {
            FaioHUD.error("Purchase failed")
        }

        SKPaymentQueue.default().finishTransaction(transaction)
        FaioHUD.hideLoading()
        isPurchasing = false
    }
}

extension IAPManager: SKProductsRequestDelegate {

    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        products = response.products
        print("Loaded products:", products.map { $0.productIdentifier })
        
        // 成功加载后停止重试
        stopRetryTimer()
        retryCount = 0
        isLoadingProducts = false
        
        if products.isEmpty {
            print("Warning: The request was successful, however the product list returned is empty")
            // 可以选择在此处也进行重试
            startRetryTimer()
        }
    }

    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("Failed to fetch products: \(error.localizedDescription)")
        isLoadingProducts = false
        
        // 检查是否还有重试机会
        if retryCount < maxRetryAttempts {
            print("准备进行第 \(retryCount + 1) 次重试...")
            startRetryTimer()
        } else {
            print("Maximum retry attempts reached (\(maxRetryAttempts))")
            FaioHUD.error("Failed to load product information. Please try again later")
            // 重置重试计数
            retryCount = 0
        }
    }
}
