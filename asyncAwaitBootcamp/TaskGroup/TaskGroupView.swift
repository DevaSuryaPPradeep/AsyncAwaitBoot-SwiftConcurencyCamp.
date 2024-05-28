//
//  TaskGroupView.swift
//  asyncAwaitBootcamp
//
//  Created by Devasurya on 27/05/24.
//

import SwiftUI

/// View.
struct TaskGroupView: View {
    
    /// StateObject declartions.
    @StateObject private var viewModelInstance: TaskViewModel = TaskViewModel()
    
    /// Constant decalaration to hold an array of GridItem.
    let columnItems: [GridItem] = [GridItem(.flexible()),GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columnItems) {
                ForEach(viewModelInstance.dataArray,id: \.self) {returnedImage in
                    Image(uiImage: returnedImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180,height: 200)
                }
            }
        }
        .task {
          await viewModelInstance.getImages()
        }
    }
}

#Preview {
    TaskGroupView()
}
