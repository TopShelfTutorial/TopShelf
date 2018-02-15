//
//  ServiceProvider.swift
//  TopShelf
//
//  Created by Matheus Felizola Freires on 15/02/2018.
//  Copyright © 2018 Daniel Lima. All rights reserved.
//

import Foundation
import TVServices

class ServiceProvider: NSObject, TVTopShelfProvider {

    override init() {
        super.init()
    }

    // MARK: - TVTopShelfProvider protocol

    var topShelfStyle: TVTopShelfContentStyle {
        // Return desired Top Shelf style.
        return .sectioned
    }

    var topShelfItems: [TVContentItem] {
        // Create an array of TVContentItems.
        return []
    }

}

