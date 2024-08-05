//
//  CardView.swift
//  ServiceHands
//
//  Created by Artem on 8/5/24.
//

import SwiftUI

struct CardView: View {
    let gradientColors: [Color]
    let title: String
    let subTitle: String
    let icon: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            HStack {
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: gradientColors),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .frame(maxWidth: 40, maxHeight: 40)
                        .padding()
                    
                    Text(icon)
                }
                
                VStack (alignment: .leading) {
                    Text(title)
                        .foregroundColor(.black)
                        .font(.system(size: 28))
                        .bold()
                    
                    Text(subTitle)
                        .foregroundColor(.black)
                        .font(.system(size: 20))
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: 72)
        }
        .background(.white)
        .cornerRadius(8)
        .frame(maxWidth: .infinity, maxHeight: 72)
    }
}


#Preview {
    CardView(gradientColors: [.gradientCardDieTop, .gradientCardDieBottom], title: "Мёртвая", subTitle: "Или прикидывается", icon: "💀")
        .padding()
        .background(Color.blue)
}
