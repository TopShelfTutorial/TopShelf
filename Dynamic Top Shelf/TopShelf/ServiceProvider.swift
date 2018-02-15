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

    func createSection(title: String) -> TVContentItem {
        let identifier = TVContentIdentifier(identifier: title, container: nil)!
        //Create an item to serve as a Top Shelf section.
        let section = TVContentItem(contentIdentifier: identifier)!
        section.title = title

        return section
    }

    func createTopShelfItem(identifier: String, imageName: String, imageShape: TVContentItemImageShape) -> TVContentItem? {
        guard let url1x = Bundle.main.url(forResource: imageName, withExtension: "png") else {
            print("\(imageName).png not found, please provide a valid image.")
            return nil
        }

        guard let url2x = Bundle.main.url(forResource: "\(imageName)@2x", withExtension: "png") else {
            print("\(imageName)@2x.png not found, please provide a valid image.")
            return nil
        }

        let itemIdentifier = TVContentIdentifier(identifier: identifier, container: nil)!
        let item = TVContentItem(contentIdentifier: itemIdentifier)!

        //Choose the item's appropriate shape.
        item.imageShape = imageShape

        //Set @1x image for Full HD and @2x for 4K tvs.
        item.setImageURL(url1x, forTraits: .screenScale1x)
        item.setImageURL(url2x, forTraits: .screenScale2x)

        //Set item title. Appears when the item is currently focused.
        item.title = itemIdentifier.identifier

        return item
    }

    private func identifySectionItems(for section: TVContentItem) {
        section.topShelfItems?.forEach { item in
            item.displayURL = urlFor(item: item, scheme: section.title?.lowercased() ?? "")
            print(item.displayURL)
        }
    }

    ///Generates a URL for Deep Linking
    private func urlFor(item: TVContentItem, scheme: String) -> URL {
        var components = URLComponents()
        components.scheme = scheme
        components.queryItems = [URLQueryItem(name: "identifier", value: item.contentIdentifier.identifier)]

        return components.url!
    }

    // Provide an array of TVContentItems.
    var topShelfItems: [TVContentItem] {
        let musicSection = createSection(title: "Music")

        musicSection.topShelfItems = [
            createTopShelfItem(identifier: "The Beatles - Abbey Road",
                               imageName: "4",
                               imageShape: .square)!
        ]

        let moviesSection = createSection(title: "Movies")

        //Add items to the section
        moviesSection.topShelfItems = [
            createTopShelfItem(identifier: "Star Trek - Discovery",
                               imageName: "5",
                               imageShape: .HDTV)!,
            createTopShelfItem(identifier: "Star Trek - The Next Generation",
                               imageName: "6",
                               imageShape: .poster)!,
            createTopShelfItem(identifier: "Star Trek - The Future Begins",
                               imageName: "2",
                               imageShape: .poster)!,
            createTopShelfItem(identifier: "Star Wars - The Last Jedi",
                               imageName: "1",
                               imageShape: .poster)!,
            createTopShelfItem(identifier: "Stranger Things - Season 2",
                               imageName: "3",
                               imageShape: .poster)!
        ]

        //Set the display URLs to enable deep linking.
        identifySectionItems(for: musicSection)
        identifySectionItems(for: moviesSection)

        //Add the sections to the Top Shelf.
        return [musicSection, moviesSection]
    }

}

