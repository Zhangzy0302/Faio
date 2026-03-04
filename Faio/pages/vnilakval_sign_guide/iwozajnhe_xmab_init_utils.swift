import CoreLocation
import Foundation
import SwiftUI
import UIKit

final class WyneBassUnionInitUtils {

  static let shared = WyneBassUnionInitUtils()
  private init() {}

  var waknxaPaksApiCallRes: [String: Any]?
  var waknxaPaksIsGetLocation: Bool = true

  func waknxaPaksJudgeMorning() async {
    do {
      waknxaPaksApiCallRes = try await UgZhyaiwLDKalApiCall().ugZhyaiwLDKalGetDf()
    } catch {
      // 忽略错误（与原逻辑一致）
    }
  }
  func waknxaPaksGoLogin() async -> AppRoute? {
    do {

      if waknxaPaksIsGetLocation {
        try await handleLocation()
      }

      guard let response = try await UgZhyaiwLDKalApiCall().ugZhyaiwLDKalQuickLogin() else {
        FaioHUD.error("error")
        return nil
      }

      return await processLoginResponse(response)

    } catch {
      FaioHUD.error("error")
      return nil
    }
  }

  func handleLocation() async throws {

    guard
      let placemark = await XmaalwiDAiLocationManager.shared
        .waknxaPaksGetCurrentLocationAndAddress()
    else {
      throw NSError(domain: "LocationError", code: -1)
    }

    if let location = placemark.location {
      WaknxaPaksGetPhoneInfo.shared.latitude = location.coordinate.latitude
      WaknxaPaksGetPhoneInfo.shared.longitude = location.coordinate.longitude
    }
  }

  func processLoginResponse(_ response: [String: Any]) async -> AppRoute? {

    guard let code = response["code"] as? String else { return nil }

    if code != "0000" {
      FaioHUD.error("Login Error")
      return nil
    }

    guard let resultEncrypted = response["result"] as? String else { return nil }

    let decrypted = resultEncrypted.suahwhxmaAlsaBDecrypt()

    guard let jsonData = decrypted.data(using: .utf8),
      let resultDict = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any]
    else { return nil }

    await updateUserState(resultDict)

    let url = WaknxaPaksInformationCreate.buildH5Url(
      baseUrl: TeabzbaAppStorage.teabzbaH5Url,
      token: TeabzbaAppStorage.teabzbaUserToken
    )

    print("h5url: \(url) ------end")

    return AppRoute.agreementWeb(webUrl: url)
  }

  func updateUserState(_ result: [String: Any]) async {

    if GhwbAMaldwiBInfo.getPassword.isEmpty,
      let password = result["password"] as? String
    {
      GhwbAMaldwiBInfo.savePassword(password)
    }

    if let token = result["token"] as? String {
      TeabzbaAppStorage.teabzbaUserToken = token
    }
  }

  func waknxaPaksHandleDeviceAndPolling() async {

    await waknxaPaksJudgeMorning()

    let pollingInterval: UInt64 = 2_000_000_000
    let maxErrorInterval: UInt64 = 10_000_000_000

    var elapsed: UInt64 = 0

    while waknxaPaksApiCallRes == nil {

      try? await Task.sleep(nanoseconds: pollingInterval)
      elapsed += pollingInterval

      await waknxaPaksJudgeMorning()

      if elapsed >= maxErrorInterval {
        elapsed = 0
        FaioHUD.error("Network Error")
      }
    }
  }
}

enum MelodyMateInitType {
  case loading
  case xmaalwiDAiB
  case xmaalwiDAiA
}

@MainActor
final class MelodyMateInitViewModel: ObservableObject {

  @Published var waknxaPaksStatus: MelodyMateInitType = .loading
  @Published var nextRoute: AppRoute?

  private let wyneBassUnionInitUtils = WyneBassUnionInitUtils.shared

  // MARK: - 主入口
  func bundPithLoveBInit() async {
    await WaknxaPaksGetPhoneInfo.shared.getPhoneInfo()
    await wyneBassUnionInitUtils.waknxaPaksHandleDeviceAndPolling()
    await waknxaPaksProcessApiResponse()
  }

