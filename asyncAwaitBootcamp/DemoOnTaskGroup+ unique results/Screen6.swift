import SwiftUI

/// View.
struct Screen6: View {
    
    /// State object decalarations
    @StateObject private var demoViewModel = DemoViewModel()
    
    /// State property declarations.
    @State private var isLoading: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Coin Details")
                    .font(.headline)
                // List of coin details
                ForEach(demoViewModel.dataProvider.first?.coinInfo ?? [], id: \.self) { coin in
                    VStack {
                        Text("Name: \(coin.name)")
                        Text("Symbol: \(coin.symbol)")
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
                VStack(alignment: .leading) {
                    Text("Job Details")
                        .font(.headline)
                    // List of job details
                    ForEach(demoViewModel.dataProvider.first?.jobInfo ?? [], id: \.self) { job in
                        VStack(alignment: .leading) {
                            Text("Title: \(job.title)")
                            Text("Department: \(job.department)")
                            Text("Posted Date: \(job.postedDate)")
                            Text("Deadline Date: \(job.deadlineDate)")
                            Text("Description: \(job.description)")
                            Text("Salary: \(job.salary)")
                            Text("Status: \(job.status)")
                            Text("Responsibilities: \(job.responsibilities)")
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    }
                }
            }
            .task {
                do {
                    let _ =  try await demoViewModel.fetchDetails()
                } catch {
                    print("Failed to fetch details: \(error.localizedDescription)")
                }
            }
        }
    }
}

#Preview {
    Screen6()
}
