//
//  BumbleHomeView.swift
//  SwiftUIPractices
//
//  Created by Yunus Emre Berdibek on 20.04.2024.
//

import SwiftfulRouting
import SwiftfulUI
import SwiftUI

struct BumbleHomeView: View {
    @Environment(\.router) var router
    @AppStorage("bumble_home_category") var selectedCategory: Category = .everyone
    @State private var allUsers: [User] = []
    @State private var selectedIndex: Int = .zero
    @State private var cardOffsets: [Int: Bool] = [:] // userID:(Direction is Right == TRUE)
    @State private var currentSwipeOffset: CGFloat = .zero
    @Namespace var namespace

    var body: some View {
        ZStack {
            Color.bumbleWhite.ignoresSafeArea()

            VStack(spacing: 12) {
                header

                BumbleFilterView(selection: $selectedCategory,
                                 options: Category.allCases)
                    .background(alignment: .bottom) {
                        Divider()
                    }

                ZStack {
                    if !allUsers.isEmpty {
                        ForEach(Array(allUsers.enumerated()), id: \.offset) { index, user in
                            let isPrevious = (selectedIndex - 1) == index
                            let isCurrent = selectedIndex == index
                            let isNext = (selectedIndex + 1) == index

                            if isPrevious || isCurrent || isNext {
                                let offsetValue = cardOffsets[user.id]

                                userProfileCell(user: user, index: index)
                                    .zIndex(Double(allUsers.count - index))
                                    .offset(x: offsetValue == nil ? .zero : offsetValue == true ? 900 : -900)
                            }
                        }
                    } else {
                        ProgressView()
                    }

                    overlaySwipingIndicators
                        .animation(.smooth, value: currentSwipeOffset)
                        .zIndex(999999)
                }
                .frame(maxHeight: .infinity)
                .padding(4)
                .animation(.smooth, value: cardOffsets)
            }
            .padding(8)
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    private func getData() async {
        guard allUsers.isEmpty else { return }

        do {
            allUsers = try await DatabaseHelper().getUsers()

        } catch {
            print(error.localizedDescription)
        }
    }

    private func userDidSelect(index: Int, isLike: Bool) {
        let user = allUsers[index]

        cardOffsets[user.id] = isLike
        selectedIndex += 1
    }
}

extension BumbleHomeView {
    enum Category: String, CaseIterable {
        case everyone
        case trending
    }

    private func userProfileCell(user: User, index: Int) -> some View {
        BumbleCardView(
            user: user,
            onSuperLikeAction: nil,
            onXmarkAction: {
                userDidSelect(index: index, isLike: false)
            },
            onCheckmarkAction: {
                userDidSelect(index: index, isLike: true)
            },
            onSendAComplimentAction: nil,
            onHideAndReportAction: nil)
            .withDragGesture(
                .horizontal,
                minimumDistance: 10,
                resets: true,
                rotationMultiplier: 1.05,
                scaleMultiplier: 0.8,
                onChanged: { dragOffset in
                    currentSwipeOffset = dragOffset.width
                },
                onEnded: { dragOffset in
                    if dragOffset.width < -50 {
                        userDidSelect(index: index, isLike: false)
                    } else if dragOffset.width > 50 {
                        userDidSelect(index: index, isLike: true)
                    }
                })
    }

    private var header: some View {
        HStack {
            HStack(spacing: 0) {
                Image(systemName: "line.horizontal.3")
                    .padding(8)
                    .background(.black.opacity(0.001))
                    .onTapGesture {
                        router.dismissScreen()
                    }

                Image(systemName: "arrow.uturn.left")
                    .padding(8)
                    .background(.black.opacity(0.001))
                    .onTapGesture {
                        router.dismissScreen()
                    }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Text("bumble")
                .font(.title)
                .foregroundStyle(.bumbleYellow)
                .frame(maxWidth: .infinity, alignment: .center)

            Image(systemName: "slider.horizontal.3")
                .padding(8)
                .background(.black.opacity(0.001))
                .onTapGesture {
                    router.showScreen(.push) { _ in
                        BumbleChatsView()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .font(.title2)
        .fontWeight(.medium)
        .foregroundStyle(.bumbleBlack)
    }

    private var overlaySwipingIndicators: some View {
        ZStack {
            Circle().fill(.bumbleGray.opacity(0.4))
                .overlay {
                    Image(systemName: "xmark")
                        .font(.title)
                        .fontWeight(.semibold)
                }
                .frame(width: 60, height: 60)
                .scaleEffect(abs(currentSwipeOffset) > 150 ? 1.5 : 1.0)
                .offset(x: min(-currentSwipeOffset, 150))
                .offset(x: -100)
                .frame(maxWidth: .infinity, alignment: .leading)

            Circle().fill(.bumbleGray.opacity(0.4))
                .overlay {
                    Image(systemName: "checkmark")
                        .font(.title)
                        .fontWeight(.semibold)
                }
                .frame(width: 60, height: 60)
                .scaleEffect(abs(currentSwipeOffset) > 150 ? 1.5 : 1.0)
                .offset(x: max(-currentSwipeOffset, -150))
                .offset(x: 100)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

#Preview {
    RouterView { _ in
        BumbleHomeView()
    }
}
