//
//  RelationshipDetail.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 10/30/21.
//

import SwiftUI

struct RelationshipDetail: View {
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
                        .foregroundColor(.black)
                    })
                    Button(action:{}, label: {
                        HStack {
                            Text("Mom")
                            Spacer()
                            Text("Status")
                        }
                        .padding()
                        .font(.system(size: 20))
                        .foregroundColor(.black)
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
                        .foregroundColor(.black)
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
                            .foregroundColor(.black)
                        })
                        Button(action:{}, label: {
                            HStack {
                                Text("child 3")
                                Spacer()
                                Text("Status")
                            }
                            .padding()
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                        })
                        Button(action:{}, label: {
                            HStack {
                                Text("child 4")
                                Spacer()
                                Text("Status")
                            }
                            .padding()
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                        })
                        Button(action:{}, label: {
                            HStack {
                                Text("child 5")
                                Spacer()
                                Text("Status")
                            }
                            .padding()
                            .font(.system(size: 20))
                            .foregroundColor(.black)
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
                            .foregroundColor(.black)
                        })
                        Button(action:{}, label: {
                            HStack {
                                Text("child 3")
                                Spacer()
                                Text("Status")
                            }
                            .padding()
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                        })
                        Button(action:{}, label: {
                            HStack {
                                Text("child 4")
                                Spacer()
                                Text("Status")
                            }
                            .padding()
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                        })
                        Button(action:{}, label: {
                            HStack {
                                Text("child 5")
                                Spacer()
                                Text("Status")
                            }
                            .padding()
                            .font(.system(size: 20))
                            .foregroundColor(.black)
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
                            .foregroundColor(.black)
                        })
                        Button(action:{}, label: {
                            HStack {
                                Text("pet 2")
                                Spacer()
                                Text("Status")
                            }
                            .padding()
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                        })
                        Button(action:{}, label: {
                            HStack {
                                Text("pet 3")
                                Spacer()
                                Text("Status")
                            }
                            .padding()
                            .font(.system(size: 20))
                            .foregroundColor(.black)
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
            
            Divider()
            
            memberList(memberMode)
            Spacer()
        }
        .offset(y: 72)
        .ignoresSafeArea()
        //.navigationBarHidden(true)
    }
}

struct RelationshipDetail_Previews: PreviewProvider {
    static var previews: some View {
        RelationshipDetail(memberMode: "Parents")
    }
}
