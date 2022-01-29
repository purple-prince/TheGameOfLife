//
//  EntryView.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 12/21/21.
//

import SwiftUI

struct EntryView: View {
    
    @AppStorage("entered") var entered: Bool = false
    @StateObject var userPreferences = UserPreferences()
    @StateObject var player = Player()
    
    @State var showEntryView  = true
    @State var showLivesView = false
    //@State var showMainView = false
    
    
    var body: some View {
        
        ZStack {
            
            
            
            if !entered {
                if showEntryView {
                    ColorView(showColorView: $showEntryView, showLivesView: $showLivesView)
                        .environmentObject(userPreferences)
                } else if showLivesView {
                    //LivesView(showMainView: $showMainView, showLivesView: $showLivesView)
                    NewLifeView(/*showMainView: $showMainView, showLivesView:  $showLivesView*/)
                        .environmentObject(userPreferences)
                        .environmentObject(player)
                } else {
                    Text("Error: EntryView")
                }
            } else {
                MainView()
                    .environmentObject(userPreferences)
                    .environmentObject(player)
            }
        }
        
        
    }
}

struct ColorView: View {
    
    @EnvironmentObject var userPreferences: UserPreferences
    
    @AppStorage("entered") var entered: Bool = false
    
    @Binding var showColorView: Bool
    @Binding var showLivesView: Bool

    
    var body: some View {
        ZStack {
            Color("mainWhite")
                .ignoresSafeArea()
            VStack {
                Text("Welcome!")
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .padding(40)
                    .foregroundColor(userPreferences.appColor)
                
                
                Text("Select an app color to get started. You can always change this later!")
                    .foregroundColor(userPreferences.appColor)
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
                
                picker
                    .padding(.vertical, 32)
                
                Spacer()
                
                doneButton
            }
        }

    }
    
    enum ColorCountStepper {
        case forwards, backwards
    }
    
    var picker: some View {
        HStack {
            Text("❯")
                .font(Font.system(size: 50))
                .rotationEffect(Angle.degrees(180.0))
                .onTapGesture {
                    withAnimation(.linear(duration: 0.75)) {
                        updateColorCount(.backwards)
                    }
                }
                .foregroundColor(userPreferences.appColor)
            
            RoundedRectangle(cornerRadius: 16)
                .aspectRatio(1, contentMode: .fit)
                .frame(width: 80, height: 80)
                .padding(.horizontal)
                .foregroundColor(userPreferences.appColor)
                .shadow(color: .black, radius: 2)
            
            Text("❯")
                .font(Font.system(size: 50))
                .onTapGesture {
                    withAnimation(.linear(duration: 0.75)) {
                        updateColorCount(.forwards)
                    }
                }
                .foregroundColor(userPreferences.appColor)
        }
    }
    
    func updateColorCount(_ mode: ColorCountStepper) {
        if mode == .backwards {
            if userPreferences.colorCount < 1 {
                userPreferences.colorCount = colorOptions.count
            }
            userPreferences.colorCount -= 1
        } else {
            userPreferences.colorCount += 1
            if userPreferences.colorCount >= colorOptions.count {
                userPreferences.colorCount = 0
            }
        }
    }
    
    var doneButton: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .frame(maxWidth: .infinity, maxHeight: 100)
                .padding()
                .padding(.horizontal)
                .foregroundColor(userPreferences.appColor)
            Text("Done")
                .foregroundColor(.white)
                .font(.title)
        }
        .onTapGesture {
            withAnimation(.spring()) {
                showColorView = false
                showLivesView = true
            }
        }
    }
}

struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        EntryView()
            .environmentObject(UserPreferences())
            .environmentObject(Player())
    }
}

