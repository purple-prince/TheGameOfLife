//
//  PetsView.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 10/30/21.
//

import SwiftUI

struct PetsView: View {
    
    @EnvironmentObject var player: Player
    
    @Binding var showRelationshipTab: Bool
    @Binding var showPetsView: Bool
    
    @State var showFindPetView: Bool = false
    
    var body: some View {
        ZStack {
            Color("mainWhite").ignoresSafeArea()
            
            if showFindPetView {
                FindPetView()
            } else {
                VStack {
                    Banner
                    
                    Divider()
                    
                    if player.pet_names == "" {
                        
                        NoPetsView
                        
                        Spacer()
                    } else {
                        ScrollView {
                            
                            Text(String(player.pet_names == ""))
                                                        
                            ForEach(player.allPets, id: \.self) { pet in
                                Text(pet.emoji)
                            }
                        }
                    }
                }
                .padding(.top, 24)
                
                BackButton
            }
        }
    }
}

extension PetsView {
    var Banner: some View {
        VStack /*current job*/ {
            Spacer()
            
            Text("Pets")
                .bold()
                .font(.largeTitle)
            Spacer()
            Text("-0.5/month")
                .font(.title3)
            
            Spacer()
        }
        //REMOVE THIS
        .onTapGesture {
            player.pet_names = ""
            player.pet_status = ""
            player.pet_types = ""
            player.pet_ids = ""
        }
        .frame(maxWidth: .infinity, maxHeight: 150)
        .background(Color("mainDarkGray"))
        .foregroundColor(.white)
        .cornerRadius(18)
        .shadow(radius: 12)
        .padding()
    }
    
    var BackButton: some View {
        VStack {
            HStack {
                Image(systemName: "chevron.left")
                    .font(Font.system(size: 32))
                    .foregroundColor(.red)
                    .padding(.horizontal)
                    .onTapGesture {
                        showRelationshipTab = true
                        showPetsView = false
                    }
                Spacer()
            }
            
            Spacer()
        }
    }
    
    var NoPetsView: some View {
        VStack {
            Text("No Pets 😿")
                .fontWeight(.light)
                .font(.largeTitle)
            
            Button(action: {
                showFindPetView = true
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                    Text("Adopt a pet")
                        .fontWeight(.medium)
                        .font(.title)
                        .foregroundColor(.green)
                }
                .foregroundColor(Color("mainDarkGray"))
                .aspectRatio(6/2, contentMode: .fit)
                .frame(width: .infinity)
                .padding(.horizontal)
                .padding(.horizontal)
                .padding(.horizontal)
            })
        }
    }
}

struct FindPetView: View {
    
    @EnvironmentObject var player: Player
    
    let petNames = [
        "Abigail" , "Ace",     "Adam",    "Addie",    "Admiral", "Aggie", "Aires", "Aj", "Ajax", "Aldo",
        "Alex"    , "Alexus",  "Alf",      "Alfie",   "Allie",   "Ally", "Amber", "Amie", "Amigo", "Amos",
        "Amy"     , "Andy",    "Angel",    "Angus",   "Annie",   "Apollo", "April", "Archie", "Argus", "Aries",
        "Armanti" , "Arnie",   "Arrow",    "Ashes",   "Ashley",  "Astro", "Athena", "Atlas", "Audi", "Augie",
        "Aussie"  , "Austin",  "Autumn",   "Axel",    "Axle",    "Babbles", "Babe", "Baby", "Babykins", "Bacchus",
        "Bailey"  , "Bambi",   "Bandit",   "Banjo",   "Barbie",  "Barclay", "Barker", "Barkley", "Barley", "Barnaby",
        "Barney"  , "Baron",   "Bart",     "Basil",   "Baxter",  "Beamer", "Beanie", "Beans", "Bear", "Beau",
        "Beauty"  , "Beaux",   "Bebe",     "Beetle",  "Bella",   "Belle", "Ben", "Benji", "Benny", "Benson",
        "Bentley" , "Bernie",  "Bessie",   "Biablo",  "Bibbles", "Biggie", "Billie", "Billy", "Bingo", "Binky",
        "Birdie"  , "Birdy",   "Biscuit",  "Bishop",  "Gus",     "Guy", "Gypsy", "Hailey", "Haley", "Hallie",
        "Hamlet"  , "Hammer",  "Hank",     "Hanna",   "Hannah",  "Hans", "Happy", "Hardy", "Harley", "Harpo",
        "Harrison", "Harry",   "Harvey",   "Heather", "Heidi",   "Henry", "Hercules", "Hershey", "Higgins", "Hobbes",
        "Holly"   , "Homer",   "Honey",    "Hooch",   "Hoover",  "Hope", "Houdini", "Howie", "Hudson", "Huey",
        "Hugh"    , "Hugo",    "Humphrey", "Hunter",  "India",   "Indy", "Iris", "Isabella", "Isabelle", "Itsy",
        "Ivory"   , "Ivy",     "Izzy",     "Jack",    "Jackie",  "Jackpot", "Jackson", "Jade", "Jagger", "Jags",
        "Jaguar"  , "Jake",    "Jamie",    "Jasmine", "Jasper",  "Jaxson", "Jazmie", "Jazz", "Jelly", "Jenna",
        "Jenny"   , "Jerry",   "Jersey",   "Jess",    "Jesse",   "Jessie", "Jester", "Jet", "Jett", "Jetta",
        "Jewel"   , "Jewels",  "Jimmy",    "Jingles", "JJ",      "Joe", "Joey", "Johnny", "Jojo", "Joker",
        "Jolie"   , "Jolly",   "Jordan",   "Josie",   "Joy",     "JR", "Judy", "Julius", "June", "Misty",
        "Mitch"   , "Mittens", "Mitzi",    "Mitzy",   "Mo",      "Mocha", "Mollie", "Molly", "Mona", "Muffy",
        "Nakita"  , "Nala",    "Nana",     "Natasha", "Nellie",  "Nemo", "Nena", "Peanut", "Peanuts", "Pearl",
        "Pebbles" , "Penny" ,  "Phoebe",   "Phoenix", "Sara",    "Sarah", "Sasha", "Sassie", "Sassy", "Savannah",
        "Scarlett", "Shasta",  "Sheba",    "Sheena",  "Shelby",  "Shelly", "Sienna", "Sierra",  "Silky", "Silver",
        "Simone"  , "Sissy" ,  "Skeeter",  "Sky",     "Skye",    "Skyler", "Waldo",  "Wallace", "Wally", "Walter",
        "Wayne"   , "Weaver",  "Webster",  "Wesley",  "Westie"
    ]
    
