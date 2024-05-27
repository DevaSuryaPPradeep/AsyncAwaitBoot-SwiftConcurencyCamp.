//
//  Screen3.swift
//  asyncAwaitBootcamp
//
//  Created by Devasurya on 24/05/24.
//

import SwiftUI

struct Screen3: View {
    
    /// StateObject declaration.
    @StateObject var viewModelInstance = Screen3ViewModel()
    
    var body: some View {
        VStack(spacing: 40, content: {
            if let imageValue  = viewModelInstance.image {
                Image(uiImage: imageValue)
            }
            if let imageValue  = viewModelInstance.image2 {
                Image(uiImage: imageValue)
            }
        })
        .onAppear(perform: {
            Task {
                print(Thread.current)
                print(Thread.threadPriority())
                await  viewModelInstance.fetchImage()
            }
            Task {
                print(Thread.current)
                print(Thread.threadPriority())
                await viewModelInstance.fetchImage2()
            }
        })
        
    }
}

#Preview {
    Screen3()
}
