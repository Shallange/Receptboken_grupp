//
//  ContentView.swift
//  Receptboken_grupp

import SwiftUI

struct Recept: Identifiable {
    let id: UUID = UUID()
    let namn: String
    let tillagningstid: String
    let svårighetsgrad: String
    let ingredienser: [String]
    let instruktioner: String
}

struct DetailedReceptView: View {
    let recept: Recept
    
    var body: some View {
        VStack(spacing: 20) {
//          Image(systemName: <#T##String#>)
            Text(recept.namn)
            Text(recept.tillagningstid)
            Text(recept.svårighetsgrad)
            ForEach(recept.ingredienser, id: \.self) { ingrediens in
                Text(ingrediens)
            }
            Text(recept.instruktioner)
        }
        .navigationTitle(recept.namn)
    }
}

struct ContentView: View {

    @State private var recepts: [Recept] = [
        Recept(
            namn: "Spaghetti Carbonara",
            tillagningstid: "20 min",
            svårighetsgrad: "Medel",
            ingredienser: [
                "Spaghetti",
                "Ägg",
                "Parmesan",
                "Bacon",
                "Svartpeppar"
            ],
            instruktioner: "Koka pastan. Stek bacon. Blanda ägg och parmesan. Blanda allt och toppa med peppar."
        ),
        
        Recept(
            namn: "Pannkakor",
            tillagningstid: "25 min",
            svårighetsgrad: "Lätt",
            ingredienser: [
                "Mjöl",
                "Mjölk",
                "Ägg",
                "Salt",
                "Smör"
            ],
            instruktioner: "Vispa ihop smeten. Stek tunna pannkakor i smör. Servera med sylt."
        ),
        
        Recept(
            namn: "Kycklinggryta",
            tillagningstid: "40 min",
            svårighetsgrad: "Medel",
            ingredienser: [
                "Kycklingfilé",
                "Grädde",
                "Paprika",
                "Lök",
                "Kryddor"
            ],
            instruktioner: "Stek kycklingen. Tillsätt grönsaker och grädde. Låt sjuda i 20 minuter."
        ),
        
        Recept(
            namn: "Tacos",
            tillagningstid: "30 min",
            svårighetsgrad: "Lätt",
            ingredienser: [
                "Tacobröd",
                "Köttfärs",
                "Tacokrydda",
                "Sallad",
                "Tomat",
                "Ost"
            ],
            instruktioner: "Stek köttfärsen med krydda. Fyll bröd med kött och grönsaker."
        ),
        
        Recept(
            namn: "Caesarsallad",
            tillagningstid: "20 min",
            svårighetsgrad: "Lätt",
            ingredienser: [
                "Romansallad",
                "Kyckling",
                "Parmesan",
                "Krutonger",
                "Caesardressing"
            ],
            instruktioner: "Stek kycklingen. Blanda med sallad, dressing och toppa med parmesan och krutonger."
        )
    ]
    
    var body: some View {
        NavigationStack {
            List(recepts) { recept in
                NavigationLink {
                    DetailedReceptView(recept: recept)
                } label: {
                    VStack {
                        Text(recept.namn)
                            .font(.headline)
                        Text(recept.tillagningstid)
                            .font(.subheadline)
                        Text(recept.svårighetsgrad)
                    }
                }
            }
            .navigationBarTitle("Receptboken")
        }
    }
}

#Preview {
    ContentView()
}
