//
//  View1.swift
//  self_modal_test
//
//  Created by Yuto on 2025/04/25.
//


import SwiftUI

struct WeatherView: View {
    var body: some View {
        ZStack {
            // 背景グラデーション
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.cyan]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Tokyo")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)

                Text("27°")
                    .font(.system(size: 70, weight: .bold))
                    .foregroundColor(.white)

                Image(systemName: "cloud.sun.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white)

                Text("Partly Cloudy")
                    .font(.title3)
                    .foregroundColor(.white.opacity(0.8))

                Spacer()
            }
            .padding()
        }
        .cornerRadius(10)
    }
}

#Preview {
    WeatherView()
}
