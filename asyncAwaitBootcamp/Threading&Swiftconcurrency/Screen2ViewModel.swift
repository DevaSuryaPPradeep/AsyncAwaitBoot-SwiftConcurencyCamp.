//
//  Screen2ViewModel.swift
//  asyncAwaitBootcamp
//
//  Created by Devasurya on 08/05/24.
//

import Foundation

/// Viewmodel
class Screen2ViewModel: ObservableObject {
    
    ///@Published property declarations.
    @Published var dataArray: [String] = []
    
    /// Function to update Published property by  using a main thread.
    func updateArrayWithTitle1() {
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            self.dataArray.append("title1:\(Thread.current)")
        }
    }
    
    /// Function to add a new element to the  @published property which is an array of String by  using a Back ground  thread.
    func updateArrayWithtitle2() {
        DispatchQueue.global().asyncAfter(deadline: .now()+2) {
            let titleValue = "title3:\(Thread.current)"
            DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                self.dataArray.append(titleValue)
            }
        }
    }
    
    func addAuthor1() async {
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        let author2 =   "Author2 \(Thread.current)"
        await MainActor.run {
            let author = "Author \(Thread.current)"
            self.dataArray.append(author)
            self.dataArray.append(author2)
        }
        await addSomething()
    }
     // Here by using await MainActor.run we switch the thread to the main thread.
    
    
    func addSomething() async {
      try? await Task.sleep(nanoseconds: 2_000_000_000)
        let something = "Something \(Thread.current)"
        await MainActor.run {
            self.dataArray.append(something)
            let something1 = "Something1 \(Thread.current)"
            self.dataArray.append(something1)
        }
    }
}