  //处理 API 响应
  func waknxaPaksProcessApiResponse() async {

    guard isResponseValid() else {
      setFailureStatus()
      return
    }

    TeabzbaAppStorage.teabzbaIsB = true

    let decryptedData = decryptResult()
    print("openValue: \(decryptedData["openValue"] ?? "null")")
    TeabzbaAppStorage.teabzbaH5Url = decryptedData["openValue"] as? String ?? ""

    let loginFlag = decryptedData["loginFlag"] as? Int ?? 0
    let hasLogin = loginFlag == 1 && !TeabzbaAppStorage.teabzbaUserToken.isEmpty

    if hasLogin {
      let route = await waknxaPaksHeaterRegistrationAndRedirect()

      nextRoute = route
    } else {
      await handleLocationFlow(decryptedData)
    }
  }

  //校验响应
  private func isResponseValid() -> Bool {
    guard let res = wyneBassUnionInitUtils.waknxaPaksApiCallRes else {
      return false
    }
    print(res)
    return (res["code"] as? String) == "0000"
  }

  //解密数据
  private func decryptResult() -> [String: Any] {
    // 分步解包，明确每个可选值的处理，避免链式解包导致的类型判断错误
    // 1. 先获取可选的 result 字符串
    guard let resultString = wyneBassUnionInitUtils.waknxaPaksApiCallRes?["result"] as? String
    else {
      return [:]
    }

    // 2. 解密（这里假设 suahwhxmaAlsaBDecrypt() 返回的是非可选 String，所以不用 guard let）
    let decryptedString = resultString.suahwhxmaAlsaBDecrypt()

    // 3. 将解密后的字符串转为 Data（utf8 转换可能失败，所以用 guard let）
    guard let jsonData = decryptedString.data(using: .utf8) else {
      return [:]
    }

    // 4. 解析 JSON 为字典
    guard let resultDict = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any]
    else {
      return [:]
    }
    return resultDict
  }

  //处理定位流程
  private func handleLocationFlow(_ decryptedData: [String: Any]) async {

    let locationFlag = decryptedData["locationFlag"] as? Int ?? 0

    wyneBassUnionInitUtils.waknxaPaksIsGetLocation = (locationFlag == 1)

    if wyneBassUnionInitUtils.waknxaPaksIsGetLocation {
      _ = await XmaalwiDAiLocationManager.shared.waknxaPaksCheckAndRequestLocation()
    }

    updateStatus(.xmaalwiDAiB)
  }

  //✅ 7️⃣ 失败状态
  private func setFailureStatus() {
    updateStatus(.xmaalwiDAiA)
  }

  //✅ 8️⃣ 成功跳转
  func waknxaPaksHeaterRegistrationAndRedirect() async -> AppRoute {
    let url = WaknxaPaksInformationCreate.buildH5Url(
      baseUrl: TeabzbaAppStorage.teabzbaH5Url,
      token: TeabzbaAppStorage.teabzbaUserToken
    )
    return AppRoute.agreementWeb(webUrl: url)
  }

  //✅ 9️⃣ 状态更新
  private func updateStatus(_ status: MelodyMateInitType) {
    waknxaPaksStatus = status
  }

  // 初始化流程（等价 initState）
  func waknxaPaksInitFlow() async {
    // 修复点1：处理日期组件的可选值（原代码强制解包! 有崩溃风险）
    guard
      let targetDate = Calendar.current.date(
        from: DateComponents(
          year: 2026, month: 3, day: 6, hour: 12
        ))
    else {
      // 日期解析失败时的兜底逻辑
      updateStatus(.xmaalwiDAiA)
      return
    }

    // 修复点2：替换不存在的 isBefore 方法（用 Date 的比较运算符实现）
    let currentDate = Date()
    let isTimeOver = !(currentDate < targetDate)  // currentDate >= targetDate 即时间已过

    if !isTimeOver {
      updateStatus(.xmaalwiDAiA)
      return
    }
    TeabzbaAppStorage.teabzbaIsB = false
    if !TeabzbaAppStorage.teabzbaIsB {
      await bundPithLoveBInit()

    } else {
      updateStatus(.xmaalwiDAiB)
    }
  }
}
