//
//  Screen1.swift
//  asyncAwaitBootcamp
//
//  Created by Devasurya on 02/05/24.
//

import SwiftUI



struct Screen1: View {
    
    @StateObject var viewmodelInstance = viewmodel()
    var body: some View {
        VStack {
            if let imageName = viewmodelInstance.imageName {
                Image(uiImage: imageName)
                    .imageScale(.large)
                    .foregroundStyle(.tint)
            }
            Text("Hello, world!")
        }
        .onAppear(perform: {
            Task {
            try?  await viewmodelInstance.fetchImage()
            }
        })
    }
}
#Preview {
    Screen1()
}
