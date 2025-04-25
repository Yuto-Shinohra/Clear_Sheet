//
//  MediumTaskView.swift
//  self_modal_test
//
//  Created by Yuto on 2025/04/25.
//

import SwiftUI


struct MediumArticleView: View {
    let articles = [
        "SwiftUIのアニメーションを極めよう",
        "iOS 18 新機能まとめ",
        "VisionOSで作る新時代アプリ",
        "ChatGPTと連携したアプリ開発"
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("おすすめ記事")
                .font(.title2)
                .bold()

            ForEach(articles, id: \.self) { article in
                HStack {
                    Image(systemName: "doc.text")
                        .foregroundColor(.blue)
                    Text(article)
                        .font(.body)
                }
            }

            Spacer()
        }
        .padding()
        .frame(height: UIScreen.main.bounds.height * 0.5)
        .background(Color(.systemGray6))
        .cornerRadius(16)
        .padding()
    }
}

#Preview {
    MediumArticleView()
}



let tasks = [
    "Finish SwiftUI project",
    "Reply to email",
    "Prepare presentation",
    "Buy groceries"
]
