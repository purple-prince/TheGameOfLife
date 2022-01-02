//
//  OptionsView.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 12/28/21.
//

import SwiftUI

struct OptionsView: View {
    
    @State var showRestartLifePopup: Bool = false
    @Binding var showOptions: Bool
    
    var body: some View {
        ZStack {
            mainScreen
         
            if showRestartLifePopup {
                restartLifePopup
            }
        }
    }
}

extension OptionsView {
    var mainScreen: some View {
        ZStack {
            Color("mainWhite")
                .ignoresSafeArea()
            VStack {
                
                ZStack {
                    Text("Options")
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
                                        showOptions = false
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
                    NewLifeButton(showRestartLifePopup: $showRestartLifePopup)
                }
                
                Spacer()
            }
            .foregroundColor(Color("mainDarkGray"))
        }
    }
    
    var declineRestartButton: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.red)
            Text("Nah")
                .foregroundColor(.white)
                .font(.title2)
        }
        .padding(.leading, 16)
        .padding(.horizontal, 8)
        .onTapGesture {
            withAnimation(.easeInOut(duration: 3.0)) {
                showRestartLifePopup = false
            }
        }
    }
    
    var confirmRestartButton: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(Color("mainDarkGray"))
            Text("Confirm")
                .foregroundColor(.white)
                .font(.title2)
        }
        .onTapGesture {
            restartLife()
            showRestartLifePopup = false
        }
        .padding(.leading, 8)
        .padding(.trailing, 16)
    }
    
    var restartLifePopup: some View {
        VStack {
            
            Spacer()
            
            ZStack {
                
                RoundedRectangle(cornerRadius: 24)
                    .foregroundColor(Color.white)
                    .frame(width: .infinity, height: 200)
                    .shadow(color: .gray, radius: 12)
                
                VStack {
                    
                    Text("Are you sure you want to restart your life?")
                        .padding()
                        .multilineTextAlignment(.center)
                        .font(.title2)
                    
                    Spacer()
                    
                    HStack {
                        
                        declineRestartButton
                        
                        confirmRestartButton
                    }
                    .padding(.bottom)
                }
                .frame(width: .infinity, height: 200)
            }
            .padding(24)
            
            Spacer()
            
            Spacer()
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("mainWhite").blur(radius: 40))
    }
}

struct OptionsView_Previews: PreviewProvider {
    static var previews: some View {
        OptionsView(showOptions: .constant(false))
    }
}

struct NewLifeButton: View {
    
    @Binding var showRestartLifePopup: Bool
    
    var body: some View {
        HStack {
            Text("Restart Life")
                .font(Font.system(size: 20))
            
            Color.white
            
            Image(systemName: "arrow.triangle.2.circlepath.circle")
                .font(Font.system(size: 28))
        }
        .onTapGesture {
            showRestartLifePopup = true
        }
    }
}
