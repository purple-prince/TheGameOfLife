//
//  EntryView.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 12/21/21.
//

import SwiftUI

struct EntryView: View {
    
    @AppStorage("entered") var entered: Bool = false
    @AppStorage("app_color_index") var colorCount: Int = 0
    
    @State var showEntryView  = true
    @State var showLivesView = false
    @State var showMainView = false
    
    
    
    
    var body: some View {
        
        if !entered {
            if showEntryView {
                ColorView(showColorView: $showEntryView, showLivesView: $showLivesView)
            } else if showLivesView {
                LivesView(showMainView: $showMainView, showLivesView: $showLivesView)
            } else if showMainView {
                MainView()
            } else {
                Text("Error: EntryView")
            }
        } else {
            MainView()
        }
    }
}

struct ColorView: View {
    
    @AppStorage("entered") var entered: Bool = false
    @AppStorage("app_color_index") var colorCount: Int = 0
    
    @Binding var showColorView: Bool
    @Binding var showLivesView: Bool

    var appColor: Color {
        colorOptions[colorCount]
    }
    
    var body: some View {
        ZStack {
            Color("mainWhite")
                .ignoresSafeArea()
            VStack {
                Text("Welcome!")
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .padding(40)
                    .foregroundColor(appColor)
                
                
                Text("Select an app color to get started. You can always change this later!")
                    .foregroundColor(appColor)
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
                .foregroundColor(appColor)
            
            RoundedRectangle(cornerRadius: 16)
                .aspectRatio(1, contentMode: .fit)
                .frame(width: 80, height: 80)
                .padding(.horizontal)
                .foregroundColor(appColor)
                .shadow(color: .black, radius: 2)
            
            Text("❯")
                .font(Font.system(size: 50))
                .onTapGesture {
                    withAnimation(.linear(duration: 0.75)) {
                        updateColorCount(.forwards)
                    }
                }
                .foregroundColor(appColor)
        }
    }
    
    func updateColorCount(_ mode: ColorCountStepper) {
        if mode == .backwards {
            if colorCount < 1 {
                colorCount = colorOptions.count
            }
            colorCount -= 1
        } else {
            colorCount += 1
            if colorCount >= colorOptions.count {
                colorCount = 0
            }
        }
    }
    
    var doneButton: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .frame(maxWidth: .infinity, maxHeight: 100)
                .padding()
                .padding(.horizontal)
                .foregroundColor(appColor)
            Text("Done")
                .foregroundColor(.white)
                .font(.title)
        }
        .onTapGesture {
            entered.toggle()
            
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
    }
}

