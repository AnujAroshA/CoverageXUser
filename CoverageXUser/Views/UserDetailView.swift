//
//  UserDetailView.swift
//  CoverageXUser
//
//  Created by Arosha Piyadigama on 2025-08-07.
//

import SwiftUI

struct UserDetailView: View {
    let user: User

    var body: some View {
        VStack(spacing: 20) {
            AsyncImage(url: URL(string: user.picture.large)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 150, height: 150)
            .clipShape(Circle())

            Text(user.name.fullName).font(.title2).bold()
            Text(user.email)
            Text(user.phone)

            Spacer()
        }
        .padding()
        .navigationTitle("Details")
    }
}

#Preview {
    UserDetailView(user: User(
        id: .init(name: "SSN", value: "0001"),
        name: .init(title: "Ms", first: "Jane", last: "Doe"),
        email: "jane.doe@example.com",
        phone: "123-456-7890",
        picture: .init(thumbnail: "https://randomuser.me/api/portraits/thumb/women/1.jpg",
                       large: "https://randomuser.me/api/portraits/women/1.jpg")
    ))
}

