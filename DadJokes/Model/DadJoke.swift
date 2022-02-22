//
//  DadJoke.swift
//  DadJokes
//
//  Created by Madison Dellamea on 2/22/22.
//

import Foundation

//The Dad Joke structure conforms to the decodable protocal. This means that we want Swift to be able to take a JSON object and 'decode' into an instance of this structure.
struct DadJoke: Decodable {
    let id: String
    let joke: String
    let status: Int
}
