//
//  Education.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 1/11/22.
//

import SwiftUI

class Education: Identifiable {
    
    //@EnvironmentObject
    
    class College: Education {
        
        init(title: String, monthsRequired: Int, monthlyCost: Int, type: EducationTypes, major: CollegeMajors, emoji: String) {
            self.major = major
            super.init(title: title, monthsRequired: monthsRequired, monthlyCost: monthlyCost, type: type, emoji: emoji)
        }
        
        var major: CollegeMajors
        
        public enum CollegeMajors {
            case compSci, physics, agriculture, architecture, dental, finance, linguistics, teaching, anatomy, medical, law
        }
    }
    
    public static let ElementarySchool: Education = Education(
        title: "Elementary",
        monthsRequired: 72,
        monthlyCost: 0,
        type: .elementary,
        emoji: "👩‍🏫"
    )
    
    public static let HighSchool: Education = Education(
        title: "High School",
        monthsRequired: 36,
        monthlyCost: 50,
        type: .highSchool,
        emoji: "📚"
    )
    
    public static let CollegeSchool: Education = Education(
        title: "College", monthsRequired: 16, monthlyCost: 5_000, type: .college, emoji: "🎓"
    )
    
    
    init(title: String, monthsRequired: Int, monthlyCost: Int, type: EducationTypes, emoji: String) {
        self.title = title
        self.monthsRequired = monthsRequired
        self.monthlyCost = monthlyCost
        self._type = type
        self.emoji = emoji
    }
    
    public enum EducationTypes {
        case elementary, highSchool, college
    }
    
    var id: UUID = UUID()
    let title: String
    var monthsRequired: Int
    var monthlyCost: Int
    var _type: EducationTypes
    var type: String {
        switch _type {
            case .elementary:
                return "elementary"
            case .highSchool:
                return "highSchool"
            case .college:
                return "college"
        }
    }
    let emoji: String
    var isAvailable: Bool = false
    
    
    
    //public let College
}

struct EducationView: View {
    
    @EnvironmentObject var player: Player
    @EnvironmentObject var userPreferences: UserPreferences
    
    @Binding var showLearnTab: Bool
    @Binding var showEducationView: Bool
    
    var educationCategories: [Education] = [
        Education.ElementarySchool,
        Education.HighSchool,
        Education.CollegeSchool
    ]
}


//body
extension EducationView {
    var body: some View {
        ZStack {
            
            Color("mainWhite").ignoresSafeArea()
            
            VStack {
                Title("Education")
                mainList
                Spacer()
            }
            
            BackButton
        }
    }
}

extension EducationView {
    
    func getProgress(education: String) -> Double {
        switch education {
            case "elementary": return Double(player.education_elementary_progress)
            case "highSchool": return Double(player.education_highSchool_progress)
            case "college":    return Double(player.education_college_progress)
            default:
                //MARK: COULD CAUSE STUPID XCODE SH!T ERRORS
                return 0.0
        }
    }
    
    func getCanLearn(education: String) -> Bool {
        switch education {
            case "elementary": return player.yearsOld >= 3
            case "highSchool": return player.education_elementary_progress >= Education.ElementarySchool.monthsRequired
            case "college": return player.education_highSchool_progress >= Education.HighSchool.monthsRequired
            default: return true
        }
    }
    
    var mainList: some View {
        
        ScrollView {
            VStack {
                ForEach(educationCategories) { education in
                    
                    VStack(spacing: 12) {
                        HStack {
                            Text(education.emoji)
                                .font(Font.system(size: 64))
                            
                            VStack(spacing: 12) {
                                HStack(alignment: .bottom) {
                                    
                                    Spacer()
                                    
                                    Text(education.title)
                                        .fontWeight(.light)
                                        .font(Font.system(size: 32))
                                    
                                    Spacer()
                                    
                                    Text(formatNum(education.monthlyCost) + "/m")
                                        .font(.title)
                                }
                            }
                            
                            Spacer()
                        }
                        
                        ZStack {
                            
                            Button(action: {
                                
                                withAnimation(.linear) {
                                    switch education._type {
                                        case .elementary: player.education_elementary_progress += 1
                                        case .highSchool: player.education_highSchool_progress += 1
                                        case .college:    player.education_college_progress += 1
                                    }
                                }
                            }, label: {
                                
                                ZStack(alignment: .leading) {
                                    
                                    if Int(getProgress(education: education.type)) >= education.monthsRequired { //if they completed the school
                                        
                                        Rectangle()
                                            .fill(Color("mainMutedBlue"))
                                            .frame(width: getProgress(education: education.type) * (300.0 / Double(education.monthsRequired)), height: 80)
                                            .clipped()
                                        
                                        HStack {
                                            Spacer()
                                            Text("Complete!")
                                                .fontWeight(.medium)
                                                .brightness(0.2)
                                                .font(.title)
                                                .foregroundColor(.gray)
                                            Spacer()
                                        }
                                        
                                    } else { // if they didnt complete the school yet
                                        
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(Color("mainMutedBlue"), lineWidth: 4)
                                            .shadow(radius: 10)
                                        
                                        if getProgress(education: education.type) > 0 {
                                            Rectangle()
                                                .fill(Color("mainMutedBlue"))
                                                .frame(width: getProgress(education: education.type) * (300.0 / Double(education.monthsRequired)), height: 80)
                                                .clipped()
                                        }
                                        
                                        HStack {
                                            Spacer()
                                            Text("Study")
                                                .font(.title)
                                                .foregroundColor(.black)
                                            Spacer()
                                        }
                                    }
                                    
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 16))       // << here !!
                                .frame(width: 300, height: 80)
                            })
                            .disabled(player.life_cash_balance < education.monthlyCost || !getCanLearn(education: education.type))
                        }
                        .aspectRatio(4, contentMode: .fit)
                        .frame(width: 350)
                        
                        Capsule()
                            .foregroundColor(Color("mainDarkGray"))
                            .frame(width: .infinity, height: 2)
                            .padding(.horizontal)
                    }
                }
            }
        }
        //.padding()
    }
    
    var BackButton: some View {
        VStack {
            HStack {
                Image(systemName: "chevron.backward")
                    .font(Font.system(size: 32))
                    .foregroundColor(.red)
                    .onTapGesture {
                        showEducationView = false
                        showLearnTab = true
                    }
                Spacer()
            }
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct Education_Previews: PreviewProvider {
    static var previews: some View {
        EducationView(showLearnTab: .constant(false), showEducationView: .constant(true))
            .environmentObject(Player())
            .environmentObject(UserPreferences())
    }
}
