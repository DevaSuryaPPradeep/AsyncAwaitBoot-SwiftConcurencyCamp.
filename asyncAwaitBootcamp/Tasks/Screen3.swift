//
//  Screen3.swift
//  asyncAwaitBootcamp
//
//  Created by Devasurya on 24/05/24.
//

import SwiftUI

struct Screen3: View {
    
    /// StateObject declaration.
    @StateObject private var viewModelInstance = Screen3ViewModel()
    
    /// State variable for holding task related details.
   @State private var taskDetails:  Task<(), Never>? = nil
    
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
         taskDetails = Task {
               print("Image 1 loaded")
                await  viewModelInstance.fetchImage()
            }
        })
        .onDisappear(perform: {
            taskDetails?.cancel()
        })
    }
}

#Preview {
    Screen3()
}

/* Inorder to cancel the a task you can use task.cancel() */

