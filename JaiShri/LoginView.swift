import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var navigateTo: String? = nil  // State to track navigation
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20 ) {
                // Header Section
                Spacer()
                Text("Welcome Back!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                
                Text("Login to your account")
                    .font(.headline)
                    .foregroundColor(.gray)
                
                Spacer().frame(height: 20)
                
                // Email TextField
                CustomTextField(
                    placeholder: "Enter your email",
                    text: $email,
                    isSecure: false
                )
                
                // Password TextField
                CustomTextField(
                    placeholder: "Enter your password",
                    text: $password,
                    isSecure: true
                )
                
                // Forgot Password
                HStack {
                    Spacer()
                    Text("Forgot Password?")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                        .onTapGesture {
                            print("Forgot Password tapped")
                        }
                }
                
                // Login Button
                Button(action: loginButtonTapped) {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.blue, lineWidth: 5)
                        )
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .kerning(1.5)
                        .font(.headline)
                        .cornerRadius(12)
//                        .shadow(color: Color.black.opacity(0.2), radius: 16, x: 0, y: 4)
                }
               
                Text("or Login with")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                // Social Login Buttons
                HStack(spacing: 20) {
                    Button(action: googleLoginTapped) {
                        HStack {
                            Image("user") // Add this image to your assets
                                .resizable()
                                .frame(width: 24, height: 24)
                            Text("Google")
                                .font(.headline)
                                .foregroundColor(.black)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.blue, lineWidth: 1)
                        )
                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                    }
                    
                    Button(action: facebookLoginTapped) {
                        HStack {
                            Image("user") // Add this image to your assets
                                .resizable()
                                .frame(width: 24, height: 24)
                            
                            Text("Facebook")
                                .font(.headline)
                                .foregroundColor(.black)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.blue, lineWidth: 1)
                        )
                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                    }
                }
                
                HStack(spacing: 8) {
                    Text("Don't have an account?")
                        .font(.subheadline)
                        .foregroundColor(.black)
                    
                    NavigationLink(destination: SignUpView()) {
                        Text("Sign Up")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal, 26)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
            )
            .edgesIgnoringSafeArea(.all)
            
            // Handle navigation based on `navigateTo` value
            NavigationLink(
                            destination: HomeView(),
                            tag: "HomeView",
                            selection: $navigateTo
                        ) {
                            EmptyView()  // This is the invisible NavigationLink that triggers navigation
                        }
        }.navigationBarBackButtonHidden(true)
    }
    
    private func loginButtonTapped() {
        if email.isEmpty || password.isEmpty {
            print("Please fill in all fields")
        } else {
            print("Email: \(email), Password: \(password)")
            navigateTo = "HomeView" // Set navigateTo to trigger navigation
        }
    }
    
    private func googleLoginTapped() {
        print("Google login tapped")
    }
    
    private func facebookLoginTapped() {
        print("Facebook login tapped")
    }
}

struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    var isSecure: Bool
    
    var body: some View {
        Group {
            if isSecure {
                SecureField(placeholder, text: $text)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 1)
                    )
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
            } else {
                TextField(placeholder, text: $text)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 1)
                    )
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
            }
        }
    }
}


struct Login: PreviewProvider {
    static var previews: some View {
        Group {
            LoginView()
                .previewDevice("iPhone 14 Pro")
            
            LoginView()
                .previewDevice("iPhone SE (3rd generation)")
        }
    }
}
