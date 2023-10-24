//
//  ContentView.swift
//  uppgift-5
//
//  Created by Hendrik on 2023-10-24.
//

/**
 Skapa nytt projekt i Xcode.
 Skapa egen modell i CreateML för image classify enligt video och länk. Kan använda exempelbilder eller själv plocka ner bilder för träning.
 Använd kod från förra veckan för att använda modell i ett projekt. Lägg in helt annan bild i projeket av samma typ som du tränat på. Gör så vid tryck på knapp så skriver den ut på resultat på text på skärmen.
 Lägg up projektet publikt på github och klista in länk nedan.
 */

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
