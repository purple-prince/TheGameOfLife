//
//  SettingsView.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 12/26/21.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var showSettings: Bool
    
    var body: some View {
        ZStack {
            Color("mainWhite")
                .ignoresSafeArea()
            VStack {
                
                ZStack {
                    Text("Settings")
                        .font(.largeTitle)
                        .padding(.horizontal)
                        .padding(.top)
                    
                    HStack {
                        VStack {
                            
                            Spacer()
                                .frame(width: 0, height: 20)
                            
                            Image(systemName: "chevron.backward")
                                .font(Font.system(size: 32))
                                .padding(.horizontal)
                                .onTapGesture {
                                    withAnimation(.linear) {
                                        showSettings = false
                                    }
                                }
                        }
                        
                        Spacer()
                    }
                }
                
                RoundedRectangle(cornerRadius: 24)
                    .frame(width: UIScreen.main.bounds.width - 124, height: 2)
                    .padding(.bottom)
                
                //settings options
                List() {
                    ColorSetting()
                }
                
                Spacer()
            }
            .foregroundColor(Color("mainDarkGray"))
        }
    }
}

struct ColorSetting: View {
    
    @EnvironmentObject var userPreferences: UserPreferences

     /*var appColor: Color {
         colorOptions[colorCount]
     }*/
    
    @State var showColorChoices = false
    
    var body: some View {
        
        ZStack {
            standardView
            if showColorChoices {
                colorChoiceView
                    .transition(.move(edge: .trailing))
            }
            
        }
    }
}


extension ColorSetting {
    var standardView: some View {
        GeometryReader { geometry in
            HStack {
                Text("App Color")
                Spacer()
                userPreferences.appColor
                    .clipShape(Capsule())
                    .frame(width: geometry.size.width / 5)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            showColorChoices.toggle()
                        }
                    }
            }
        }
    }
    
    var colorChoiceView: some View {
        HStack{
            
            Color.white
            
            ForEach(colorOptions, id: \.self) { color in
                color
                    .clipShape(Capsule())
                    .onTapGesture {
                        withAnimation(.spring()) {
                            showColorChoices.toggle()
                        }
                        //colorCount = colorOptions.firstIndex(of: color) ?? colorCount
                        userPreferences.colorCount = colorOptions.firstIndex(of: color) ?? userPreferences.colorCount
                    }
            }
        }
        .background(Color.white)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(showSettings: .constant(false))
            .environmentObject(UserPreferences())
    }
}
