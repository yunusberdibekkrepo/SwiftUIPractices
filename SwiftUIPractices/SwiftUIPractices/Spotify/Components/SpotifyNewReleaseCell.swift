//
//  SpotifyNewReleaseCell.swift
//  SwiftUIPractices
//
//  Created by Yunus Emre Berdibek on 13.04.2024.
//

import SwiftUI

struct SpotifyNewReleaseCell: View {
    var imageName: String = Constants.randomImage
    var headline: String? = "New release from"
    var subheadline: String? = "Some Artist"
    var title: String? = "Some Playlist"
    var subtitle: String? = "Single - title"
    var onAddToPlaylistAction: (() -> Void)? = nil
    var onPlayAction: (() -> Void)? = nil

    var body: some View {
        VStack(spacing: 16) {
            HStack(content: {
                ImageLoaderView(urlString: imageName)
                    .frame(width: 50, height: 50)
                    .clipShape(.circle)

                VStack(alignment: .leading, spacing: 2, content: {
                    if let headline {
                        Text(headline)
                            .foregroundStyle(.spotifyLightGray)
                            .font(.callout)
                    }

                    if let subheadline {
                        Text(subheadline)
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundStyle(.spotifyWhite)
                    }

                })
            })
            .frame(maxWidth: .infinity, alignment: .leading)

            HStack(content: {
                ImageLoaderView(urlString: imageName)
                    .frame(width: 140, height: 140)

                VStack(alignment: .leading, spacing: 32, content: {
                    VStack(alignment: .leading, spacing: 2, content: {
                        if let title {
                            Text(title)
                                .fontWeight(.semibold)
                                .foregroundStyle(.spotifyWhite)
                        }

                        if let subtitle {
                            Text(subtitle)
                                .foregroundStyle(.spotifyLightGray)
                        }
                    })
                    .font(.callout)

                    HStack(content: {
                        Image(systemName: "plus.circle")
                            .foregroundStyle(.spotifyLightGray)
                            .font(.title3)
                            .padding(4)
                            .background(.black.opacity(0.0001))
                            .onTapGesture {
                                onAddToPlaylistAction?()
                            }
                            .offset(x: -4)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Image(systemName: "play.circle.fill")
                            .foregroundStyle(.spotifyWhite)
                            .font(.title)
                    })
                })
                .padding(.trailing, 16)
            })
            .themeColors(isSelected: false)
            .cornerRadius(8)
            .onTapGesture {
                onPlayAction?()
            }
        }
    }
}

#Preview {
    ZStack(content: {
        Color.black.ignoresSafeArea()

        SpotifyNewReleaseCell()
            .padding()
    })
}
