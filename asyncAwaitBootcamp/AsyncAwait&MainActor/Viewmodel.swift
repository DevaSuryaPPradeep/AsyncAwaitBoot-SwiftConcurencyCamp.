//
//  Viewmodel.swift
//  asyncAwaitBootcamp
//
//  Created by Devasurya on 02/05/24.
//

import Foundation
import UIKit
import Combine

/// Viewmodel
class viewmodel: ObservableObject {
    
    /// @published property declaration.
    @Published var imageName: UIImage? = nil
    
    /// Decalaration of a variable of type Set<AnyCancellable>() that is capable for storing a publisher.
    var cancellables = Set<AnyCancellable>()
    
    /// Function to set the retruned value from the API to a published property.
    func fetchImage() async throws {
        /*
         //        DataManger.shared.downloadData {[weak self] imageValue, error in
         //            if let returnedImage = imageValue {
         //                DispatchQueue.main.async {
         //                    self?.imageName = returnedImage
         //                }
         //            }
         //        }
         */
        /*
         //       DataManger.shared.downloadDataUsingCombine()
         //           .receive(on: DispatchQueue.main)
         //           .sink {  _ in
         //
         //           } receiveValue: { [weak self] imageVal in
         //               self?.imageName = imageVal
         //               print("imageName---> \(String(describing: self?.imageName))")
         //           }
         //           .store(in: &cancellables)
         //           }
         */
        do {
         let returnedImage = try  await  DataManger.shared.fetchData()
          await MainActor.run(){
                self.imageName = returnedImage
            }
        }
        catch {
            throw error
        }
    }
}
