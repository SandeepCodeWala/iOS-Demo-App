import SwiftUI

struct Property: Identifiable {
    let id = UUID()
    let image: String
    let price: String
    let amenities: [String]
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        guard size > 0 else { return [] }
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}

struct HomeView: View {
    let properties: [String: [Property]] = [
            "recent": [
                Property(image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRyghUkHrZsxR1GhHHAIBohnm7SPmFYYJ9QAw&s", price: "$250,000", amenities: ["2 Beds", "1 Bath", "1200 sqft", "Garage"]),
                Property(image: "https://st.hzcdn.com/simgs/pictures/exteriors/photoshoot-for-varija-bajaj-home-deepak-aggarwal-photography-img~d3f1ddf50c821b3a_14-3052-1-b651bb8.jpg", price: "$300,000", amenities: ["3 Beds", "2 Bath", "1500 sqft", "Pool"]),
            ],
            "most": [
                Property(image: "https://thumbs.dreamstime.com/b/luxury-big-modern-house-electric-car-luxury-modern-house-electric-car-141295838.jpg", price: "$180,000", amenities: ["1 Bed", "1 Bath", "800 sqft", "Garden"]),
                Property(image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwpStuXH1oDVnnO64iGcsR1GVXTcjTA7hyKekXLlgU03C3D2xo6c8ABIjGR-T_Njh95XA&usqp=CAU", price: "$500,000", amenities: ["4 Beds", "3 Bath", "2500 sqft", "Pool"]),
            ],
            "budget": [
                Property(image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOOs0c7CgVjNv_QcS9IRdUQOpx_wZKp5FAJQ&s", price: "$200,000", amenities: ["2 Beds", "2 Bath", "1300 sqft", "Garage"]),
                Property(image: "https://media.istockphoto.com/id/94222829/photo/property-in-vietnam.jpg?b=1&s=612x612&w=0&k=20&c=r8CnuE_OKuz_BZ2-2aq3BNcbCVhdkzAN5lbZjx7nP48=", price: "$220,000", amenities: ["3 Beds", "2 Bath", "1400 sqft", "Balcony"]),
            ],
            "alsoCheck": [
                Property(image: "https://img.etimg.com/thumb/width-1600,height-900,imgsize-22382,resizemode-75,msid-111780102/news/international/world-news/india-has-the-worlds-second-most-expensive-house-check-the-of-the-top-10-costliest-homes.jpg", price: "$400,000", amenities: ["3 Beds", "3 Bath", "2000 sqft", "Pool"]),
                Property(image: "https://www.greenscapegroup.co.in/wp-content/uploads/2022/11/GS-blog-6-Effective-ideas-to-add-a-luxury-touch-to-your-home-848x450.png", price: "$350,000", amenities: ["2 Beds", "2 Bath", "1800 sqft", "Garden"]),
            ]
        ]
    
    let banners = [
        "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500", "https://www.apimagazine.com.au/media/1002520/duplex.jpg", "https://images.pexels.com/photos/259588/pexels-photo-259588.jpeg?cs=srgb&dl=pexels-pixabay-259588.jpg&fm=jpg"
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Auto-scrolling banner view
                BannerView(images: banners)

                SectionView(title: "Recently Posted", properties: properties["recent"] ?? [])
                SectionView(title: "Mostly Viewed Property", properties: properties["most"] ?? [])
                SectionView(title: "Average Budget Property", properties: properties["budget"] ?? [])
                SectionView(title: "You Also Can Check", properties: properties["alsoCheck"] ?? [])
            }
            .padding()
        }
        .navigationTitle("Our Listed Property")
        .navigationBarTitleDisplayMode(.inline)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
        )
    }
}

struct BannerView: View {
    let images: [String]
    @State private var currentIndex = 0
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            TabView(selection: $currentIndex) {
                ForEach(images.indices, id: \.self) { index in
                    ZStack {
                        AsyncImage(url: URL(string: images[index])) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 200)
                                    .clipped().cornerRadius(10)
                            } else if phase.error != nil {
                                Color.red // Display a red placeholder in case of error
                            } else {
                                Color.gray // Display a gray placeholder while loading
                            }
                        }

                        // Top Sale Property Text
                        VStack(alignment: .leading) {
                            Spacer()
                            Text("Top Sale Property")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.black.opacity(0.5))
                                .cornerRadius(8)
                                .padding([.leading, .bottom], 16)
                        }
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .frame(height: 200)
            .onReceive(timer) { _ in
                withAnimation {
                    currentIndex = (currentIndex + 1) % images.count
                }
            }
        }
    }
}

struct SectionView: View {
    let title: String
    let properties: [Property]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                Spacer()
                NavigationLink(destination: ProfileView(title: title, properties: properties)) {
                    Text("View All")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(properties) { property in
                        PropertyCard(property: property)
                    }
                }
            }
        }
    }
}

import SwiftUI

struct PropertyCard: View {
    let property: Property

    var body: some View {
        NavigationLink(destination: PropertyDetailView()) {
        VStack(alignment: .leading, spacing: 8) {
            // Property image
         
                AsyncImage(url: URL(string: property.image)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 160, height: 100)
                            .clipped()
                    } else if phase.error != nil {
                        Color.red // Placeholder for error
                    } else {
                        Color.gray // Placeholder while loading
                    }
                }
                .cornerRadius(8)
                
                // Property price
                Text(property.price)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                // Amenities in two rows
                VStack(spacing: 4) {
                    HStack {
                        Text(property.amenities[0])
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(property.amenities[1])
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Text(property.amenities[2])
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(property.amenities[3])
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .frame(width: 160)
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
        }
    }
}
