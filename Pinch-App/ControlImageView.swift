//
//  ImageComponent.swift
//  Pinch-App
//
//  Created by Ahmed Talaat on 12/12/2022.
//

import SwiftUI

struct ControlImageView: View {
    var imageName: String
    var body: some View {
        Image(systemName: imageName)
            .font(.system(size: 36))
    }
}

struct ImageComponent_Previews: PreviewProvider {
    static var previews: some View {
        ControlImageView(imageName: "minus.magnifyingglass")
            .previewLayout(.sizeThatFits)
    }
}
