//
//  SummaryInfoView.swift
//  self_modal_test
//
//  Created by Yuto on 2025/04/26.
//

import SwiftUI

struct SummaryInfoView: View {
    var body: some View {
        HStack(spacing: 16) {
            // 情報のアイコン
            Image(systemName: "calendar")
                .foregroundColor(.blue)
                .font(.title2)

            VStack(alignment: .leading, spacing: 4) {
                Text("今日の予定")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("3件のイベントがあります")
                    .font(.headline)
                    .foregroundColor(.primary)
            }

            Spacer()
        }
        .padding()
        .background(Color(.systemGray5))
        .cornerRadius(12)
        .frame(height: 80)
        .padding(.horizontal)
    }
}

#Preview {
    SummaryInfoView()
}
