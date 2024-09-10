//
//  BumbleProfileImageCell.swift
//  SwiftUIPractices
//
//  Created by Yunus Emre Berdibek on 27.04.2024.
//

import SwiftUI

struct BumbleProfileImageCell: View {
    var imageName: String = Constants.randomImage
    var percantageRemaining: Double = 0.4 // .random(in: 0 ... 1)
    var hasNewMessage: Bool = true

    var body: some View {
        ZStack {
            Circle()
                .stroke(.bumbleGray, lineWidth: 2)

            Circle()
                .trim(from: 0, to: percantageRemaining)
                .stroke(.yellow, lineWidth: 4)
                .rotationEffect(.degrees(-90))
                .scaleEffect(x: -1, y: 1, anchor: .center)

            ImageLoaderView(urlString: imageName)
                .clipShape(.circle)
                .padding(5)
        }
        .frame(width: 75, height: 75)
        .overlay(alignment: .bottomTrailing) {
            ZStack {
                if hasNewMessage {
                    Circle().fill(.white)

                    Circle().fill(.bumbleYellow)
                        .padding(4)
                }
            }
            .frame(width: 24, height: 24)
            .offset(x: 2, y: 2)
        }
    }
}

#Preview {
    ScrollView {
        VStack {
            BumbleProfileImageCell()
            BumbleProfileImageCell(percantageRemaining: 1)
            BumbleProfileImageCell(percantageRemaining: .zero)
            BumbleProfileImageCell(hasNewMessage: false)
        }
    }
    .clipped()
}
