//
//  AsyncletView.swift
//  asyncAwaitBootcamp
//
//  Created by Devasurya on 27/05/24.
//

import SwiftUI

struct AsyncletView: View {
    @State private var images:  [UIImage] = []
    @StateObject private var viewModelInstance: AsynLetViewModel = AsynLetViewModel()
    let columnItems: [GridItem] = [GridItem(.flexible()),GridItem(.flexible())]
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columnItems) {
                    ForEach( viewModelInstance.dataArray,id: \.self) {returnedImage in
                        Image(uiImage: returnedImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100,height: 50)
                    }
                }
            }
            .navigationTitle(Text("Async let."))
            .task {
                do{
                    let image1 = try await viewModelInstance.downloadImage()
                    viewModelInstance.dataArray.append(image1)
                    let image2 = try await viewModelInstance.downloadImage()
                    viewModelInstance.dataArray.append(image2)
                    let image3 = try await viewModelInstance.downloadImage()
                    viewModelInstance.dataArray.append(image3)
                    let image4 =  try await viewModelInstance.downloadImage()
                    viewModelInstance.dataArray.append(image4)
                }
                catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

#Preview {
    AsyncletView()
}

//Series manner of executing the task.
/* This is a way through which the images are fetched from the API and async  await pattern and on calling the series of functionality inside the task it will get executed in series manner [One after the other ]. Even if you any of the async chronus functiuo failed then the catch block is executed. If you want to av oid that situation you can use try? instead which will be marking a possiblity failure result while executing and on when one gets failed then the it is skipped and rest is executed */
 
//Parallel manner of executing the tasks.
/*
 
 */
