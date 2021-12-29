//
//  OptionsView.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 12/28/21.
//

import SwiftUI

struct OptionsView: View {
    @Binding var showSettings: Bool
    
    var body: some View {
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
                    //ColorSetting()
                }
                
                Spacer()
            }
            .foregroundColor(Color("mainDarkGray"))
        }
    }
}

struct OptionsView_Previews: PreviewProvider {
    static var previews: some View {
        OptionsView(showSettings: .constant(false))
    }
}
