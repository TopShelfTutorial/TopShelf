//
//  URL+QueryParameters.swift
//
//  Created by Idrr on 13/12/2017.
//  https://gist.github.com/gillesdemey/509bb8a1a8c576ea215a#gistcomment-2285583
//

import Foundation

extension URL {
    func getQueryStringParameter(param: String) -> String? {
        guard let urlComponents = NSURLComponents(url: self, resolvingAgainstBaseURL: false),
            let queryItems = urlComponents.queryItems else {
                return nil
        }

        return queryItems.first(where: { $0.name == param })?.value
    }
}

