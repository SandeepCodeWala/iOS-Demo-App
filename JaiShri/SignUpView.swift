import SwiftUI
import PhotosUI

struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var gender: String = "Male" // Default selection
    @State private var acceptTerms: Bool = false
    @State private var selectedHobby: String = ""
    @State private var profileImage: UIImage? = nil
    @State private var showImagePicker: Bool = false

    let hobbies = ["Cricket", "Football", "Tennis", "Hockey"]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Header Section
                    Spacer()
                    Text("Create an Account")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .padding(.top, 20)
                    
                    Spacer().frame(height: 0)
                    
            
                    // Profile Picture
                    VStack {
                        ZStack {
                            if let profileImage = profileImage {
                                Image(uiImage: profileImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                            } else {
                                Image("profileUser") // Replace with the name of your local asset
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                            }
                            
                            // Camera Icon
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    Image(systemName: "camera.fill")
                                        .font(.title3)
                                        .foregroundColor(.white)
                                        .padding(6)
                                        .background(Circle().fill(Color.black))
                                        .offset(x: 10, y: 10)
                                }
                            }
                        }
                        .frame(width: 100, height: 100)
                        .onTapGesture {
                            showImagePicker.toggle()
                        }
                    }

                    .onTapGesture {
                        showImagePicker.toggle()
                    }

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
                    
                    // Confirm Password TextField
                    CustomTextField(
                        placeholder: "Confirm your password",
                        text: $confirmPassword,
                        isSecure: true
                    )
                    
                    // Gender Radio Buttons
                    HStack(spacing: 10) {
                        Text("Gender:")
                            .font(.headline)
                        
                        
                        RadioButton(text: "Male", isSelected: $gender.wrappedValue == "Male") {
                            gender = "Male"
                        }
                        
                        RadioButton(text: "Female", isSelected: $gender.wrappedValue == "Female") {
                            gender = "Female"
                        }
                    }.frame(maxWidth: .infinity, alignment: .leading)      // Align the label to the left
             

                    // Hobbies Dropdown
                    VStack(alignment: .leading) {
                        Text("Select Game:")
                            .font(.headline)
                        
                        Menu {
                            ForEach(hobbies, id: \.self) { hobby in
                                Button(hobby) {
                                    selectedHobby = hobby
                                }
                            }
                        } label: {
                            HStack {
                                Text(selectedHobby.isEmpty ? "Choose a game" : selectedHobby)
                                    .foregroundColor(.black)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.gray)
                            }
                            .padding()
//                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.blue))
                        }
                    }
                    
                    // Accept Terms Checkbox
                    
                    HStack {
                        Button(action: {
                            acceptTerms.toggle()
                        }) {
                            Image(systemName: acceptTerms ? "checkmark.square" : "square")
                                .foregroundColor(.blue)
                        }
                        
                        Text("I accept the Terms and Conditions")
                            .font(.subheadline)
                    }
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Sign Up Button
                    Button(action: signUpButtonTapped) {
                        Text("Sign Up")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .kerning(1.5)
                            .fontWeight(.bold)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.blue, lineWidth: 5)
                            )
                            .background(.white)
                            .foregroundColor(.black)
                            .font(.headline)
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.2), radius: 6, x: 0, y: 4)
                    }
                    .disabled(!acceptTerms) // Disable button until terms are accepted
                    
                    HStack(spacing: 8) {
                        Text("Already have an account?")
                            .font(.subheadline)
                        
                        NavigationLink(destination: LoginView()) {
                            Text("Sign In")
                                .font(.subheadline)
                                .foregroundColor(.blue)
                                .fontWeight(.bold)
                        }
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 26)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
                )
            }
//            .edgesIgnoringSafeArea(.all)
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(selectedImage: $profileImage)
            }
            
        }.navigationBarBackButtonHidden(true)
    }

    private func signUpButtonTapped() {
        if email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            print("Please fill in all fields")
        } else if password != confirmPassword {
            print("Passwords do not match")
        } else if selectedHobby.isEmpty {
            print("Please select a hobby")
        } else {
            print("Sign Up Successful: \(email), Gender: \(gender), Hobby: \(selectedHobby)")
        }
    }
}

// Reusable Components
struct RadioButton: View {
    var text: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        HStack {
            Button(action: action) {
                Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                    .foregroundColor(.blue)
            }
            Text(text)
        }
    }
}

// Image Picker
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            guard let provider = results.first?.itemProvider, provider.canLoadObject(ofClass: UIImage.self) else { return }

            provider.loadObject(ofClass: UIImage.self) { image, _ in
                DispatchQueue.main.async {
                    self.parent.selectedImage = image as? UIImage
                }
            }
        }
    }
}

struct Signup: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .previewDevice("iPhone 14 Pro")
    }
}
