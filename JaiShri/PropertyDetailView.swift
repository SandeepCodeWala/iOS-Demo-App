import SwiftUI

// Define the Property struct to hold the details
struct Property1: Identifiable, Hashable {
    let id = UUID() // Conform to Identifiable
    let image: String
    let price: String
    let amenities: [String]
    let description: String
    let location: String
}

// Static data for the property
let propertyData = Property1(
    image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRyghUkHrZsxR1GhHHAIBohnm7SPmFYYJ9QAw&s",
    price: "$250,000",
    amenities: ["2 Beds", "1 Bath", "1200 sqft", "Garage"],
    description: "This cozy property is located in a peaceful neighborhood with ample space and modern amenities. Perfect for a small family looking for comfort and convenience.",
    location: "1234 Elm Street, Springfield, IL"
)

// PropertyDetailView to show the details of the selected property
struct PropertyDetailView: View {


    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Property Image
                AsyncImage(url: URL(string: propertyData.image)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: 250)
                            .clipped()
                    } else if phase.error != nil {
                        Color.red // Placeholder for error
                    } else {
                        Color.gray // Placeholder while loading
                    }
                }
                .cornerRadius(8)

                // Property Price
                Text(propertyData.price)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)

                // Property Location
                Text(propertyData.location)
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                // Property Description
                Text(propertyData.description)
                    .font(.body)
                    .foregroundColor(.primary)
                    .padding(.top, 10)

                // Amenities List
                VStack(alignment: .leading, spacing: 10) {
                    Text("Amenities:")
                        .font(.headline)

                    ForEach(propertyData.amenities, id: \.self) { amenity in
                        Text(amenity)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.top, 20)
            }
            .padding()
        }
        .navigationTitle("Property Details")
        .navigationBarTitleDisplayMode(.inline)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
        )
    }
}

// Preview of the PropertyDetailView with static data
struct PropertyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PropertyDetailView()
        }
    }
}
