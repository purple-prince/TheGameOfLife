//
//  RelationshipDetail.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 10/30/21.
//

import SwiftUI

struct RelationshipDetail: View {
    
    @AppStorage("app_color_index") var colorCount: Int = 0
    
    var appColor: Color {
        colorOptions[colorCount]
    }
    
    let memberMode: String
    
    func memberList(_ tempMode: String) -> some View {
        
        Group {
            switch tempMode {
            case "Parents":
                VStack {
                    Button(action:{}, label: {
                        HStack {
                            Text("Mom")
                            Spacer()
                            Text("Status")
                        }
                        .padding()
                        .font(.system(size: 20))
                        .foregroundColor(appColor)
                    })
                    Button(action:{}, label: {
                        HStack {
                            Text("Mom")
                            Spacer()
                            Text("Status")
                        }
                        .padding()
                        .font(.system(size: 20))
                        .foregroundColor(appColor)
                    })
                }
            case "Romance":
                VStack {
                    Button(action:{}, label: {
                        HStack {
                            Text("Baefy")
                            Spacer()
                            Text("Status")
                        }
                        .padding()
                        .font(.system(size: 20))
                        .foregroundColor(appColor)
                    })
                }
            case "Children":
                ScrollView {
                    VStack {
                        Button(action:{}, label: {
                            HStack {
                                Text("child")
                                Spacer()
                                Text("Status")
                            }
                            .padding()
                            .font(.system(size: 20))
                            .foregroundColor(appColor)
                        })
                        Button(action:{}, label: {
                            HStack {
                                Text("child 3")
                                Spacer()
                                Text("Status")
                            }
                            .padding()
                            .font(.system(size: 20))
                            .foregroundColor(appColor)
                        })
                        Button(action:{}, label: {
                            HStack {
                                Text("child 4")
                                Spacer()
                                Text("Status")
                            }
                            .padding()
                            .font(.system(size: 20))
                            .foregroundColor(appColor)
                        })
                        Button(action:{}, label: {
                            HStack {
                                Text("child 5")
                                Spacer()
                                Text("Status")
                            }
                            .padding()
                            .font(.system(size: 20))
                            .foregroundColor(appColor)
                        })
                    }
                }
            case "Friends":
                ScrollView {
                    VStack {
                        Button(action:{}, label: {
                            HStack {
                                Text("child")
                                Spacer()
                                Text("Status")
                            }
                            .padding()
                            .font(.system(size: 20))
                            .foregroundColor(appColor)
                        })
                        Button(action:{}, label: {
                            HStack {
                                Text("child 3")
                                Spacer()
                                Text("Status")
                            }
                            .padding()
                            .font(.system(size: 20))
                            .foregroundColor(appColor)
                        })
                        Button(action:{}, label: {
                            HStack {
                                Text("child 4")
                                Spacer()
                                Text("Status")
                            }
                            .padding()
                            .font(.system(size: 20))
                            .foregroundColor(appColor)
                        })
                        Button(action:{}, label: {
                            HStack {
                                Text("child 5")
                                Spacer()
                                Text("Status")
                            }
                            .padding()
                            .font(.system(size: 20))
                            .foregroundColor(appColor)
                        })
                    }
                }
            case "Pets":
                ScrollView {
                    VStack {
                        Button(action:{}, label: {
                            HStack {
                                Text("pet 1")
                                Spacer()
                                Text("Status")
                            }
                            .padding()
                            .font(.system(size: 20))
                            .foregroundColor(appColor)
                        })
                        Button(action:{}, label: {
                            HStack {
                                Text("pet 2")
                                Spacer()
                                Text("Status")
                            }
                            .padding()
                            .font(.system(size: 20))
                            .foregroundColor(appColor)
                        })
                        Button(action:{}, label: {
                            HStack {
                                Text("pet 3")
                                Spacer()
                                Text("Status")
                            }
                            .padding()
                            .font(.system(size: 20))
                            .foregroundColor(appColor)
                        })
                    }
                }
                
            default:
                Text("Error: sorry idk what went wrong lol... restart app")
            }
        }
    }
    
    var body: some View {
                
        VStack {
            banner
            
            Divider()
            
            memberList(memberMode)
            
            Spacer()
        }
        .offset(y: 72)
        .ignoresSafeArea()
        //.navigationBarHidden(true)
    }
}

extension RelationshipDetail {
    var banner: some View {
        VStack /*current job*/ {
            Spacer()
            
            Text(memberMode)
                .bold()
                .font(.largeTitle)
            Spacer()
            Text("-0.5/month")
                .font(.title3)
            
            Spacer()
        }
        .font(Font.custom("mainFont", size: 20))
        .frame(maxWidth: .infinity, maxHeight: 150)
        .background(Color("neonGreen"))
        .foregroundColor(.black)
        .cornerRadius(12)
        .shadow(radius: 12)
        .padding()
    }
}

struct RelationshipDetail_Previews: PreviewProvider {
    static var previews: some View {
        RelationshipDetail(memberMode: "Parents")
    }
}
