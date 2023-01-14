//
//  ContentView.swift
//  swift-ui-test-app
//
//  Created by Jeremy Chua on 31/12/22.
//


import SwiftUI

class ViewModel:ObservableObject {
    @Published var image: Image?
    func fetchNewImage() {
        guard let url = URL(string: "https://picsum.photos/200") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {
            data, _, _ in
                guard let data = data
            else { return }
            DispatchQueue.main.async {
                guard let uiImage = UIImage(data: data) else { return  }
                self.image = Image(uiImage: uiImage)
            }
        }
        task.resume()
    }
}

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    @State private var stateVar = "Press the button!"
    var body: some View {
        /*
        Text("Hello, world a very long line of text that i will keep adding into over and over again!")
            .font(.largeTitle)
            .fontWeight(.thin)
            .foregroundColor(.white)
            .background(.black)
            .multilineTextAlignment(.center)
            .lineLimit(2)
            .truncationMode(.tail)
        */
        /*
        VStack{
            Text("User Input: \(stateVar)")
            TextField("Enter name", text: $stateVar)
                .multilineTextAlignment(.center)
                .padding()
        }
         */
        /*
        HStack(alignment: .firstTextBaseline, spacing: 30){
            Text("Test")
            Text("Test2")
            Text("Test3")
            Text("Test4")
            Text("Test5")
            Text("Test6")
            Text("Test7")
            Text("Test8")
            Text("Testering")
        }
        */
        /*
        VStack(alignment: .center, spacing: 50){
            Text(stateVar)
            Button(action:{
                self.stateVar = "Clicked!"
            }){
                Text("Click Me!")
            }.disabled(stateVar == "Clicked!")
        }
         */
        
        NavigationView {
            VStack{
                Spacer()
                
                if let image = viewModel.image {
                    ZStack {
                        image
                           .resizable()
                           .foregroundColor(.mint)
                           .frame(width: 200, height: 200)
                    }
                    .frame(width: UIScreen.main.bounds.width / 1.2, height: UIScreen.main.bounds.width / 1.2)
                    .background(.mint)
                    .cornerRadius(10)
                } else {
                    Image(systemName: "photo")
                       .resizable()
                       .foregroundColor(.mint)
                       .frame(width: 300, height: 300)
                }
                Spacer()
                
                Button(action: {
                    viewModel.fetchNewImage()
                }, label:{
                    Text("Next Picture")
                        .frame(width: 250, height: 55)
                        .foregroundColor(.white)
                        .background(.teal)
                        .cornerRadius(10)
                        .padding()
                })
            }
            .navigationTitle("Random Photo")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
