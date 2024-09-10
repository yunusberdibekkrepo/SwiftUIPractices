//
//  BumbleChatPreviewCell.swift
//  SwiftUIPractices
//
//  Created by Yunus Emre Berdibek on 1.05.2024.
//

import SwiftUI

struct BumbleChatPreviewCell: View {
    var imageName: String = Constants.randomImage
    var percentageRemaining: Double = .random(in: 0 ... 1)
    var hasNewMessage: Bool = false
    var username: String = "Yunus Emre"
    var lastChatMessage: String? = "This is the last message from now."
    var isYourMove: Bool = true

    var body: some View {
        HStack {
            BumbleProfileImageCell(imageName: imageName,
                                   percantageRemaining: percentageRemaining,
                                   hasNewMessage: hasNewMessage)

            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: .zero) {
                    Text(username)
                        .font(.headline)
                        .foregroundStyle(.bumbleBlack)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    if isYourMove {
                        Text("YOUR MOVE")
                            .font(.caption2)
                            .bold()
                            .padding(.vertical, 4)
                            .padding(.horizontal, 6)
                            .background(.bumbleYellow)
                            .cornerRadius(32)
                    }
                }

                if let lastChatMessage {
                    Text(lastChatMessage)
                        .font(.subheadline)
                        .foregroundStyle(.bumbleGray)
                        .padding(.trailing, 16)
                }
            }
            .lineLimit(1)
        }
    }
    
    
}

#Preview {
    ScrollView {
        BumbleChatPreviewCell()
        BumbleChatPreviewCell(percentageRemaining: 0.2, hasNewMessage: false)
        BumbleChatPreviewCell(isYourMove: false)
    }
    .padding()
}
