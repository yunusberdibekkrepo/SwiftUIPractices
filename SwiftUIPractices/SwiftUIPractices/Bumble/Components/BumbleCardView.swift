//
//  BumbleCardView.swift
//  SwiftUIPractices
//
//  Created by Yunus Emre Berdibek on 24.04.2024.
//

import SwiftfulUI
import SwiftUI

struct BumbleCardView: View {
    var user: User = .mock
    var onSuperLikeAction: (() -> Void)? = nil
    var onXmarkAction: (() -> Void)? = nil
    var onCheckmarkAction: (() -> Void)? = nil
    var onSendAComplimentAction: (() -> Void)? = nil
    var onHideAndReportAction: (() -> Void)? = nil

    @State private var cardFrame: CGRect = .zero

    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: .zero) {
                headerCell
                    .frame(height: cardFrame.height)

                aboutMeSection
                    .padding(.horizontal, 24)
                    .padding(.vertical, 24)

                myInterestsSection
                    .padding(.horizontal, 24)
                    .padding(.vertical, 24)

                ForEach(user.images, id: \.self) { image in
                    ImageLoaderView(urlString: image)
                        .frame(height: cardFrame.height)
                }

                locationsSection
                    .padding(.horizontal, 24)
                    .padding(.vertical, 24)

                footerSection
                    .padding(.top, 60)
                    .padding(.bottom, 60)
                    .padding(.horizontal, 32)
            }
        }
        .scrollIndicators(.hidden)
        .background(.bumbleBackgroundYellow)
        .overlay(alignment: .bottomTrailing) {
            superLikeButton
        }

        .cornerRadius(32)
        .readingFrame { frame in
            cardFrame = frame
        }
    }
}

extension BumbleCardView {
    private func sectionTitle(title: String) -> some View {
        Text(title)
            .font(.body)
            .foregroundStyle(.bumbleGray)
    }

    private var headerCell: some View {
        ZStack(alignment: .bottomLeading) {
            ImageLoaderView(urlString: user.image)

            VStack(alignment: .leading, spacing: 8) {
                Text("\(user.firstName), \(user.age)")
                    .font(.largeTitle)
                    .fontWeight(.semibold)

                HStack(spacing: 4) {
                    Image(systemName: "suitcase")
                    Text(user.work)
                }

                HStack(spacing: 4) {
                    Image(systemName: "graduationcap")
                    Text(user.education)
                }

                BumbleHeartView()
                    .onTapGesture {
                        
                    }
            }
            .padding(24)
            .font(.callout)
            .fontWeight(.medium)
            .foregroundStyle(.bumbleWhite)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background {
                LinearGradient(
                    colors: [
                        .clear,
                        .bumbleBlack.opacity(0.6),
                        .bumbleBlack.opacity(0.6),
                    ],
                    startPoint: .top,
                    endPoint: .bottom)
            }
        }
    }

    private var aboutMeSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionTitle(title: "About Me")

            Text(user.aboutMe)
                .font(.body)
                .fontWeight(.semibold)
                .foregroundStyle(.bumbleBlack)

            HStack(spacing: .zero) {
                BumbleHeartView()

                Text("Send a Compliment")
                    .font(.caption)
                    .fontWeight(.semibold)
            }
            .padding(.horizontal, 8)
            .padding(.trailing, 8)
            .background(.bumbleYellow)
            .cornerRadius(32)
            .onTapGesture {
                onSendAComplimentAction?()
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var myInterestsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 8) {
                sectionTitle(title: "My basics")
                InterestPillGridView(interests: user.basics)
            }

            VStack(alignment: .leading, spacing: 8) {
                sectionTitle(title: "My interests")
                InterestPillGridView(interests: user.interests)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var locationsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Image(systemName: "mappin.and.ellipse.circle.fill")
                Text(user.firstName + "'s Location")
            }
            .foregroundStyle(.bumbleGray)
            .font(.body)
            .fontWeight(.medium)

            Text("10 miles away")
                .font(.headline)
                .foregroundStyle(.bumbleBlack)

            InterestPillView(iconName: nil, emoji: "🇹🇷", text: "Lives in Elazığ")
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private var footerSection: some View {
        VStack(spacing: 24) {
            HStack(spacing: .zero) {
                Circle()
                    .fill(.bumbleYellow)
                    .overlay {
                        Image(systemName: "xmark")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                    .frame(width: 60, height: 60)
                    .onTapGesture {
                        onXmarkAction?()
                    }

                Spacer(minLength: 0)

                Circle()
                    .fill(.bumbleYellow)
                    .overlay {
                        Image(systemName: "checkmark")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                    .frame(width: 60, height: 60)
                    .onTapGesture {
                        onCheckmarkAction?()
                    }
            }

            Text("Hide and Report")
                .font(.headline)
                .foregroundStyle(.bumbleGray)
                .padding(8)
                .background(.black.opacity(0.001))
                .onTapGesture {
                    onHideAndReportAction?()
                }
        }
    }

    private var superLikeButton: some View {
        Image(systemName: "hexagon.fill")
            .font(.system(size: 60))
            .foregroundStyle(.bumbleYellow)
            .overlay {
                Image(systemName: "star.fill")
                    .font(.system(size: 30, weight: .medium))
                    .foregroundStyle(.bumbleBlack)
            }
            .onTapGesture {
                onSuperLikeAction?()
            }
            .padding(24)
    }
}

#Preview {
    BumbleCardView()
        .padding(.vertical, 40)
        .padding(.horizontal, 16)
}
