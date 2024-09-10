//
//  SpotifyPlaylistView.swift
//  SwiftUIPractices
//
//  Created by Yunus Emre Berdibek on 14.04.2024.
//

import SwiftfulRouting
import SwiftfulUI
import SwiftUI

struct SpotifyPlaylistView: View {
    var user: User = .mock
    var product: Product = .mock

    @Environment(\.router) var router
    @State private var products: [Product] = []
    @State private var showHeader: Bool = true

    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()

            ScrollView(.vertical) {
                LazyVStack(spacing: 12) {
                    PlaylistHeaderCell(
                        title: product.title,
                        subtitle: product.brand,
                        imageName: product.thumbnail,
                        height: 250
                    )
                    .readingFrame { frame in
                        showHeader = frame.maxY < 150
                    }

                    PlaylistDescriptionCell(
                        descriptionText: product.description,
                        username: user.firstName,
                        subheadline: product.category,
                        onAddToPlaylistAction: nil,
                        onDownloadAction: nil,
                        onShareAction: nil,
                        onEllipsisAction: nil,
                        onShuffleAction: nil,
                        onPlayAction: nil
                    )
                    .padding(.horizontal, 16)

                    ForEach(products) { product in
                        SongRowCell(
                            imageSize: 75,
                            imageName: product.firstImage,
                            title: product.title,
                            subtitle: product.brand,
                            onCellAction: {
                                goToPlaylistView(product: product)
                            },
                            onEllipsesAction: nil
                        )
                        .padding(.leading)
                    }
                }
            }
            .scrollIndicators(.hidden)

            headerView
                .frame(maxHeight: .infinity, alignment: .top)
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    private func getData() async {
        do {
            products = try await Array(DatabaseHelper().getproducts())

        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func goToPlaylistView(product: Product) {
        router.showScreen(.push) { _ in
            SpotifyPlaylistView(user: user, product: product)
        }
    }
}

extension SpotifyPlaylistView {
    private var headerView: some View {
        ZStack {
            Text(product.title)
                .font(.headline)
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                .background(.spotifyBlack)
                .offset(y: showHeader ? 0 : -40)
                .opacity(showHeader ? 1 : 0)

            Image(systemName: "chevron.left")
                .font(.title3)
                .padding(10)
                .background(showHeader ? .black.opacity(0.001) : .spotifyGray.opacity(0.7))
                .clipShape(.circle)
                .onTapGesture {
                    router.dismissScreen()
                }
                .padding(.leading, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .foregroundStyle(.spotifyWhite)
        .animation(.smooth(duration: 0.2), value: showHeader)
    }
}

#Preview {
    RouterView { _ in
        SpotifyPlaylistView()
    }
}
