//
//  uqyaxhs_gabto_b_api_call.swift
//  Faio
//
//  Created by yangyang on 2026/2/25.
//

import AdjustSdk
import Alamofire
import Foundation
import StoreKit

final class UgZhyaiwLDKalApiCall {

  // MARK: - Base URL
  private let baseURL = "https://opi.wk3ht8ti.link"

  // MARK: - Headers
  private var headers: HTTPHeaders {
    [
      "Content-Type": "application/json",
      "appVersion": WaknxaPaksInformationCreate.waknxaPaksH5UrlrmationVersion,
      "deviceNo": GhwbAMaldwiBInfo.getDevid,
      "pushToken": TeabzbaAppStorage.teabzbaPushToken,
      "loginToken": TeabzbaAppStorage.teabzbaUserToken,
      "appId": WaknxaPaksInformationCreate.waknxaPaksAppId,
    ]
  }

  // MARK: - Session
  private lazy var session: Session = {
    let configuration = URLSessionConfiguration.default
    configuration.headers = .default
    return Session(configuration: configuration)
  }()
}

extension UgZhyaiwLDKalApiCall {

  func ugZhyaiwLDKalPayCall(
    purchaseID: String,
    serverVerificationData: String,
    orderCode: String
  ) async throws -> Bool {

    let body: [String: Any] = [
      "cvrAuxalEIt": purchaseID,
      "mbeYAbxakp": serverVerificationData,
      "yejaqnAUwnfc": try jsonString(["orderCode": orderCode]),
    ]
    print("payload: \(body)")

    let data = try await request(
      path: "/opi/v1/eoeiuqAhwnaldp",
      body: body
    )
    print("pay code: \(data?["code"] ?? "null")")

    return data?["code"] as? String == "0000"
  }

  func waitForAdjustAttribution() async -> ADJAttribution {
    await withCheckedContinuation { continuation in
      Adjust.attribution { attribution in
        if let attribution {
          continuation.resume(returning: attribution)
        }
        // ⚠️ nil 什么都不做，继续等
      }
    }
  }

  func ugZhyaiwLDKalGetDf() async throws -> [String: Any]? {

    let phoneInfo = WaknxaPaksGetPhoneInfo.shared
//    let attribution = await waitForAdjustAttribution()
//
//      let adxciwnaAtai: [String: Any] = [
//      "trackerToken": attribution.trackerToken ?? "",
//      "trackerName": attribution.trackerName ?? "",
//      "network": attribution.network ?? "",
//      "campaign": attribution.campaign ?? "",
//      "adgroup": attribution.adgroup ?? "",
//      "creative": attribution.creative ?? "",
//      "clickLabel": attribution.clickLabel ?? "",
//      "costType": attribution.costType ?? "",
//      "costAmount": attribution.costAmount ?? "",
//      "costCurrency": attribution.costCurrency ?? "",
//      "fbInstallReferrer": attribution.jsonResponse ?? ""
//    ]
//
//    let jsonString = try? String(
//      data: JSONSerialization.data(withJSONObject: adxciwnaAtai),
//      encoding: .utf8
//    )

    let body: [String: Any] = [
      "cuenaAUnalkAd": 1,
      "cuenAHnxalHDuwan": phoneInfo.isVpnActive,
      "CeyZHakfge": phoneInfo.languages,
      "CneazUAllrs": phoneInfo.coverAppList,
      "EIUqpnzt": phoneInfo.timezone,
      "Cejauwlrk": phoneInfo.keyboards,
//      "JDautiAUlkdjga": jsonString ?? "", // 归因参数
      "debug": 1,
    ]
    print("headers: \(headers)")
    print(body)

    return try await request(
      path: "/opi/v1/rtoqwuAHwnao",
      body: body
    )
  }

  func ugZhyaiwLDKalQuickLogin() async throws -> [String: Any]? {

    let phoneInfo = WaknxaPaksGetPhoneInfo.shared

    let adjustID = await Adjust.adid()
    var body: [String: Any] = [
      "UWuyabASkada": adjustID ?? "",  // adjust ID
      "AwyuvAUldIRsad": GhwbAMaldwiBInfo.getPassword,  // password
      "OeuavAKjdsan": GhwbAMaldwiBInfo.getDevid,
      "FyqajglauwDev": [
        "countryCode": phoneInfo.countryCode,
        "latitude": phoneInfo.latitude,
        "longitude": phoneInfo.longitude,
      ],
    ]

    if !GhwbAMaldwiBInfo.getPassword.isEmpty {
      body["oeAHjwbnaydd"] = GhwbAMaldwiBInfo.getPassword
    }

    print(body)
    print("headers: \(headers)")

    return try await request(
      path: "/opi/v1/jsuwLAjwyalktl",
      body: body
    )
  }

  func ugZhyaiwLDKalLoadingTimeRecord(_ loadingTime: Int) async throws -> [String: Any]? {

    let body: [String: Any] = [
      "AuwoqktsWEswo": "\(loadingTime)"
    ]

    return try await request(
      path: "/opi/v1/siepAJLwhayt",
      body: body
    )
  }
}

extension UgZhyaiwLDKalApiCall {

  fileprivate func request(
    path: String,
    body: [String: Any]
  ) async throws -> [String: Any]? {

    let jsonData = try JSONSerialization.data(withJSONObject: body)

    guard let jsonString = String(data: jsonData, encoding: .utf8) else {
      return nil
    }

    // 🔐 AES CBC 加密 → hex
    let encryptedString = jsonString.suahwhxmaAlsaBEncode()

    let response = try await session.request(
      baseURL + path,
      method: .post,
      parameters: nil,
      encoding: RawStringEncoding(string: encryptedString),
      headers: headers
    )
    .serializingData()
    .value

    return try parseResponse(response)
  }

  fileprivate func parseResponse(_ data: Data) throws -> [String: Any]? {
    let object = try JSONSerialization.jsonObject(with: data)

    if let dict = object as? [String: Any] {
      return dict
    }

    if let string = object as? String,
      let data = string.data(using: .utf8)
    {
      return try JSONSerialization.jsonObject(with: data) as? [String: Any]
    }

    return nil
  }

  fileprivate func jsonString(_ dict: [String: Any]) throws -> String {
    let data = try JSONSerialization.data(withJSONObject: dict)
    return String(data: data, encoding: .utf8) ?? ""
  }
}

struct RawStringEncoding: ParameterEncoding {

  let string: String

  func encode(
    _ urlRequest: URLRequestConvertible,
    with parameters: Parameters?
  ) throws -> URLRequest {

    var request = try urlRequest.asURLRequest()
    request.httpBody = string.data(using: .utf8)
    return request
  }
}
