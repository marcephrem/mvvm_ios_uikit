//
//  PeopleViewModel.swift
//  iosStory
//  Created by marcephrem on 17/09/2024.

import Foundation
class PeopleViewModel {
    
    
    // creation du tableau users a partir du model
   private(set) var people = [PersonResponse]()
    
    // creation de notre weak delegate
    weak var delegate: PeopleViewModelDelegate?
    
    @MainActor
    func GetUser ( ) {
        Task { [weak self] in
            // utiliser un do ..try a cause du async / await
            do {
                guard let url = URL(string:"https://reqres.in/api/users" ) else { return }
                // try ? permet pas de capturer les erreurs correctement
                let (data, _) =  try await URLSession.shared.data(from: url)
                // utiliser le decoder json
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try jsonDecoder.decode(UserResponse.self, from: data)
                self?.people =  response.data
                self?.delegate?.didFinish()

                
            } catch {
                self?.delegate?.didFail(error: error)
                print("Errorr")
            }
        }
    }
}
