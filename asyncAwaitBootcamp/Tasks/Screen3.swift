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
        .task {
            await  viewModelInstance.fetchImage()
        }
    }
}

#Preview {
    Screen3()
}


//About task & .task() modifier.
/* Inorder to cancel the a task you can use task.cancel()
 -> but here is a modifier called .task() which will perform the task mentioned inside when the view appears , without using .onappear() modifier, Moreover we don't need to cancel the task manually when the view disappears , this will be automatically cancelled by the swift when we are using .task() modifier.
 */

