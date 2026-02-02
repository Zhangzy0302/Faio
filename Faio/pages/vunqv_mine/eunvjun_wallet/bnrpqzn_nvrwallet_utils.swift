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

@MainActor
class IAPManager: ObservableObject {
  @Published var products: [Product] = []
  @Published var isPurchasing: Bool = false
  let userVM: FaioUserViewModel

  init(userVM: FaioUserViewModel) {
    self.userVM = userVM
  }

  // MARK: - 核心通用方法（抽离重复逻辑）
  private func purchaseProduct(_ product: Product) async -> Result<Product.PurchaseResult, Error> {
    do {
      let result = try await product.purchase()
      return .success(result)
    } catch {
      return .failure(error)
    }
  }

  /// 统一处理购买结果（仅在成功加钱后关闭loading）
  private func handlePurchaseResult(
    _ result: Result<Product.PurchaseResult, Error>, model: BeuaxjcaiProduct
  ) async {

    switch result {
    case .success(let purchaseResult):
      switch purchaseResult {
      case .success(let verification):
        if case .verified(let transaction) = verification {
          // 1. 购买成功：先更新钻石 + 完成交易
          userVM.increaseUserDiamond(diamond: model.beuaxjcaiGetDiamond)
          await transaction.finish()
          FaioHUD.success("Purchase success")
          // 2. 仅在成功加钱后关闭loading
          // isPurchasing = false
          FaioHUD.hideLoading()
        } else {
          // 验证失败：关闭loading + 提示
          // isPurchasing = false
          FaioHUD.hideLoading()
          FaioHUD.error("Purchase unverified")
        }
      case .userCancelled:
        // 用户取消：关闭loading + 提示
        // isPurchasing = false
        FaioHUD.hideLoading()
        FaioHUD.toast("Purchase cancelled")
      case .pending:
        // pending状态：保留loading（用户需等待）+ 提示
        FaioHUD.toast("Purchase pending, please wait")
      // 注意：pending状态不关闭loading，需等待后续验证结果
      // 若需要超时关闭，可添加延时任务，示例：
      // Task {
      //     try? await Task.sleep(nanoseconds: 10 * 1_000_000_000) // 10秒
      //     if isPurchasing { isPurchasing = false }
      // }
      @unknown default:
        // 未知状态：关闭loading + 提示
        // isPurchasing = false
        FaioHUD.hideLoading()
        FaioHUD.error("Unknown purchase result")
      }
    case .failure(let error):
      // 购买抛出错误：关闭loading + 提示
      // isPurchasing = false
      FaioHUD.hideLoading()
      FaioHUD.error("Purchase failed: \(error.localizedDescription)")
      print("Purchase failed:", error)
    }
  }

  // MARK: - 对外暴露的方法
  func fetchProducts() async {
    guard products.isEmpty else { return }
    do {
      let ids = ghuencziwProducts.map { $0.beuaxjcaiKeyId }
      products = try await Product.products(for: ids)
      print("Loaded products:", products.map { $0.id })
    } catch {
      FaioHUD.error("Load products failed: \(error.localizedDescription)")
      print("Fetch products failed:", error)
    }
  }

  func recharge(_ model: BeuaxjcaiProduct) async {
    // 开始购买：显示loading
    // isPurchasing = true
    FaioHUD.showLoading()
    // 确保产品已加载
    await fetchProducts()

    // 匹配产品（无产品则关闭loading + 返回）
    guard let product = products.first(where: { $0.id == model.beuaxjcaiKeyId }) else {
      // isPurchasing = false  // 关键：产品未找到时手动关闭loading
      FaioHUD.hideLoading()
      FaioHUD.error("Product not found")
      return
    }

    // 执行购买 + 处理结果
    let purchaseResult = await purchaseProduct(product)
    await handlePurchaseResult(purchaseResult, model: model)
  }
}
