//
//  ContentView.swift
//  DadJokes
//
//  Created by Russell Gordon on 2022-02-21.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: Stored Properties
    @State var currentJoke: DadJoke = DadJoke(id: "", joke: "knock, knock...", status: 0)
    
    
    //MARK: Computed Properties
    
    
    var body: some View {
        VStack {
            
            Text(currentJoke.joke)
                .font(.title2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.leading)
                .padding(30)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.primary, lineWidth: 4)
                )
            
            Image(systemName: "heart.circle")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.gray)
            
            Button(action: {
                // This task type allows us to load asynchronous code within a button and add the user interface updated when the data is ready.
                // Since it is asychronous, other tasks can run while we wait for the data to come back from the web server.
                Task {
                    //Call the function that will get us a new joke.
                    await loadNewJoke()
                }
            }, label: {
                Text("Another one!")
                //.font(.largeTitle)
            })
                .padding()
                .buttonStyle(.bordered)
            
            
            HStack {
                
                Text("Favourites")
                    .bold()
                
                Spacer()
            }
            
            List {
                Text("Which side of the chicken has more feathers? The outside.")
                Text("Why did the Clydesdale give the pony a glass of water? Because he was a little horse!")
                Text("The great thing about stationery shops is they're always in the same place...")
            }
            
            Spacer()
            
        }
        // When the app opens, get a new joke from the web service
        
        .navigationTitle("icanhazdadjoke?")
        .padding()
    }
    // MARK: Functions
    
    //Define the function " loadNewjoke"
    //
    func loadNewJoke() async {
        
        // Assemble the URL that points to the endpoint
        let url = URL(string: "https://icanhazdadjoke.com/")!
        
        // Define the type of data we want from the endpoint
        // Configure the request to the web site
        var request = URLRequest(url: url)
        // Ask for JSON data
        request.setValue("application/json",
                         forHTTPHeaderField: "Accept")
        
        // Start a session to interact (talk with) the endpoint
        let urlSession = URLSession.shared
        
        // Try to fetch a new joke
        // It might not work, so we use a do-catch block
        do {
            
            // Get the raw data from the endpoint
            let (data, _) = try await urlSession.data(for: request)
            
            // Attempt to decode the raw data into a Swift structure
            // Takes what is in "data" and tries to put it into "currentJoke"
            //                                 DATA TYPE TO DECODE TO
            //                                         |
            //                                         V
            currentJoke = try JSONDecoder().decode(DadJoke.self, from: data)
            
        } catch {
            print("Could not retrieve or decode the JSON from endpoint.")
            // Print the contents of the "error" constant that the do-catch block
            // populates
            print(error)
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