    var body: some View {
        ZStack {
            Color("mainWhite").ignoresSafeArea()
            
            VStack(spacing: 8) {
                
                Text("Pet Store")
                    .font(.largeTitle)

                Divider()
                
                ScrollView {
                    VStack {
                        CategoryRow(Pet.Dog)
                        CategoryRow(Pet.Cat)
                        CategoryRow(Pet.Fish)
                        CategoryRow(Pet.Bird)
                        CategoryRow(Pet.Rabbit)
                        CategoryRow(Pet.Turtle)
                        CategoryRow(Pet.Alligator)
                        CategoryRow(Pet.Monkey)
                    }
                }
            }
        }
    }
    
    func CategoryRow(_ pet: Pet) -> some View {
        
        return VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                Text(pet.emoji)
                    .font(Font.system(size: 60))
                    .padding(.trailing, 12)
                
                VStack(alignment: .leading) {
                    Text(pet.animal)
                        .fontWeight(.thin)
                        .lineLimit(1)
                        .font(Font.system(size: 32))
                    
                    HStack(spacing: 16) {
                        
                        Text("+ \(pet.hapMod) 😀")
                            .foregroundColor(.green)
                        
                        Text("- " + formatNum(pet.cost) + "/mo")
                            .foregroundColor(.red)
                    }
                }
                         
                Spacer()
                
                Button(action: {
                    player.pet_types += pet.animal
                    player.pet_status += "100"
                    player.pet_names += petNames.randomElement()!
                    player.pet_ids += UUID().uuidString
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(Color("mainDarkGray"))
                        
                        Text("Adopt")
                            .foregroundColor(.white)                        
                    }
                    .aspectRatio(3/2, contentMode: .fit)
                    .frame(width: 74)
                })
                
                
            }
            .padding(8)
            
            
            Capsule()
                .foregroundColor(Color("mainDarkGray"))
                .frame(width: .infinity, height: 1)
                .padding(.horizontal)
                .padding(.horizontal)
        }
        
    }
}

struct Pet: Hashable {
    
    static let Dog: Pet       = Pet(emoji: "🐶", animal: "Dog",       hapMod: 6, cost: 200)
    static let Cat: Pet       = Pet(emoji: "🐱", animal: "Cat",       hapMod: 5, cost: 125)
    static let Fish: Pet      = Pet(emoji: "🐠", animal: "Fish",      hapMod: 1, cost: 25)
    static let Bird: Pet      = Pet(emoji: "🐦", animal: "Bird",      hapMod: 2, cost: 75)
    static let Rabbit: Pet    = Pet(emoji: "🐰", animal: "Rabbit",    hapMod: 4, cost: 275)
    static let Turtle: Pet    = Pet(emoji: "🐢", animal: "Turtle",    hapMod: 3, cost: 320)
    static let Alligator: Pet = Pet(emoji: "🐊", animal: "Alligator", hapMod: 8, cost: 750)
    static let Monkey: Pet    = Pet(emoji: "🦧", animal: "Monke",     hapMod: 50, cost: 69_000_000)
    
    let emoji: String
    let animal: String
    let hapMod: Int
    let cost: Int
    var name: String = ""
    var status: Int = 100
    var id: String = UUID().uuidString
    
    
    init(emoji: String, animal: String, hapMod: Int, cost: Int) {
        self.emoji = emoji
        self.animal = animal
        self.hapMod = hapMod
        self.cost = cost
    }
    
    init(emoji: String, animal: String, hapMod: Int, cost: Int, name: String, status: Int, id: String) {
        self.emoji = emoji
        self.animal = animal
        self.hapMod = hapMod
        self.cost = cost
        self.name = name
        self.status = status
        self.id = id
    }
}

struct PetsView_Previews: PreviewProvider {
    static var previews: some View {
        PetsView(showRelationshipTab: .constant(false), showPetsView: .constant(true))
            .environmentObject(Player())
        
//        FindPetView()
//            .environmentObject(Player())
    }
}
