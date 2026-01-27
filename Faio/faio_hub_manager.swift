import SwiftUI

@MainActor
final class FaioHUDManager: ObservableObject {

    static let shared = FaioHUDManager()

    @Published var toast: FaioToast?
    @Published var isLoading: Bool = false

    private init() {}

    func showToast(
        _ text: String,
        type: FaioToastType = .normal,
        duration: TimeInterval = 1.8
    ) {
        toast = FaioToast(text: text, type: type)

        Task {
            try? await Task.sleep(nanoseconds: UInt64(duration * 1_000_000_000))
            self.toast = nil
        }
    }

    func showLoading() {
        isLoading = true
    }

    func hideLoading() {
        isLoading = false
    }
}

enum FaioHUD {

    static func toast(_ text: String) {
        Task { @MainActor in
            FaioHUDManager.shared.showToast(text)
        }
    }

    static func success(_ text: String) {
        Task { @MainActor in
            FaioHUDManager.shared.showToast(text, type: .success)
        }
    }

    static func error(_ text: String) {
        Task { @MainActor in
            FaioHUDManager.shared.showToast(text, type: .error)
        }
    }

    static func showLoading() {
        Task { @MainActor in
            FaioHUDManager.shared.showLoading()
        }
    }

    static func hideLoading() {
        Task { @MainActor in
            FaioHUDManager.shared.hideLoading()
        }
    }
}

struct FaioHUDView: View {

    @ObservedObject private var hud = FaioHUDManager.shared

    var body: some View {
        ZStack {

            // Loading
            if hud.isLoading {
                VStack(spacing: 12) {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .scaleEffect(1.4)
                        .foregroundColor(.white)
                    Text("loading...").foregroundColor(.white)
                }.padding(.horizontal, 24)
                    .padding(.vertical, 20)
                    .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.black.opacity(0.8))
                )
                
            }

            // Toast
            if let toast = hud.toast {
                VStack {
                    Spacer()
                    HStack(spacing: 8) {

                        if let icon = toast.type.icon {
                            Image(systemName: icon)
                                .foregroundColor(.white)
                        }

                        Text(toast.text)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 14)
                    .background(toast.type.backgroundColor)
                    .cornerRadius(20)
                    .transition(.opacity.combined(with: .move(edge: .top)))

                    Spacer()
                }
            }
        }
        .animation(.easeInOut, value: hud.isLoading)
    }
}

enum FaioToastType {
    case normal
    case success
    case error

    var backgroundColor: Color {
        switch self {
        case .normal:
            return .black.opacity(0.85)
        case .success:
            return .green.opacity(0.9)
        case .error:
            return .red.opacity(0.9)
        }
    }

    var icon: String? {
        switch self {
        case .success:
            return "checkmark.circle.fill"
        case .error:
            return "xmark.octagon.fill"
        default:
            return nil
        }
    }
}

struct FaioToast {
    let text: String
    let type: FaioToastType
}
