//
//  ImageLoaderView.swift
//  SwiftUIPractices
//
//  Created by Yunus Emre Berdibek on 11.04.2024.
//

import SDWebImageSwiftUI
import SwiftUI

struct ImageLoaderView: View {
    var urlString: String = Constants.randomImage
    var resizinMode: ContentMode = .fill

    var body: some View {
        Rectangle()
            .opacity(0.001)
            .overlay {
                WebImage(url: URL(string: urlString))
                    .resizable()
                    .indicator(.activity)
                    .aspectRatio(contentMode: resizinMode)
                    .allowsHitTesting(false) // rect'e tıklanmasını sağlar.
            }
            .clipped()
    }
}

#Preview {
    ImageLoaderView(urlString: Constants.randomImage)
        .clipShape(.rect(cornerRadius: 30))
        .padding(40)
        .padding(.vertical, 60)
}
