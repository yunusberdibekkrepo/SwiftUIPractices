//
//  PlaylistHeaderCell.swift
//  SwiftUIPractices
//
//  Created by Yunus Emre Berdibek on 14.04.2024.
//

import SwiftfulUI
import SwiftUI

struct PlaylistHeaderCell: View {
    var title: String = "Some Playlist Title Goes Here"
    var subtitle: String = "Subtitle goes here"
    var imageName: String = Constants.randomImage
    var height: CGFloat = 300
    var shadowColor: Color = .spotifyBlack.opacity(0.8)

    var body: some View {
        Rectangle()
            .opacity(0.001)
            .overlay {
                ImageLoaderView(urlString: imageName)
            }
            .overlay(alignment: .bottomLeading) {
                VStack(alignment: .leading, spacing: 8, content: {
                    Text(subtitle)
                        .font(.headline)

                    Text(title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                })
                .foregroundStyle(.spotifyWhite)
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background {
                    LinearGradient(
                        colors: [.clear, shadowColor],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                }
            }
            .asStretchyHeader(startingHeight: height)
    }
}

#Preview {
    ZStack(content: {
        Color.black.ignoresSafeArea()

        ScrollView {
            PlaylistHeaderCell()
        }
        .ignoresSafeArea()
    })
}
