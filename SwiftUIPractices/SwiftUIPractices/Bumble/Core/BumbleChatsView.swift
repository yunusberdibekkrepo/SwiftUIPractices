//
//  BumbleChatsView.swift
//  SwiftUIPractices
//
//  Created by Yunus Emre Berdibek on 1.05.2024.
//

import SwiftUI

struct BumbleChatsView: View {
    @Environment(\.router) var router

    @State var allUsers: [User] = []
    var body: some View {
        ZStack {
            Color.bumbleWhite.ignoresSafeArea()

            VStack {
                header

                matchQueueSection

                recentChatsSection
            }
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
}

extension BumbleChatsView {
    private var header: some View {
        HStack(spacing: .zero) {
            Image(systemName: "line.horizontal.3")
                .onTapGesture {
                    router.dismissScreen()
                }
            Spacer(minLength: 0)
            Image(systemName: "magnifyingglass")
        }
        .font(.title)
        .fontWeight(.medium)
        .padding(16)
    }

    private var matchQueueSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Group {
                Text("Match Queue")
                    +
                    Text(" (\(allUsers.count.description))")
                    .foregroundStyle(.bumbleGray)
            }
            .padding(.horizontal, 16)

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(allUsers, id: \.id) { user in
                        BumbleProfileImageCell(imageName: user.image,
                                               percantageRemaining: Double.random(in: 0 ... 1),
                                               hasNewMessage: Bool.random())
                    }
                }
                .padding(.horizontal, 16)
            }
            .frame(height: 100)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 16)
    }

    private var recentChatsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Group {
                    Text("Chats")
                        +
                        Text(" (Recent)")
                        .foregroundStyle(.bumbleGray)
                }

                Spacer(minLength: .zero)

                Image(systemName: "line.horizontal.3.decrease")
                    .font(.title2)
            }
            .padding(.horizontal, 16)

            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 16) {
                    ForEach(allUsers, id: \.id) { user in
                        BumbleChatPreviewCell(
                            imageName: user.images.randomElement()!,
                            percentageRemaining: Double.random(in: 0 ... 1),
                            hasNewMessage: Bool.random(),
                            username: user.firstName,
                            lastChatMessage: user.aboutMe,
                            isYourMove: Bool.random())
                    }
                }
                .padding(16)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    BumbleChatsView()
}
