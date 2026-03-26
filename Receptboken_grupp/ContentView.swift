//
//  ContentView.swift
//  Receptboken_grupp

import SwiftUI

struct Recept: Identifiable {
    let id: UUID = UUID()
    let namn: String
    let bild: String
    let tillagningstid: String
    let svårighetsgrad: String
    let ingredienser: [String]
    let instruktioner: String
}


struct DetailedReceptView: View {
    
    let recept: Recept
    var body: some View {
        
        VStack(spacing: 20) {
            ZStack {
                Circle()
                    .foregroundStyle(.yellow.opacity(0.4))
                    .frame(width: 60, height: 60)
                Image(systemName: recept.bild)
                    .font(Font.largeTitle)
                    .foregroundStyle(Color.orange)
                    .padding(5)
                    .foregroundColor(Color.blue)
                    .padding(8)
                    .background(
                        Circle()
                            .stroke(.yellow, lineWidth: 4)
                    )
            }
            Spacer()
            HStack {
                Text("Tillagningstid: \(recept.tillagningstid)")
                    .font(.subheadline)
                    .foregroundStyle(Color.black.opacity(0.8))
                Text("Svårighetsgrad: \(recept.svårighetsgrad)")
                    .font(.subheadline)
                    .foregroundStyle(Color.black.opacity(0.8))

            }

            ZStack(alignment: .topLeading) {
                Rectangle()
                    .fill(.yellow.opacity(0.5))
                    .cornerRadius(20)
                VStack(alignment: .leading) {
                    GroupBox(
                        label:
                            Label("Ingredienser", systemImage: "carrot")
                            .font(.headline)
                            .foregroundStyle(Color.black.opacity(0.8))
                    ) {
                        ForEach(recept.ingredienser, id: \.self) { ingrediens in
                            Text("- \(ingrediens)")
                        }.frame(maxWidth: .infinity, alignment: .center)
                    }
                    Spacer()
                    GroupBox(
                        label:
                            Label("Gör så här:", systemImage: "frying.pan")
                            .font(.headline)
                            .foregroundStyle(Color.black.opacity(0.8))
                    ) {
                        Text(recept.instruktioner)
                    }

                    Spacer()
                }
                .bold()
                .padding()

            }
            .padding()
            Spacer()
        }
        .navigationTitle(recept.namn)
    }
}

struct ContentView: View {
    @State private var showForm: Bool = false
    @State private var search: String = ""
    @State private var recepts: [Recept] = [
        Recept(
            namn: "Spaghetti Carbonara",
            bild: "fork.knife",
            tillagningstid: "20 min",
            svårighetsgrad: "Medel",
            ingredienser: [
                "Spaghetti",
                "Ägg",
                "Parmesan",
                "Bacon",
                "Svartpeppar",
            ],
            instruktioner:
                "Koka pastan. Stek bacon. Blanda ägg och parmesan. Blanda allt och toppa med peppar."
        ),

        Recept(
            namn: "Pannkakor",
            bild: "circle.fill",
            tillagningstid: "25 min",
            svårighetsgrad: "Lätt",
            ingredienser: [
                "Mjöl",
                "Mjölk",
                "Ägg",
                "Salt",
                "Smör",
            ],
            instruktioner:
                "Vispa ihop smeten. Stek tunna pannkakor i smör. Servera med sylt."
        ),

        Recept(
            namn: "Kycklinggryta",
            bild: "cup.and.heat.waves.fill",
            tillagningstid: "40 min",
            svårighetsgrad: "Medel",
            ingredienser: [
                "Kycklingfilé",
                "Grädde",
                "Paprika",
                "Lök",
                "Kryddor",
            ],
            instruktioner:
                "Stek kycklingen. Tillsätt grönsaker och grädde. Låt sjuda i 20 minuter."
        ),

        Recept(
            namn: "Tacos",
            bild: "frying.pan.fill",
            tillagningstid: "30 min",
            svårighetsgrad: "Lätt",
            ingredienser: [
                "Tacobröd",
                "Köttfärs",
                "Tacokrydda",
                "Sallad",
                "Tomat",
                "Ost",
            ],
            instruktioner:
                "Stek köttfärsen med krydda. Fyll bröd med kött och grönsaker."
        ),

        Recept(
            namn: "Caesarsallad",
            bild: "carrot",
            tillagningstid: "20 min",
            svårighetsgrad: "Lätt",
            ingredienser: [
                "Romansallad",
                "Kyckling",
                "Parmesan",
                "Krutonger",
                "Caesardressing",
            ],
            instruktioner:
                "Stek kycklingen. Blanda med sallad, dressing och toppa med parmesan och krutonger."
        ),
    ]
    @State private var nyReceptNamn: String = ""
    @State private var nyReceptTillagningstid: String = ""
    @State private var nyReceptSvårighetsgrad: String = ""
    @State private var nyReceptIngredienser: String = ""
    @State private var nyReceptInstruktioner: String = ""

