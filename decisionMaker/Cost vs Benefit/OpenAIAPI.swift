//
//  OpenAIAPI.swift
//  decisionMaker
//
//  Created by Ayaan Jain on 14/1/23.
//

import Foundation
import OpenAISwift

func generateAnswer(question: String, onSuccess: @escaping ([String.SubSequence]?) -> Void) {
    
    // Using my personal token to call the API (Probably should have hidden this in an api)
    let openAI = OpenAISwift(authToken: "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")
    
    // Making sure we ask for the pros and cons
    var input = """
    In bullet points, in the format of
    Pros:
    - [pros]
    Cons:
    - [cons]
    what are the Pros and Cons of:
    """ + question
    
    // Sending the request to OpenAI
    openAI.sendCompletion(with: input, maxTokens: 100) { result in // Result<OpenAI, OpenAIError>
        switch result {
        case .success(let success):
            //split up the bullet points
            let points = success.choices.first?.text.split(whereSeparator: \.isNewline)
            
            onSuccess(points)
            
            print(points)
        case .failure(let failure):
            print(failure.localizedDescription)
        }
    }
    
}
