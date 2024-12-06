import SwiftUI

struct Person: Identifiable {
    var id: Int
    var name: String
    var image: String
}

struct HomeView: View {
    // Dynamic data array with @State
    @State private var items = [
        Person(id: 0, name: "Sandeep", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOuxrvcNMfGLh73uKP1QqYpKoCB0JLXiBMvA&s"),
        Person(id: 1, name: "Sandy", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOuxrvcNMfGLh73uKP1QqYpKoCB0JLXiBMvA&s"),
        Person(id: 2, name: "Praveen", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOuxrvcNMfGLh73uKP1QqYpKoCB0JLXiBMvA&s"),
        Person(id: 3, name: "Shubham", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOuxrvcNMfGLh73uKP1QqYpKoCB0JLXiBMvA&s")
    ]

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: LoginView()) {
                    Text("Welcome to Home!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .padding(.top)
                }

                List {
                    ForEach(items) { item in
                        HStack(spacing: 15) {
                            AsyncImage(url: URL(string: item.image)) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                } else if phase.error != nil {
                                    Image(systemName: "person.circle.fill")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(.gray)
                                } else {
                                    ProgressView()
                                        .frame(width: 50, height: 50)
                                }
                            }

                            Text(item.name)
                                .font(.headline)
                                .foregroundColor(.primary)
                        }
                        .onTapGesture {
                            editItem(item)
                        }
                    }
                    .onDelete(perform: deleteItems) // Enable swipe-to-delete
                }
                .listStyle(PlainListStyle())
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: addItem) {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .safeAreaInset(edge: .bottom) {
                Spacer()
                    .frame(height: 10)
//                    .background(.white)
            }
            .padding(.horizontal)
            .background(.white)
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    // Add a new item
    private func addItem() {
        let newItem = Person(id: (items.last?.id ?? 0) + 1, name: "New Person", image: "https://via.placeholder.com/50")
        items.append(newItem)
    }

    // Edit an item (for simplicity, changes the name to "Edited")
    private func editItem(_ person: Person) {
        if let index = items.firstIndex(where: { $0.id == person.id }) {
            items[index].name = "no \(person.name)"
        }
    }

    // Delete items
    private func deleteItems(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .previewDevice("iPhone 14 Pro")
    }
}
