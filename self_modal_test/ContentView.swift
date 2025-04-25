//
//  ContentView.swift
//  self_modal_test
//
//  Created by Yuto on 2025/04/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var isPresented = false
    
    var body: some View {
        ZStack {
            Map()
                .ignoresSafeArea(edges: .all)
            VStack{
                Text("EXAMPLE")
                    .font(.title)
                    .padding()
                Button("Open Sheet") {
                    withAnimation {
                        isPresented.toggle()
                    }
                }
                .foregroundStyle(.white)
                .padding()
                .background(Color.green.opacity(0.6))
                .cornerRadius(12)
                .padding()
                Spacer()
            }
        }
        .bottomSheet(isPresented: $isPresented, height: .fraction(0.6), minHeight: UIScreen.main.bounds.height*0.2, maxHeight: UIScreen.main.bounds.height * 0.9) { currentHeight in
            ZStack {
                if currentHeight < 300 {
                    SummaryInfoView()
                        .transition(.opacity)
                } else if currentHeight < 500 {
                    MediumArticleView()
                        .transition(.opacity)
                } else {
                    WeatherView()
                        .transition(.opacity)
                        .padding()
                        .cornerRadius(10)
                }
            }
            .animation(.easeInOut(duration: 0.3), value: currentHeight)
        }
    }
}

#Preview {
    ContentView()
}
