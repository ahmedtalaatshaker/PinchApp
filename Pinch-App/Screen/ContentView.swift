//
//  ContentView.swift
//  Pinch-App
//
//  Created by Ahmed Talaat on 30/11/2022.
//

import SwiftUI

struct ContentView: View, passIndex {
    func passSelecteIndex(pageIndex: Int) {
        self.pageIndex = pageIndex
    }
    
    @State private var imageScale: CGFloat = 1
    @State private var isAnimating = false
    @State private var zoom = false
    @State private var dragOffset: CGSize = .zero
    @State private var isDrawerOpen: Bool = false
    
    let pagesData = pages
    @State private var pageIndex = 0
    
    fileprivate func resetImageState() {
        withAnimation(.spring()) {
            imageScale = 1
            dragOffset = .zero
        }
    }
    
    var body: some View {
        NavigationView{
            ZStack {
                Color.clear
                
                Image(pagesData[pageIndex].image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                    .opacity(isAnimating ? 1 : 0)
                    .offset(dragOffset)
                    .scaleEffect(imageScale)
                // MARK: - TapGesture
                    .onTapGesture(count: 2, perform: {
                        if imageScale == 1 {
                            withAnimation(.spring()) {
                                imageScale = 5
                            }
                        }else{
                            resetImageState()
                        }
                    })
                // MARK: - DragGesture
                    .gesture(
                        DragGesture()
                            .onChanged({ gesture in
                                withAnimation(.linear(duration: 1)) {
                                    dragOffset = gesture.translation
                                }
                            })
                        
                            .onEnded({ _ in
                                if imageScale <= 1 {
                                    resetImageState()
                                }
                            })
                    )
                
                // MARK: - MAGNIFICATION
                    .gesture(
                        MagnificationGesture()
                            .onChanged({ scaleValue in
                                withAnimation(.linear(duration: 1)) {
                                    if imageScale >= 1 && imageScale <= 5 {
                                        imageScale = abs(scaleValue)
                                    }
                                    
                                    if imageScale > 5 {
                                        imageScale = 5
                                    }
                                    
                                    if imageScale < 1 {
                                        resetImageState()
                                    }
                                }
                            })
                        
                            .onEnded({ _ in
                                if imageScale > 5 {
                                    imageScale = 5
                                }else if imageScale < 1 {
                                    resetImageState()
                                }
                            })
                    )

            }//: ZSTACK
            .overlay(
                InfoPanelView(scale: imageScale, offset: dragOffset)
                    .padding(.horizontal)
                    .padding(.top, 30)
                , alignment: .top
            )
            .overlay(
                Group{
                    HStack{
                        // SCALE DOWN
                        ControlImageView(imageName: "minus.magnifyingglass")
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    imageScale > 1 ? imageScale -= 1 : resetImageState()
                                }
                            }

                        // RESET
                        ControlImageView(imageName: "arrow.up.left.and.down.right.magnifyingglass")
                            .onTapGesture {
                                resetImageState()
                            }

                        // SCALE UP
                        ControlImageView(imageName: "plus.magnifyingglass")
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    if imageScale < 5 {
                                        imageScale += 1
                                    }
                                    
                                    if imageScale > 5{
                                        imageScale = 5
                                    }
                                }
                            }
                    }
                    .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                    .background(.ultraThinMaterial)
                    .opacity(isAnimating ? 1 : 0)
                    .cornerRadius(12)
                }
                .padding(.bottom, 30)
                , alignment: .bottom
                
            ) //: CONTROLS
            // MARK: - DRAWER
            .overlay(
                // MARK: - DRAWER HANDLE
                DRAWER(pageIndex: pageIndex, delegate: self)
                    .padding(.top, UIScreen.main.bounds.height / 12)
                , alignment: .topTrailing
            )
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                withAnimation(.linear(duration: 3)) {
                    isAnimating = true
                }
            })

        }//: NavigationView
        .preferredColorScheme(.dark)
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
