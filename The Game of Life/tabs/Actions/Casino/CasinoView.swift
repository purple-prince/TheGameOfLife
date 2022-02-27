//
//  CasinoView.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 1/5/22.
//

import SwiftUI

struct CasinoView: View {
    
    @Binding var showCasinoView: Bool
    @Binding var showMainView: Bool
    
    @EnvironmentObject var player: Player
    
    @State var showCrashPopup:     Bool = false
    @State var showLotteryView:    Bool = false
    @State var showSlotsView:      Bool = false
    @State var showBlackjackView:  Bool = false
    @State var showCasinoViewMain: Bool = true
    
    @EnvironmentObject var userPreferences: UserPreferences
    
    
    @State var showLotteryPopup = false
    
    var body: some View {
        ZStack {
            Color("mainWhite")
                .ignoresSafeArea()
                                                            
            Main
            
            header
            
            if showLotteryPopup {
                LotteryPopup(showLotteryPopup: $showLotteryPopup)
            }
            
            if showCrashPopup {
                CrashPopup(showCasinoView: $showCasinoView, showCrashPopup: $showCrashPopup)
            }
        }
    }
}

struct CasinoSwiper: View {
    
    @Binding var showLotteryPopup: Bool
    @Binding var showCrashPopup  : Bool
        
    enum CasinoActions {
        case blackjack, lottery, crash
    }
    
    let casinoActions: [CasinoActions] = [.crash, .blackjack, .lottery, .crash]
    
    @State var currentIndex = 0
        
    @State var currentOffsetX: CGFloat = 0
    @State var currentOffsetY: CGFloat = 0
    @State var nextOffsetX: CGFloat = 350
    
    //150 = breaking point
    @State var count = 0
    var body: some View {

        ZStack {
            nextIcon
                .offset(x: nextOffsetX)
            currentIcon
                .onTapGesture {
                    if currentIndex == 2 {
                        showLotteryPopup = true
                    } else if currentIndex == 0 {
                        showCrashPopup = true
                    }
                }
                .onChange(of: currentIndex) { _ in
                    currentOffsetX = 0
                    nextOffsetX = 350
                    
                    if currentIndex > 2 {
                        currentIndex = 0
                    }
                }
                .offset(x: currentOffsetX)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            if value.translation.width < 0 {
                                currentOffsetX = value.translation.width
                                nextOffsetX = 350 + value.translation.width
                            }
                        }
                    
                        .onEnded { value in
                            if value.translation.width < -150 {
                                withAnimation(.easeOut) {  //ANIMATED
                                    currentOffsetX = -350
                                    nextOffsetX = 0
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    currentIndex += 1
                                }
                                
                            } else {
                                withAnimation(.easeOut) { //ANIMATED
                                    currentOffsetX = 0
                                    nextOffsetX = 350
                                }
                            }
                        }
                )
        }
    }
    
    var nextIcon: some View {
        return Group {
            switch casinoActions[currentIndex] {
                case .blackjack:
                    LotteryIcon
                case .crash:
                    BlackjackIcon
                case .lottery:
                    CrashIcon
            }
        }
    }
    
    var currentIcon: some View {
        return Group {
            switch casinoActions[currentIndex] {
                case .blackjack:
                    BlackjackIcon
                case .crash:
                    CrashIcon
                case .lottery:
                    LotteryIcon
            }
        }
        //.transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
    }
    
    var CrashIcon: some View {
        Text("📈")
            .font(Font.system(size: 220))
    }
    
    var BlackjackIcon: some View {
        ZStack {
            ZStack {
                
                Color("mainWhite")
                    .frame(width: 130, height: 180)
                    .offset(x: 0, y: 20)
                
                Text("🃛")
                    .font(Font.system(size: 220))
            }
            .rotationEffect(Angle(degrees: -15))
            
            
            ZStack {
                
                Color("mainWhite")
                    .frame(width: 130, height: 180)
                    .offset(x: 0, y: 20)
                
                Text("🂡")
                    .font(Font.system(size: 220))
            }
            .offset(x: 40)
            .rotationEffect(Angle(degrees: 15))
        }
        .padding(.horizontal)
    }
    
    var LotteryIcon: some View {
        Text("🎟")
            .font(Font.system(size: 220))
            .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
    }
}

extension CasinoView {
    var header: some View {
        VStack {
            HStack {
                Image(systemName: "chevron.backward")
                    .foregroundColor(Color("mainDarkGray"))
                    .font(.largeTitle)
                    .onTapGesture {
                        showCasinoView = false
                        showMainView = true
                    }
                
                Spacer()
            }
            
            Spacer()
        }
        .padding()
    }
        
    var Main: some View {
        VStack {
            
            VStack(spacing: 8) {
                Text("Casino")
                    .font(Font.system(size: 40))
                Capsule()
                    .frame(width: .infinity, height: 1)
            }
            .padding()
            .foregroundColor(Color("mainDarkGray"))
            
            Spacer()
            
            CasinoSwiper(showLotteryPopup: $showLotteryPopup, showCrashPopup: $showCrashPopup)
            
            HStack(spacing: 0) {
                Text("All Time Winnings: ")
                    .fontWeight(.light)
                
                //TODO: Uncomment
//                Text(formatNum(player.total_lottery_winnings))
//                    .foregroundColor(player.total_lottery_winnings < 0 ? .red : .green)
            }
            .padding(.top)
            .padding(.top)
            .font(.title2)
            
            Spacer()
            Spacer()
        }
    }
}

struct CasinoView_Previews: PreviewProvider {
    static var previews: some View {
        CasinoView(showCasinoView: .constant(false), showMainView: .constant(false))
            .environmentObject(UserPreferences())
            .environmentObject(Player())
    }
}
