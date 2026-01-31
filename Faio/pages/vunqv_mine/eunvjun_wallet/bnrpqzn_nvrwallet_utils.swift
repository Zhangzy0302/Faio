import StoreKit
import SwiftUI

struct BeuaxjcaiProduct {
  let beuaxjcaiKeyId: String
  let beuaxjcaiGetDiamond: Int
  let beuaxjcaiPrice: Double
}

let ghuencziwProducts: [BeuaxjcaiProduct] = [
  BeuaxjcaiProduct(
    beuaxjcaiKeyId: "lvbsvhxcgcrvesor", beuaxjcaiGetDiamond: 400, beuaxjcaiPrice: 0.99),
  BeuaxjcaiProduct(
    beuaxjcaiKeyId: "thsa", beuaxjcaiGetDiamond: 800, beuaxjcaiPrice: 1.99),
  BeuaxjcaiProduct(
    beuaxjcaiKeyId: "dxismgcwewhrtezo", beuaxjcaiGetDiamond: 2450, beuaxjcaiPrice: 4.99),
  BeuaxjcaiProduct(
    beuaxjcaiKeyId: "khtxlcejaxa", beuaxjcaiGetDiamond: 5150, beuaxjcaiPrice: 9.99),
  BeuaxjcaiProduct(
    beuaxjcaiKeyId: "khtxlcejaxmqcsra", beuaxjcaiGetDiamond: 6400, beuaxjcaiPrice: 12.99),
  BeuaxjcaiProduct(
    beuaxjcaiKeyId: "crwfasd", beuaxjcaiGetDiamond: 10800, beuaxjcaiPrice: 19.99),
  BeuaxjcaiProduct(
    beuaxjcaiKeyId: "yadwwvxspgxwlndb", beuaxjcaiGetDiamond: 11200, beuaxjcaiPrice: 20.99),
  BeuaxjcaiProduct(
    beuaxjcaiKeyId: "tvpgeewvljziovvd", beuaxjcaiGetDiamond: 29400, beuaxjcaiPrice: 49.99),
  BeuaxjcaiProduct(
    beuaxjcaiKeyId: "ftrnqazwokmyepls", beuaxjcaiGetDiamond: 39500, beuaxjcaiPrice: 79.99),
  BeuaxjcaiProduct(
    beuaxjcaiKeyId: "bagsaefmmusilzhx", beuaxjcaiGetDiamond: 63700, beuaxjcaiPrice: 99.99),
]

@MainActor
class IAPManager: ObservableObject {
    @Published var products: [Product] = []
    @Published var isPurchasing: Bool = false
    let userVM: FaioUserViewModel
    
    init(userVM: FaioUserViewModel) {
        self.userVM = userVM
    }
    
    // MARK: - 核心通用方法（抽离重复逻辑）
    /// 通用购买方法（统一处理购买逻辑，避免重复）
    private func purchaseProduct(_ product: Product) async -> Result<Product.PurchaseResult, Error> {
        do {
            let result = try await product.purchase()
            return .success(result)
        } catch {
            return .failure(error)
        }
    }
    
    /// 统一状态重置 + 提示（抽离所有分支的重复状态修改和HUD提示）
    private func handlePurchaseResult(_ result: Result<Product.PurchaseResult, Error>, model: BeuaxjcaiProduct) async {
        defer { isPurchasing = false } // 无论结果如何，最终都关闭loading
        
        switch result {
        case .success(let purchaseResult):
            switch purchaseResult {
            case .success(let verification):
                if case .verified(let transaction) = verification {
                    // 购买成功：更新钻石 + 完成交易
                    userVM.increaseUserDiamond(diamond: model.beuaxjcaiGetDiamond)
                    await transaction.finish()
                    FaioHUD.success("Purchase success")
                } else {
                    FaioHUD.error("Purchase unverified")
                }
            case .userCancelled:
                FaioHUD.toast("Purchase cancelled")
            case .pending:
                FaioHUD.toast("Purchase pending, please wait")
            @unknown default:
                FaioHUD.error("Unknown purchase result")
            }
        case .failure(let error):
            FaioHUD.error("Purchase failed: \(error.localizedDescription)")
            print("Purchase failed:", error)
        }
    }
    
    // MARK: - 对外暴露的方法（简化版）
    /// 加载产品（仅加载，不干扰购买状态）
    func fetchProducts() async {
        guard products.isEmpty else { return } // 已加载则直接返回，避免重复请求
        do {
            let ids = ghuencziwProducts.map { $0.beuaxjcaiKeyId }
            products = try await Product.products(for: ids)
            print("Loaded products:", products.map { $0.id })
        } catch {
            FaioHUD.error("Load products failed: \(error.localizedDescription)")
            print("Fetch products failed:", error)
        }
    }
    
    /// 充值（核心方法，简化后仅保留核心逻辑）
    func recharge(_ model: BeuaxjcaiProduct) async {
        // 1. 开始购买：显示loading
        isPurchasing = true
        
        // 2. 确保产品已加载
        await fetchProducts()
        
        // 3. 匹配产品（无产品则直接返回，defer会自动关闭loading）
        guard let product = products.first(where: { $0.id == model.beuaxjcaiKeyId }) else {
            FaioHUD.error("Product not found")
            return
        }
        
        // 4. 执行购买 + 统一处理结果
        let purchaseResult = await purchaseProduct(product)
        await handlePurchaseResult(purchaseResult, model: model)
    }
    
//    /// 保留原purchase方法（若有其他场景使用，简化为调用通用方法）
//    func purchase(product: Product, amount: Int) async {
//        isPurchasing = true
//        let result = await purchaseProduct(product)
//        // 空model仅用于兼容通用方法（若该方法仅为充值服务，可删除此方法）
//        await handlePurchaseResult(result, model: BeuaxjcaiProduct(beuaxjcaiKeyId: product.id, beuaxjcaiGetDiamond: amount))
//    }
}
