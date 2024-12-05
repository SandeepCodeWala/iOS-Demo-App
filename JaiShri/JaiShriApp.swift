import SwiftUI

@main
struct JaiShriApp: App {
    @State private var showSplash = true

    var body: some Scene {
        WindowGroup {
            if showSplash {
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            showSplash = false
                        }
                    }
            } else {
                LoginView()
            }
        }
    }
}

struct SplashView: View {
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack {
                Image("logo") // Replace with your asset name
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200) // Adjust as needed
                Text("IOS Demo App")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.orange)
            }
        }
    }
}
