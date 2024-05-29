//
//  Screen4.swift
//  asyncAwaitBootcamp
//
//  Created by Devasurya on 29/05/24.
//

import SwiftUI

/// View.
struct Screen4: View {
    
    /// Stateobject declarations.
    @StateObject var viewmodelInstance: Screen4ViewModel = Screen4ViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewmodelInstance.dataArray,id: \.self) {
                    Text($0.title)
                }
            }
            .navigationTitle(Text("Live News..."))
        }
        .task {
            do {
                try await  viewmodelInstance.getData()
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    Screen4()
}
