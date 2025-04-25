//
//  Clear_Sheet.swift
//  self_modal_test
//
//  Created by Yuto on 2025/04/25.
//

import SwiftUI


extension View {
    func bottomSheet<SheetContent: View>(
        isPresented: Binding<Bool>,
        height: BottomSheetHeight,
        minHeight: CGFloat = 100,
        maxHeight: CGFloat? = nil,
        @ViewBuilder content: @escaping (CGFloat) -> SheetContent
    ) -> some View {
        modifier(
            DraggableBottomSheetModifier(
                isPresented: isPresented,
                height: height,
                minHeight: minHeight,
                maxHeight: maxHeight,
                content: content
            )
        )
    }
}

enum BottomSheetHeight {
    case fixed(CGFloat)
    case fraction(CGFloat)
    
    func resolve(in geometry: GeometryProxy) -> CGFloat {
        switch self {
        case .fixed(let value):
            return value
        case .fraction(let ratio):
            return geometry.size.height * ratio
        }
    }
}

private struct BottomSheetModifier<SheetContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    let height: BottomSheetHeight
    let content: () -> SheetContent
    
    func body(content base: Content) -> some View {
        GeometryReader { geometry in
            ZStack {
                base
                
                if isPresented {
                    VStack {
                        Spacer()
                        self.content()
                            .frame(height: height.resolve(in: geometry))
                            .frame(maxWidth: .infinity)
                            .background(.ultraThinMaterial)
                            .ignoresSafeArea()
                            .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .bottom)))
                    }
                    .zIndex(1)
                }
            }
            .animation(.easeInOut(duration: 0.3), value: isPresented)
        }
    }
}

private struct DraggableBottomSheetModifier<SheetContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    let height: BottomSheetHeight
    let minHeight: CGFloat
    let maxHeight: CGFloat?
    let content: (CGFloat) -> SheetContent
    
    @State private var dragOffset: CGFloat = 0
    @State private var currentHeight: CGFloat
    
    init(isPresented: Binding<Bool>, height: BottomSheetHeight, minHeight: CGFloat, maxHeight: CGFloat?, content: @escaping (CGFloat) -> SheetContent) {
        self._isPresented = isPresented
        self.height = height
        self.minHeight = minHeight
        self.maxHeight = maxHeight
        self.content = content
        self._currentHeight = State(initialValue: minHeight)
    }
    
    func body(content base: Content) -> some View {
        GeometryReader { geometry in
            ZStack {
                base
                
                VStack {
                    Spacer()
                    VStack {
                        Capsule()
                            .fill(Color.secondary)
                            .frame(width: 40, height: 6)
                            .padding(.top, 8)
                            .padding(.bottom, 4)
                        
                        HStack {
                            Button(action: {
                                withAnimation {
                                    isPresented = false
                                }
                            }) {
                                Image(systemName: "xmark")
                                    .foregroundColor(.primary)
                                    .padding(8)
                                    .background(Color.gray.opacity(0.2))
                                    .clipShape(Circle())
                            }
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        self.content(currentHeight)
                            .frame(maxHeight: .infinity, alignment: .top)
                    }
                    .frame(height: currentHeight, alignment: .top)
                    .frame(maxWidth: .infinity)
                    .background(.ultraThinMaterial)
                    .cornerRadius(16)
                    .offset(y: isPresented ? dragOffset : geometry.size.height)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let newHeight = currentHeight - value.translation.height
                                if let maxHeight = maxHeight {
                                    currentHeight = min(max(minHeight, newHeight), maxHeight)
                                } else {
                                    currentHeight = max(minHeight, newHeight)
                                }
                            }
                            .onEnded { _ in
                                withAnimation {
                                    dragOffset = 0
                                }
                            }
                    )
                    .animation(.easeInOut(duration: 0.3), value: isPresented)
                    .onAppear {
                        currentHeight = height.resolve(in: geometry)
                    }
                }
                .ignoresSafeArea(.all)
            }
            .animation(.easeInOut(duration: 0.3), value: isPresented)
        }
    }
}
