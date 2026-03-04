import SwiftUI
import CoreLocation

struct EtzbzaLocationDailog: View {

    @Binding var pwovzaIsShowAlert: Bool
    @Environment(\.scenePhase) private var scenePhase
    
    @State private var isCheckingSettings = false
    
    func goToSettings() {
            isCheckingSettings = true
            
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            UIApplication.shared.open(url)
        }

    func checkLocationPermissionAndClose() {
        let manager = CLLocationManager()
        let status = manager.authorizationStatus
        
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            pwovzaIsShowAlert = false
        }
    }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack {
                Spacer()

                Text("This app needs location access for sharing, discovering events, and using location-based features. Location data is used responsibly with your consent. Privacy and security are our priorities.")
                    .font(.system(size: 16))
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .padding(.bottom, 34)

                FeqocnButton(
                    feqocnText: "Go to settings",
                    action: {
                        goToSettings()
                    }
                )
                .padding(.bottom, 20)
            }
            .padding(.horizontal, 20)

            Circle()
                .fill(.black)
                .frame(width: 40, height: 40)
                .overlay {
                    Image("vnzwa_icon_close")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                .onTapGesture {
                    pwovzaIsShowAlert = false
                }
                .padding(12)
        }
        .frame(height: 292)
        .background(
            ZStack {
                LinearGradient(
                    colors: [VawinvTheme.FaioColor.yellow, VawinvTheme.FaioColor.orange],
                    startPoint: .leading,
                    endPoint: .trailing
                )
                LinearGradient(
                    colors: [.white, .white.opacity(0.3)],
                    startPoint: .bottom,
                    endPoint: .top
                )
            }
        )
        .cornerRadius(20)
        .frame(width: 315)
        // 👇 监听前后台变化（等价 Flutter didChangeAppLifecycleState）
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active && isCheckingSettings {
                isCheckingSettings = false
                
                // 可选：重新检查权限
                checkLocationPermissionAndClose()
            }
        }
    }
}
