//
//  LivesView.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 12/22/21.
//

import SwiftUI

struct CardViewMaybe: View {
    
    
    /*@Binding var showMainView: Bool
    @Binding var showLivesView: Bool
    
    @State static var index = 0
    var life: Life {
        cemetary[CardViewMaybe.index]
    }
    
    var life1: Life {
        cemetary[CardViewMaybe.index + 1]
    }
    
    @State var offsetX: CGFloat = 0.0
    @State var offsetY: CGFloat = 0.0
    
    @State var lastCard = false
    @State var cardsLeft = cemetary.count
    
    func CheckCards(currentLife: Life) {
        let life2 = cemetary[cemetary.count - 1]
        if life1 == life2 {
            lastCard.toggle()
        }
    }*/
    
    var body: some View {
        
        ZStack {
            
            /*Color("mainWhite")
                .ignoresSafeArea()
            
            
            ZStack {
                RoundedRectangle(cornerRadius: 48)
                    .foregroundColor(.white)
                    .shadow(color: .gray, radius: 8)
                    .padding(.horizontal, 32)
                    .aspectRatio(0.8, contentMode: .fit)
                
                //LifeView(life: life1)
                
                ForEach(cemetary) { _life in
                    LifeView(life: _life, showMainView: $showMainView, showLivesView: $showLivesView)
                }
                
                //Text(String(cardsLeft))
            }
            .frame(width: 400, height: 500)*/
        }
    }
}

/*struct LifeView: View {
    
    @EnvironmentObject var userPreferences: UserPreferences
    @AppStorage("entered") var entered: Bool = false
    
    @AppStorage("life_health_status") var life_health_status: Int = 0 {
        didSet {
            limitStatus()
        }
    }
    @AppStorage("life_happiness_status") var life_happiness_status: Int = 0 {
        didSet {
            limitStatus()
        }
    }
    @AppStorage("life_energy_status") var life_energy_status: Int = 0 {
        didSet {
            limitStatus()
        }
    }
    
    func initStatus() -> Void {
        life_health_status = 100
        life_happiness_status = 100
        life_energy_status = 100
    }
    
    @State var life: Life
    @State var offsetX: CGFloat = 0.0
    @State var offsetY: CGFloat = 0.0
    @Binding var showMainView: Bool
    @Binding var showLivesView: Bool
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 48)
                .foregroundColor(.white)
                .shadow(color: .gray, radius: 8)
                .padding(.horizontal, 32)
                .aspectRatio(0.8, contentMode: .fit)
            
            VStack {
                Text(life.name)
                    .font(.largeTitle)
                    .padding()
                Text("Age: " + String(life.age))
                    .padding()
                Text("Net Worth: $" + String(life.netWorth))
                    .padding()
                Text("Cause of Death: " + life.causeOfDeath)
                    .padding()
                
                Spacer()
                
                RoundedRectangle(cornerRadius: 16)
                    .frame(maxWidth: .infinity, maxHeight: 100)
                    .padding(24)
                    .padding(.horizontal, 32)
                    .foregroundColor(userPreferences.appColor)
                    .onTapGesture {
                        showMainView = true
                        showLivesView = false
                        entered = true
                        initStatus()
                    }
                
                //Spacer()
            }
            .foregroundColor(userPreferences.appColor)
        }
        .offset(x: offsetX, y: offsetY)
        .gesture(
            DragGesture()
                .onChanged { value in
                    offsetX = value.translation.width
                    offsetY = value.translation.height
                }
            
                .onEnded { value in
                    withAnimation(.spring()) {
                        
                        offsetY = 0
                        
                        if abs(offsetX) < 120 {
                            offsetX = 0
                        } else {
                            if offsetX > 0 {
                                offsetX = 400
                            } else {
                                offsetX = -400
                            }
                            CardViewMaybe.index += 1
                            //index += 1
                        }
                    }
                }
        )
    }
}*/

struct LivesView_Previews: PreviewProvider {
    static var previews: some View {
        /*CardViewMaybe(showMainView: .constant(false), showLivesView: .constant(true))
            .environmentObject(UserPreferences())*/
        CardViewMaybe()
    }
}
