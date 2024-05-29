//
//  AsyncLetView.swift
//  asyncAwaitBootcamp
//
//  Created by Devasurya on 27/05/24.
//

import SwiftUI

/// View.
struct AsyncLetView: View {
    
    /// StateObject declartions.
    @StateObject private var viewModelInstance: AsynLetViewModel = AsynLetViewModel()
    
    /// Constant decalaration to hold an array of GridItem.
    let columnItems: [GridItem] = [GridItem(.flexible()),GridItem(.flexible())]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columnItems) {
                    ForEach( viewModelInstance.dataArray,id: \.self) {returnedImage in
                        Image(uiImage: returnedImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 180,height: 200)
                    }
                }
            }
            .navigationTitle(Text("Async let."))
            .task {
                do{
                    async let fetchedImage1 = viewModelInstance.downloadImage()
                    async let fetchedImage2 = viewModelInstance.downloadImage()
                    async let fetchedImage3 = viewModelInstance.downloadImage()
                    async let fetchedImage4 = viewModelInstance.downloadImage()
               let (image1,image2,image3,image4) = try await (fetchedImage1,fetchedImage2,fetchedImage3,fetchedImage4)
                    viewModelInstance.dataArray.append(contentsOf: [image1,image2,image3,image4])
                }
                catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

#Preview {
    AsyncLetView()
}

//Series manner of executing the task.
/* This is a way through which the images are fetched from the API and async  await pattern and on calling the series of functionality inside the task it will get executed in series manner [One after the other ]. Even if you any of the async chronus functiuo failed then the catch block is executed. If you want to av oid that situation you can use try? instead which will be marking a possiblity failure result while executing and on when one gets failed then the it is skipped and rest is executed */

//Parallel manner of executing the tasks by using async-let.
/*
 On using Async let we are performing the multiple APi fetch all together at the same time but awaiting the result all together. On using this method every image can be displayed altogether without any delay.
 */
