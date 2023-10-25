//
//  ContentView.swift
//  uppgift-5
//
//  Created by Hendrik on 2023-10-24.
//

/**
1. Skapa nytt projekt i Xcode. DONE
2. Skapa egen modell i CreateML för image classify enligt video och länk. Kan använda exempelbilder eller själv plocka ner bilder för träning. DONE
3. Använd kod från förra veckan för att använda modell i ett projekt. DONE
4. Lägg in helt annan bild i projeket av samma typ som du tränat på. Gör så vid tryck på knapp så skriver den ut på resultat på text på skärmen. DONE
5. Lägg up projektet publikt på github och klista in länk nedan.
 https://github.com/HendrikRuijter/uppgift-5/tree/main/uppgift-5
 */

import SwiftUI

struct ContentView: View {
    @State var result = ""
    
    var body: some View {
        VStack {
            Text("Created Cat/Elephant Model")
            Button(action: {
                let mobile_net_model = MobileNetModel()
                result = mobile_net_model.predictImage(imageset_name: "one")
            }) {
                Text("Animal")
                    .font(.title2)
                    .padding()
            }
            Button(action: {
                let mobile_net_model = MobileNetModel()
                result = mobile_net_model.predictImage( imageset_name: "two")
            }) {
                Text("Another Animal")
                    .font(.title2)
                    .padding()
            }
            Text(result)
                .font(.title3)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
