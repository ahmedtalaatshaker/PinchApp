//
//  DRAWER.swift
//  Pinch-App
//
//  Created by Ahmed Talaat on 12/12/2022.
//

import SwiftUI
protocol passIndex {
    func passSelecteIndex(pageIndex: Int)
}

struct DRAWER: View {
    @State private var isAnimating = false
    @State private var isDrawerOpen: Bool = false
    @State var pageIndex: Int
    @State var delegate: passIndex?

    let pagesData = pages
    
    var body: some View {
        HStack{
            // MARK: - DRAWER HANDLE
            
            Image(systemName: !isDrawerOpen ? "chevron.compact.left" : "chevron.compact.right")
                .resizable()
                .scaledToFit()
                .frame(height: 40)
                .padding(8)
                .foregroundColor(.secondary)
                .onTapGesture {
                    withAnimation(.easeOut) {
                        isDrawerOpen.toggle()
                    }
                }

            // MARK: - THUMNAILS
            ForEach(pages) { item in
                Image(item.thumbnailName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80)
                    .cornerRadius(8)
                    .shadow(radius: 4)
                    .opacity(isDrawerOpen ? 1 : 0)
                    .animation(.easeOut(duration: 0.5), value: isDrawerOpen)
                    .padding(8)
                    .onTapGesture {
                        withAnimation(.easeOut) {
                            pageIndex = item.id - 1
                            delegate?.passSelecteIndex(pageIndex: pageIndex)
                        }
                    }
            }

        }//: DRAWER
        .frame(height: 120)
        .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
        .background(.ultraThinMaterial)
        .opacity(isAnimating ? 1 : 0)
        .cornerRadius(12)
        .offset(x: isDrawerOpen ? 10 : 210)
        
        .onAppear {
            isAnimating = true
        }
    }
}

struct DRAWER_Previews: PreviewProvider {
    static var previews: some View {
        DRAWER(pageIndex: 0, delegate: nil)
            .previewLayout(.sizeThatFits)
    }
}
