//
//  ContinuationView.swift
//  asyncAwaitBootcamp
//
//  Created by Devasurya on 31/05/24.
//

import SwiftUI

/// View.
struct ContinuationView: View {
    @StateObject var continuationViewModel: ContinuationViewModel = ContinuationViewModel()
    
    var body: some View {
        ZStack{
            if let image = continuationViewModel.imageHolder {
                Image(uiImage: image)
            }
        }
        .task {
            let _ =  await continuationViewModel.getImagesFromAPI()
        }
    }
}

#Preview {
    ContinuationView()
}
