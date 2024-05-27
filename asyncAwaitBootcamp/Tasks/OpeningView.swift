//
//  OpeningView.swift
//  asyncAwaitBootcamp
//
//  Created by Devasurya on 27/05/24.
//

import SwiftUI

struct OpeningView: View{
    
    /// State property declarations
    @State var isLoggedIn: Bool = false
    
    var body: some View {
        NavigationStack {
            Button {
                isLoggedIn.toggle()
            }label: {
                Text("Click me")
            }
            .navigationDestination(isPresented: $isLoggedIn) {
                Screen3()
            }
        }
        
    }
}

#Preview {
    OpeningView()
}
