//
//  CosmosSwiftUIView.swift
//  PTC_IOS_TEST
//
//  Created by Eslam Salem on 08/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import SwiftUI
import Cosmos

// A SwiftUI wrapper for Cosmos view
struct MyCosmosView: UIViewRepresentable {
    
    @Binding var rating: Double
    var starSize: Double

    func makeUIView(context: Context) -> CosmosView {
        CosmosView()
    }

    func updateUIView(_ uiView: CosmosView, context: Context) {
        uiView.rating = rating
    
        // Autoresize Cosmos view according to it intrinsic size
        uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        uiView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
      
        // Change Cosmos view settings here
        uiView.settings.starSize = starSize
    }
}

struct ContentView: View {
    @State var rating = 3.0
  
    var body: some View {
        MyCosmosView(rating: $rating, starSize: 40)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
