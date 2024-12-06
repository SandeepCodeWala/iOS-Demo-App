import SwiftUI

// Step 2: ProfileView that will receive properties and display them
struct ProfileView: View {
    let title: String
    let properties: [Property]

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ScrollView {
                // Chunk the properties into rows of 2
                let chunkedProperties = properties.chunked(into: 2)

                ScrollView(.horizontal, showsIndicators: false) {
                    VStack(spacing: 15) {
                        ForEach(properties) { property in
                            PropertyCard(property: property)
                        }
                    }
                }
              
            }
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
        )
    }
}

// Step 5: PropertyCard1 view for displaying each property

// Step 6: ProfileView preview
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView(
                title: "Recently Posted",
                properties: [
                    Property(image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRyghUkHrZsxR1GhHHAIBohnm7SPmFYYJ9QAw&s", price: "$250,000", amenities: ["2 Beds", "1 Bath", "1200 sqft", "Garage"]),
                    Property(image: "https://st.hzcdn.com/simgs/pictures/exteriors/photoshoot-for-varija-bajaj-home-deepak-aggarwal-photography-img~d3f1ddf50c821b3a_14-3052-1-b651bb8.jpg", price: "$300,000", amenities: ["3 Beds", "2 Bath", "1500 sqft", "Pool"]),
                    Property(image: "https://cdn.buildofy.com/projects/443731c2-e5e5-4b3e-a212-9ae14ace0dc9.jpeg", price: "$180,000", amenities: ["1 Bed", "1 Bath", "800 sqft", "Garden"]),
                    Property(image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwpStuXH1oDVnnO64iGcsR1GVXTcjTA7hyKekXLlgU03C3D2xo6c8ABIjGR-T_Njh95XA&usqp=CAU", price: "$500,000", amenities: ["4 Beds", "3 Bath", "2500 sqft", "Pool"]),
                ]
            )
        }
    }
}
