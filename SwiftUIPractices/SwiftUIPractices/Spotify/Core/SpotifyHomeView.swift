//
//  SpotifyHomeView.swift
//  SwiftUIPractices
//
//  Created by Yunus Emre Berdibek on 11.04.2024.
//

import SwiftfulRouting
import SwiftfulUI
import SwiftUI

struct SpotifyHomeView: View {
    @Environment(\.router) var router

    @State private var currentUser: User? = nil
    @State private var selectedCategory: Category? = nil
    @State private var products: [Product] = []
    @State private var productRows: [ProductRow] = []

    var body: some View {
        ZStack(content: {
            Color.spotifyBlack.ignoresSafeArea()

            ScrollView {
                LazyVStack(spacing: 1,
                           pinnedViews: [.sectionHeaders],
                           content: {
                               Section {
                                   VStack(spacing: 16, content: {
                                       recentsSection
                                           .padding(.horizontal, 16)

                                       if let product = products.first {
                                           newReleaseSection(product: product)
                                               .padding(.horizontal, 16)
                                       }
                                   })

                                   listRows
                               } header: {
                                   header
                               }
                           })
                           .padding(.top, 8)
            }
            .scrollIndicators(.hidden)
            .clipped()
        })
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    private func getData() async {
        guard products.isEmpty else { return }

        do {
            currentUser = try await DatabaseHelper().getUsers().first
            products = try await Array(DatabaseHelper().getproducts().prefix(8))

            var rows: [ProductRow] = []
            let allBrands = Set(products.map { $0.brand })

            for brand in allBrands {
                rows.append(.init(title: brand.capitalized, products: products))
            }

            productRows = rows

        } catch {
            print(error.localizedDescription)
        }
    }

    private func goToPlaylistView(product: Product) {
        guard let currentUser else { return }
        router.showScreen(.push) { _ in
            SpotifyPlaylistView(user: currentUser, product: product)
        }
    }
}

extension SpotifyHomeView {
    private var header: some View {
        HStack(spacing: 0, content: {
            ZStack(content: {
                if let currentUser {
                    ImageLoaderView(urlString: currentUser.image)
                        .background(.spotifyWhite)
                        .clipShape(.circle)
                        .onTapGesture {
                            router.dismissScreen()
                        }
                }
            })
            .frame(width: 30, height: 30)

            ScrollView(.horizontal) {
                HStack(spacing: 8, content: {
                    ForEach(Category.allCases, id: \.self) { category in
                        SpotifyCategoryCell(
                            title: category.rawValue.capitalized,
                            isSelected: category == selectedCategory
                        )
                        .onTapGesture {
                            selectedCategory = category
                        }
                    }
                })
                .padding(.horizontal)
            }
            .scrollIndicators(.hidden)

        })
        .padding(.vertical, 24)
        .padding(.leading, 8)
        .background(.spotifyBlack)
    }

    private var recentsSection: some View {
        NonLazyVGrid(columns: 2, alignment: .center, spacing: 10, items: products) { product in
            if let product {
                SpotifyRecentsCell(
                    imageName: product.firstImage,
                    title: product.title
                )
                .asButton(.press) {
                    goToPlaylistView(product: product)
                }
            }
        }
    }

    private func newReleaseSection(product: Product) -> some View {
        SpotifyNewReleaseCell(
            imageName: product.firstImage,
            headline: product.brand,
            subheadline: product.category,
            title: product.title,
            subtitle: product.description
        ) {} onPlayAction: {
            goToPlaylistView(product: product)
        }
    }

    private var listRows: some View {
        ForEach(productRows) { row in
            VStack(spacing: 8, content: {
                Text(row.title)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.spotifyWhite)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)

                ScrollView(.horizontal) {
                    HStack(alignment: .top, spacing: 16, content: {
                        ForEach(row.products) { product in
                            ImageTitleRowCell(
                                imageSize: 120,
                                imageName: product.firstImage,
                                title: product.title
                            )
                            .asButton(.press) {
                                goToPlaylistView(product: product)
                            }
                        }
                    })
                    .padding(.horizontal, 16)
                }
                .scrollIndicators(.hidden)
            })
        }
    }
}

#Preview {
    RouterView { _ in
        SpotifyHomeView()
    }
}