    var body: some View {
        NavigationStack {
            List { ForEach(filtreradeRecept) { recept in
                NavigationLink {
                    DetailedReceptView(recept: recept)
                } label: {
                    HStack {
                        Image(systemName: recept.bild)
                            .frame(width: 36, height: 36)
                            .font(Font.largeTitle)
                            .padding(15)
                            .foregroundStyle(Color.orange)
                            .background(
                                Circle()
                                    .fill(Color.yellow.opacity(0.4))
                                    .stroke(.yellow, lineWidth: 4)
                            )
                        
                        Text(recept.namn)
                            .font(.headline)
                        Text(recept.svårighetsgrad)
                            .font(.subheadline)
                            .italic(true)
                        Text(recept.tillagningstid)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
                
            .onDelete(perform: deleteItems)
            }
            .navigationTitle("Receptboken")
            .searchable(
                text: $search,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Hitta recept")
        }

        
        Button {
            showForm.toggle()
        } label: {
            HStack {
                if showForm{
                    Image(systemName: "minus.circle.fill")
                }else{
                    Image(systemName: "plus.circle.fill")
                }
            }
            .foregroundStyle(Color(.white))
            .font(Font.largeTitle)
            .frame(maxWidth: 200)
            .padding(5)
            .background(Color(.yellow))
            .cornerRadius(20)
        }
    
 
        if showForm{
            VStack {
                TextField("Namn", text: $nyReceptNamn)
                    .padding(10)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .border(Color.yellow, width: 2)
                    .padding(7)
                
                TextField("Svårighetsgrad", text: $nyReceptSvårighetsgrad)
                    .padding(10)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .border(Color.yellow, width: 2)
                    .padding(7)
                
                TextField("Tillagningstid", text: $nyReceptTillagningstid)
                    .padding(10)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .border(Color.yellow, width: 2)
                    .padding(7)
                
                TextField("Ingredienser. separera med kommatecken", text: $nyReceptIngredienser)
                    .padding(10)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .border(Color.yellow, width: 2)
                    .padding(7)
                
                TextField("Instruktioner", text: $nyReceptInstruktioner)
                    .padding(10)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .border(Color.yellow, width: 2)
                    .padding(7)
                
                Button () {
                    let ingrediensLista = nyReceptIngredienser
                        .split(separator: ",")
                        .map {$0.trimmingCharacters(in: .whitespacesAndNewlines)}
                        .filter {!$0.isEmpty}
                    
                    recepts.append(Recept(
                        namn: nyReceptNamn,
                        bild: "frying.pan.fill",
                        tillagningstid: nyReceptTillagningstid,
                        svårighetsgrad: nyReceptSvårighetsgrad,
                        ingredienser: ingrediensLista,
                        instruktioner: nyReceptInstruktioner))
                    
                    nyReceptNamn = ""
                    nyReceptSvårighetsgrad = ""
                    nyReceptTillagningstid = ""
                    nyReceptIngredienser = ""
                    nyReceptInstruktioner = ""
                    
                    showForm.toggle()
                    
                } label: {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Lägg till recept")
                    }
                    .foregroundStyle(Color(.white))
                    .frame(maxWidth: .infinity)
                    .padding(20)
                    .background(Color(.orange))
                    .cornerRadius(20)
                }
                .padding(.horizontal)
            }
        
        }
    }

    var filtreradeRecept: [Recept] {
        if search.isEmpty {
            return recepts
        } else {
            return recepts.filter {recept in
                recept.namn.localizedCaseInsensitiveContains(search)
            }
        }
    }
    
    func deleteItems(indexSet: IndexSet) {
        recepts.remove(atOffsets: indexSet)
    }
}

#Preview {
    ContentView()
}
