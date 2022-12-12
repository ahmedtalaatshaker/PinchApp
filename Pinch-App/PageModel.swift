//
//  PageModel.swift
//  Pinch-App
//
//  Created by Ahmed Talaat on 12/12/2022.
//

import Foundation

struct pageModel: Identifiable {
    let id: Int
    let image: String
}

extension pageModel {
    var thumbnailName: String {
        "thumb-" + image
    }
}
