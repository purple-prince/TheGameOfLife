//
//  ActionTab.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 8/11/21.
//

import SwiftUI

protocol ActionView {
    var frameWidth: CGFloat { get }
    var frameHeight: CGFloat { get }
}

extension ActionView {
    var frameWidth: CGFloat {
        CGFloat.infinity
    }
    
    var frameHeight: CGFloat {
        240
    }
}


struct ActionTab: View {
    
    @State var showCasinoView = false
    @State var showMainView: Bool = true
        
    var body: some View {
        ZStack {
            
            if showMainView {
                ZStack {
                    Color("mainWhite")
                        .ignoresSafeArea()
                    
                    ScrollView(showsIndicators: false) {
                        VStack {
                            CasinoIcon()
                                .onTapGesture {
                                    showCasinoView = true
                                }
                        }
                    }
                }
            }
            
            if showCasinoView {
                CasinoView(showCasinoView: $showCasinoView, showMainView: $showMainView)
            }
        }
    }
}

struct ActionTab_Previews: PreviewProvider {
    static var previews: some View {
        ActionTab()
    }
}
