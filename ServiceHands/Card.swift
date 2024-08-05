//
//  Card.swift
//  ServiceHands
//
//  Created by Artem on 8/5/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Card {
    var title: String
    var subTitle: String
    var icon: String
    
    init(title: String, subTitle: String, icon: String) {
        self.title = title
        self.subTitle = subTitle
        self.icon = icon
    }
}

extension Card {
    var gradientColors: [Color] {
        switch self.title {
        case "Живая":
            return [.gradientCardAliveTop, .gradientCardAliveBottom]
        case "Жизнь!":
            return [.gradientCardNewLiveTop, .gradientCardNewLiveBottom]
        default:
            return [.gradientCardDieTop, .gradientCardDieBottom]
        }
    }
}
