//
//  CrimeView.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 4/5/22.
//

import SwiftUI

struct CrimeView: View {
    
    //links for this view and occupation view
    @Binding var showOccupationMain: Bool
    @Binding var pShowCrimeView: Bool
    
    //for crime detail
    @State var showCrimeDetail: Bool = false
    @State var showCrimeView: Bool = true
    
    @State var mode: CrimeModes? = nil
    
    public enum CrimeModes {
        case violence, drugs, theft, hacking
    }
    
    var body: some View {
        ZStack {
            Color("mainWhite").ignoresSafeArea()
            
            if showCrimeView {
                Main
                
                BackButton
            }
            
            if showCrimeDetail {
                CrimeDetail(showCrimeDetail: $showCrimeDetail, showCrimeView: $showCrimeView, mode: mode!)
            }
        }
    }
}

extension CrimeView {
    var Main: some View {
        VStack {
            Title("Crime")
            
            Spacer()
            
            HStack {
                crimeOption(title: "Drugs 💊")
                    .onTapGesture {
                        mode = .drugs
                        showCrimeDetail = true
                        showCrimeView = false
                    }
                crimeOption(title: "Violence 🔫")
                    .onTapGesture {
                        mode = .violence
                        showCrimeDetail = true
                        showCrimeView = false
                    }
            }
            .padding(.horizontal)
            
            HStack {
                crimeOption(title: "Theft 🏠")
                    .onTapGesture {
                        mode = .theft
                        showCrimeDetail = true
                        showCrimeView = false
                    }
                crimeOption(title: "Hacking 💻")
                    .onTapGesture {
                        mode = .hacking
                        showCrimeDetail = true
                        showCrimeView = false
                    }
            }
            .padding(.horizontal)
            
            Spacer()
        }
    }
    
    func crimeOption(title: String) -> some View {
        return ZStack {
            RoundedRectangle(cornerRadius: 20)
            
            Text(title)
                .foregroundColor(.white)
                .font(.title)
        }
        .foregroundColor(Color("mainDarkGray"))
        .aspectRatio(10/10, contentMode: .fit)
    }
    
    var BackButton: some View {
        
        VStack {
            HStack {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.red)
                    .font(Font.system(size: 40))
                    .onTapGesture {
                        showOccupationMain = true
                        pShowCrimeView = false
                    }
                
                Spacer()
            }
            Spacer()
        }
        .padding()
    }
}

struct CrimeView_Previews: PreviewProvider {
    static var previews: some View {
        CrimeView(showOccupationMain: .constant(false), pShowCrimeView: .constant(true), showCrimeDetail: false)
    }
}

struct Title: View {
    
    init(_ title: String, font: Font = .largeTitle) {
        self.title = title
        self.font = font
    }
    
    let title: String
    let font: Font
    
    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .font(font)
            
            Capsule()
                .frame(width: .infinity, height: 2)
        }
        .padding()
        .foregroundColor(Color("mainDarkGray"))
    }
}
