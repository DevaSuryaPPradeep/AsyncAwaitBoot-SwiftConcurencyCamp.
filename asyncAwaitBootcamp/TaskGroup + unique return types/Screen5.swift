//
//  Screen5.swift
//  asyncAwaitBootcamp
//
//  Created by Devasurya on 29/05/24.
//

import SwiftUI

/// View
struct Screen5: View {
    
    /// Stateobject declarations.
    @StateObject var Screen5ViewmodelInstance  = Screen5ViewModel()
    
    var body: some View {
        VStack{
            Text(Screen5ViewmodelInstance.dataSource.first?.userName ?? "")
            List{
                ForEach (Screen5ViewmodelInstance.dataSource.first?.message ?? [], id: \.self) {
                    details in
                    HStack {
                        Text("\(details.message)")
                    }
                }
            }
        }
        Spacer()
            .onAppear {
                Task {
                    try? await Screen5ViewmodelInstance.getData()
                }
            }
    }
}


#Preview {
    Screen5()
}
