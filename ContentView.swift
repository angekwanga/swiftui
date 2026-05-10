//
//  ContentView.swift
//  Memospiel
//
//  Created by Ange Kwanga on 10.05.26.
//

import SwiftUI

struct ContentView: View {
    
    // Karten, die momentan im Spiel angezeigt werden.
    // Beim Start bleibt die Oberfläche zuerst leer.
    @State private var aktuelleKarten: [String] = []
    
    // Diese ID sorgt dafür, dass die Karten nach einer neuen Themenwahl
    // wieder als neue Karten geladen werden.
    @State private var spielRunde = UUID()
    
    // Themen der App. Jedes Thema hat unterschiedlich viele Emojis.
    private let tiere = ["🐻", "🐭", "🐵", "🐬"]
    private let fahrzeuge = ["🚗", "🚕", "🚌", "🚀", "🚁"]
    private let flaggen = ["🇩🇪", "🇫🇷", "🇮🇹", "🇪🇸", "🇯🇵", "🇧🇷"]
    
    // Die Spalten passen sich automatisch an die Bildschirmbreite an.
    private let spalten = [
        GridItem(.adaptive(minimum: 70), spacing: 8)
    ]
    
    var body: some View {
        VStack(spacing: 16) {
            
            // Titel oben auf dem Bildschirm.
            Text("Memospiel!")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // ScrollView hilft, wenn auf kleinen Bildschirmen
            // oder im Querformat nicht alle Karten sofort Platz haben.
            ScrollView {
                LazyVGrid(columns: spalten, spacing: 8) {
                    ForEach(aktuelleKarten.indices, id: \.self) { index in
                        CardView(content: aktuelleKarten[index])
                    }
                }
                .id(spielRunde)
            }
            
            // Themenauswahl unten.
            HStack {
                themaButton(
                    titel: "Tiere",
                    symbol: "pawprint.fill",
                    emojis: tiere
                )
                
                Spacer()
                
                themaButton(
                    titel: "Fahrzeuge",
                    symbol: "car.fill",
                    emojis: fahrzeuge
                )
                
                Spacer()
                
                themaButton(
                    titel: "Flaggen",
                    symbol: "flag.fill",
                    emojis: flaggen
                )
            }
        }
        .padding()
    }
    
    // Erstellt einen Button für ein Thema.
    // Das Symbol steht oben, der Text darunter.
    private func themaButton(titel: String, symbol: String, emojis: [String]) -> some View {
        Button {
            themaAuswaehlen(emojis)
        } label: {
            VStack(spacing: 6) {
                Image(systemName: symbol)
                    .font(.title)
                    .imageScale(.large)
                
                Text(titel)
                    .font(.caption)
            }
        }
    }
    
    // Aus jedem Emoji werden zwei Karten erzeugt.
    // Danach wird die Reihenfolge zufällig gemischt.
    private func themaAuswaehlen(_ emojis: [String]) {
        aktuelleKarten = (emojis + emojis).shuffled()
        spielRunde = UUID()
    }
}

struct CardView: View {
    
    let content: String
    
    // Die Karten sind am Anfang verdeckt.
    @State private var istGesichtOben = false
    
    var body: some View {
        ZStack {
            let basis = RoundedRectangle(cornerRadius: 12)
            
            if istGesichtOben {
                basis.fill(.white)
                basis.strokeBorder(lineWidth: 2)
                
                Text(content)
                    .font(.largeTitle)
            } else {
                basis.fill()
            }
        }
        .aspectRatio(2/3, contentMode: .fit)
        .onTapGesture {
            istGesichtOben.toggle()
        }
    }
}

#Preview {
    ContentView()
}
