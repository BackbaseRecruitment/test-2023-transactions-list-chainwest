//
//  ImageProvider.swift
//  Transactions
//
//  Created by Евгений Урбановский on 4/23/23.
//

import UIKit

struct ImageProvider {
    private static func image(
        with name: String,
        color: UIColor
    ) -> UIImage {
        guard let image = UIImage(named: name, in: nil, compatibleWith: nil) else {
            NSLog("Failed to load image with resource name.")
            return UIImage()
        }
        
        image.withTintColor(color)
        return image
    }
}
