import SwiftUI
import SwiftData

let gradientColors: [Color] = [
    .gradientTop,
    .gradientBottom
]

struct ContentView: View {
    @Query private var cardList: [Card]
    @Environment(\.modelContext) private var context
    
    @State private var consecutiveLiveCount = 0
    @State private var consecutiveDeadCount = 0
    @State private var selectedCardID: UUID?
    
    var body: some View {
        VStack {
            Text("Клеточное наполнение")
                .font(.system(size: 28))
                .bold()
                .padding(.bottom)
            
            Spacer()
            
            ScrollViewReader { scrollViewProxy in
                ScrollView {
                    VStack {
                        ForEach(cardList) { card in
                            CardView(
                                gradientColors: card.gradientColors,
                                title: card.title,
                                subTitle: card.subTitle,
                                icon: card.icon
                            )
                            .id(card.id) // нужно для автоскролла
                        }
                    }
                    .onChange(of: cardList) { // автоскролл при добавлении карты, если она не влезла
                        if let lastCardId = cardList.last?.id {
                            withAnimation {
                                scrollViewProxy.scrollTo(lastCardId, anchor: .bottom)
                            }
                        }
                    }
                }
            }
            
            Spacer()
            
            Button(action: addCard) {
                Text("СОТВОРИТЬ")
                    .font(.system(size: 15))
                    .bold()
                    .frame(maxWidth: .infinity, maxHeight: 36)
                    .background(.createButton)
                    .cornerRadius(4)
            }
            .padding(.top)
        }
        .padding()
        .frame(maxHeight: .infinity)
        .background(Gradient(colors: gradientColors))
        .foregroundColor(.white)
    }
    
    private func addCard() {
        let shouldAddLiveCard = Bool.random()
        
        if shouldAddLiveCard {
            consecutiveLiveCount += 1
            consecutiveDeadCount = 0
        } else {
            consecutiveLiveCount = 0
            consecutiveDeadCount += 1
        }

        if consecutiveLiveCount < 3 {
            let newCard = Card(title: shouldAddLiveCard ? "Живая" : "Мёртвая",
                               subTitle: shouldAddLiveCard ? "и шевелится!" : "или прикидывается",
                               icon: shouldAddLiveCard ? "💥" : "💀")
            
            context.insert(newCard)
        }
        
        // если карты "живая" >= 3
        if consecutiveLiveCount >= 3 {
            let lifeCard = Card(title: "Жизнь!", subTitle: "ку-ку!", icon: "🐣")
            context.insert(lifeCard)
            consecutiveLiveCount = 0
        }
        
        // если карты "Мёртвая" >= 3
        if consecutiveDeadCount >= 3 {
            consecutiveDeadCount = 0
            
            // заменяем ближайшую карту "жизнь" на "Мёртвая"
            if let lastLifeCardIndex = cardList.lastIndex(where: { $0.title == "Жизнь!" }) {
                let lifeCardToReplace = cardList[lastLifeCardIndex]
                
                context.delete(lifeCardToReplace)
                
                let deadCard = Card(title: "Мёртвая", subTitle: "или прикидывается", icon: "💀")
                
                context.insert(deadCard)
            }
        }
        
        
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Card.self, inMemory: true)
}
