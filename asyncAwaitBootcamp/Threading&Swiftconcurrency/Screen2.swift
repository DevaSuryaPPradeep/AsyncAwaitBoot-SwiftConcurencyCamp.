//
//  Screen2.swift
//  asyncAwaitBootcamp
//
//  Created by Devasurya on 08/05/24.
//

import SwiftUI

/// View
struct Screen2: View {
    
    ///@StateObject declarations.
    @StateObject var viewmodelInstance: Screen2ViewModel = Screen2ViewModel()
    
    var body: some View {
        List {
            ForEach(viewmodelInstance.dataArray,id: \.self) { details in
                Text(details)
            }
        }
        .onAppear(perform: {
            Task {
             await viewmodelInstance.addAuthor1()
//                viewmodelInstance.dataArray.append("Final value====>\(Thread.current)")
            }
        })
    }
}
#Preview {
    Screen2()
}
//By using await keyword during execution, task is momentaryly suspended / waiting till the function marked as await finishes.
