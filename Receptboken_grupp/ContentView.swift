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
        VStack(spacing:20) {
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
            Text("Tillagningstid: \(recept.tillagningstid)")
            Text(recept.svårighetsgrad)
            ZStack(alignment: .topLeading){
                Rectangle()
                    .fill(.yellow.opacity(0.2))
                VStack(alignment: .leading){
                    ForEach(recept.ingredienser, id: \.self) { ingrediens in
                        Text("- \(ingrediens)")
                    }
                    Spacer()
                    Text(recept.instruktioner)
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

    @State private var recepts: [Recept] = [
        Recept(
            namn: "Spaghetti Carbonara",
            bild: "frying.pan.fill",
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
            bild: "frying.pan.fill",
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
            bild: "frying.pan.fill",
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
            bild: "frying.pan.fill",
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

    var body: some View {
        NavigationStack {
            List(recepts) { recept in
                NavigationLink {
                    DetailedReceptView(recept: recept)
                } label: {
                    HStack {
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

                        Text(recept.namn)
                            .font(.headline)
                        Text(recept.svårighetsgrad)
                            .font(.subheadline)
                            .italic(true)
                        Text(recept.tillagningstid)
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
