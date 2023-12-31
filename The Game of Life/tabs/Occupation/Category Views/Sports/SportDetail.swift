//
//  SportDetail.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 4/5/22.
//

import SwiftUI

struct SportDetail: View {
    
    init(showSportsView: Binding<Bool>, showSportDetail: Binding<Bool>, mode: SportsView.SportModes) {
        
        self.mode = mode
        
        switch mode {
            case .soccer:     self.sport = Sport.Soccer
            case .football:   self.sport = Sport.Football
            case .basketball: self.sport = Sport.Basketball
            case .hockey:     self.sport = Sport.Hockey
            case .baseball:   self.sport = Sport.Baseball
        }
        
        self._showSportsView = showSportsView
        self._showSportDetail = showSportDetail
        
    }
    
    @Binding var showSportsView: Bool
    @Binding var showSportDetail: Bool
    
    let mode: SportsView.SportModes
    let sport: Sport
    
    var body: some View {
        ZStack {
            Color("mainWhite").ignoresSafeArea()
            
            VStack {
                Main
                Spacer()
            }
            BackButton
        }
    }
}

extension SportDetail {
    var BackButton: some View {
        VStack {
            HStack {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.red)
                    .font(Font.system(size: 40))
                    .onTapGesture {
                        showSportsView = true
                        showSportDetail = false
                    }
                
                Spacer()
            }
            Spacer()
        }
        .padding()
    }
    
    var Title: some View {
        VStack(spacing: 8) {
            Text(sport.title)
                .font(.largeTitle)
            Capsule()
                .frame(width: .infinity, height: 2)
            
            Text("Lifetime earnings: $9.8k")
        }
        .foregroundColor(Color("mainDarkGray"))
        .padding()
    }
    
    var Main: some View {
        VStack {
            Title
        }
    }
}

struct SportDetail_Previews: PreviewProvider {
    static var previews: some View {
        SportDetail(showSportsView: .constant(false), showSportDetail: .constant(true), mode: .baseball)
    }
}
