//
//  BumbleFilterView.swift
//  SwiftUIPractices
//
//  Created by Yunus Emre Berdibek on 20.04.2024.
//

import SwiftUI

struct BumbleFilterView: View {
    @Namespace private var namespace
    @Binding var selection: BumbleHomeView.Category

    var options: [BumbleHomeView.Category] = BumbleHomeView.Category.allCases

    var body: some View {
        HStack(alignment: .top, spacing: 32) {
            ForEach(options, id: \.self) { option in
                VStack(spacing: 8) {
                    Text(option.rawValue.capitalized)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity)

                    if selection == option {
                        RoundedRectangle(cornerRadius: 2)
                            .matchedGeometryEffect(
                                id: "selection",
                                in: namespace)
                            .frame(height: 1.5)
                    }
                }
                .padding(.top, 8)
                .background(.black.opacity(0.001))
                .foregroundStyle(selection == option
                    ? .bumbleBlack : .bumbleGray)
                .onTapGesture {
                    selection = option
                }
            }
        }
        .animation(.smooth, value: selection)
    }
}

struct BumbleFilterViewPreview: View {
    @State var category: BumbleHomeView.Category = .everyone

    var body: some View {
        BumbleFilterView(selection: $category,
                         options: [.everyone, .trending])
    }
}

#Preview {
    BumbleFilterViewPreview()
}

/*
 @Namespace
 Bu özellik, SwiftUI görünümleri arasında animasyonlu geçişler gerçekleştirirken, SwiftUI'nin animasyon sistemi tarafından kullanılan bir "ad alanı" oluşturur. Bu ad alanı, belirli bir animasyonun veya geçişin hedefleri arasında ilişki kurulmasını sağlar. Örneğin, bir görünümün girişini ve çıkışını ilişkilendirebilir ve böylece bir görünüm belirli bir animasyonla ortaya çıkarken diğerinin kaybolmasını sağlayabilirsiniz.
 */
