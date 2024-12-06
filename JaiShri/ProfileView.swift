import SwiftUI

struct Val: Identifiable {
    var id: Int
    var name: String
    var image: String
}

struct ProfileView: View {
    @State private var search: String = ""
    @State private var array: [Val] = [] // Updated to dynamically fetch data
    @State private var isLoading = true

    var filteredArray: [Val] {
        if search.isEmpty {
            return array
        } else {
            return array.filter { $0.name.localizedCaseInsensitiveContains(search) }
        }
    }

    var body: some View {
        VStack {
            // Navigation Link Example
        
            // Search Field
            CustomTextField(
                placeholder: "Search",
                text: $search,
                isSecure: false
            )
            .padding(.vertical)

            // Loading State
            if isLoading {
                ProgressView("Loading...")
            } else {
                // List of Items
                List {
                    ForEach(filteredArray) { item in
                        HStack(spacing: 10) {
                            AsyncImage(url: URL(string: item.image)) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                } else if phase.error != nil {
                                    // Error loading image
                                    Color.red
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                } else {
                                    // Placeholder while loading
                                    ProgressView()
                                        .frame(width: 50, height: 50)
                                }
                            }
                            Text(item.name)
                                .font(.headline)
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        .padding()
        .onAppear(perform: fetchData)
    }

    // Fetch Data Function
    private func fetchData() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos/") else {
            print("Invalid URL")
            return
        }

        isLoading = true
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let todos = try JSONDecoder().decode([Todo].self, from: data)
                DispatchQueue.main.async {
                    array = todos.map {
                        Val(id: $0.id, name: $0.title, image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQKGvxtr7vmYvKw_dBgBPf98isHM4Cz6REorg&s") // Dummy image URL
                    }
                    isLoading = false
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }.resume()
    }
}

// Codable Struct to Decode API Response
struct Todo: Codable, Identifiable {
    let id: Int
    let title: String
    let completed: Bool
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .previewDevice("iPhone 14 Pro")
    }
}
