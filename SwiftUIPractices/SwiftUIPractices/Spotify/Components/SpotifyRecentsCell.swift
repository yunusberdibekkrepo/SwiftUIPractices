//
//  SpotifyRecentsCell.swift
//  SwiftUIPractices
//
//  Created by Yunus Emre Berdibek on 13.04.2024.
//

import SwiftUI

struct SpotifyRecentsCell: View {
    var imageName: String = Constants.randomImage
    var title: String = "Some random title"

    var body: some View {
        HStack(spacing: 16) {
            ImageLoaderView(urlString: imageName)
                .frame(width: 55, height: 55)

            Text(title)
                .font(.callout)
                .fontWeight(.semibold)
                .lineLimit(2)
        }
        .foregroundStyle(.white)
        .padding(.trailing, 6)
        .frame(maxWidth: .infinity, alignment: .leading)
        .themeColors(isSelected: false)
        .cornerRadius(6)
    }
}

#Preview {
    ZStack(content: {
        Color.black.ignoresSafeArea()

        VStack(content: {
            HStack(content: {
                SpotifyRecentsCell()
                SpotifyRecentsCell()
            })

            HStack(content: {
                SpotifyRecentsCell()
                SpotifyRecentsCell()
            })
        })
    })
}
