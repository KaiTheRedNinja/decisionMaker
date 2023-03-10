//
//  OpenAIAPI.swift
//  decisionMaker
//
//  Created by Ayaan Jain on 14/1/23.
//

import Foundation
import OpenAISwift

func generateAnswer(question: String,
                    onSuccess: @escaping ([String.SubSequence]?) -> Void,
                    onError: @escaping (Error) -> Void = { _ in }) {
    
    
    // Using my personal token to call the API (Probably should have hidden this in an api)
    //put key in here:
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
        case .failure(let failure):
            print(failure.localizedDescription)
            onError(failure)
        }
    }
    
}
