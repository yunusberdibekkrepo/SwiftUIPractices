//
//  BumbleHeartView.swift
//  SwiftUIPractices
//
//  Created by Yunus Emre Berdibek on 24.04.2024.
//

import SwiftUI

struct BumbleHeartView: View {
    var body: some View {
        ZStack {
            Circle().fill(.bumbleYellow)
                .frame(width: 40, height: 40)

            Image(systemName: "bubble.fill")
                .foregroundStyle(.bumbleBlack)
                .font(.system(size: 22))
                .offset(y: 2)

            Image(systemName: "heart.fill")
                .foregroundStyle(.bumbleYellow)
                .font(.system(size: 10))
        }
    }
}

#Preview {
    BumbleHeartView()
}
