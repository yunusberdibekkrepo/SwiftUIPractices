//
//  PlaylistDescriptionCell.swift
//  SwiftUIPractices
//
//  Created by Yunus Emre Berdibek on 15.04.2024.
//

import SwiftUI

struct PlaylistDescriptionCell: View {
    var descriptionText: String = Product.mock.description
    var username: String = "Yunus Emre"
    var subheadline: String = "Some headline goes here"
    var onAddToPlaylistAction: (() -> Void)? = nil
    var onDownloadAction: (() -> Void)? = nil
    var onShareAction: (() -> Void)? = nil
    var onEllipsisAction: (() -> Void)? = nil
    var onShuffleAction: (() -> Void)? = nil
    var onPlayAction: (() -> Void)? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(descriptionText)
                .foregroundStyle(.spotifyLightGray)
                .frame(maxWidth: .infinity, alignment: .leading)

            madeForYouSection

            Text(subheadline)

            buttonsRow
        }
        .font(.callout)
        .foregroundStyle(.spotifyLightGray)
    }
}

extension PlaylistDescriptionCell {
    private var madeForYouSection: some View {
        HStack(spacing: 8) {
            Image(systemName: "applelogo")
                .font(.title3)
                .foregroundStyle(.spotifyGreen)

            Text("Made for ") + Text(username)
                .bold()
                .foregroundStyle(.spotifyWhite)
        }
    }

    private var buttonsRow: some View {
        HStack(spacing: .zero) {
            HStack(spacing: 8) {
                Image(systemName: "plus.circle")
                    .padding(8)
                    .background(.black.opacity(0.001))
                    .onTapGesture {
                        onAddToPlaylistAction?()
                    }

                Image(systemName: "arrow.down.circle")
                    .padding(8)
                    .background(.black.opacity(0.001))
                    .onTapGesture {
                        onDownloadAction?()
                    }

                Image(systemName: "square.and.arrow.up")
                    .padding(8)
                    .background(.black.opacity(0.001))
                    .onTapGesture {
                        onShareAction?()
                    }

                Image(systemName: "ellipsis")
                    .padding(8)
                    .background(.black.opacity(0.001))
                    .onTapGesture {
                        onEllipsisAction?()
                    }
            }
            .offset(x: -8)
            .frame(maxWidth: .infinity, alignment: .leading)

            HStack(spacing: 8) {
                Image(systemName: "shuffle")
                    .font(.system(size: 24))
                    .background(.black.opacity(0.001))
                    .onTapGesture {
                        onShuffleAction?()
                    }

                Image(systemName: "play.circle.fill")
                    .font(.system(size: 46))
                    .background(.black.opacity(0.001))
                    .onTapGesture {
                        onPlayAction?()
                    }
            }
            .foregroundStyle(.spotifyGreen)
        }
        .font(.title2)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()

        PlaylistDescriptionCell()
            .padding()
    }
}
