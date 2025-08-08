//
//  UserListView.swift
//  CoverageXUser
//
//  Created by Arosha Piyadigama on 2025-08-07.
//

import SwiftUI

struct UserListView: View {
    @StateObject private var viewModel = UserListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)").foregroundColor(.red)
                } else {
                    List(viewModel.filteredUsers) { user in
                        NavigationLink(destination: UserDetailView(user: user)) {
                            HStack {
                                AsyncImage(url: URL(string: user.picture.thumbnail)) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                                
                                Text(user.name.fullName)
                            }
                        }
                    }
                    .searchable(text: $viewModel.searchText)
                    .refreshable {
                        viewModel.fetchUsers()
                    }
                }
            }
            .navigationTitle("Users")
        }
        .onAppear {
            viewModel.fetchUsers()
        }
    }
}

#Preview {
    UserListView()
}
