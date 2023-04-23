//
//  ImageProvider.swift
//  Transactions
//
//  Created by Евгений Урбановский on 4/23/23.
//

import UIKit
import BackbaseMDS

struct ImageProvider {
    static var creditTransaction: UIImage {
        image(with: "transaction_credit")
    }
    
    static var debitTransaction: UIImage {
        image(with: "transaction_debit")
    }
    
    private static func image(
        with name: String,
        color: UIColor = BackbaseUI.shared.colors.primary
    ) -> UIImage {
        guard let image = UIImage(named: name, in: nil, compatibleWith: nil) else {
            NSLog("Failed to load image with resource name.")
            return UIImage()
        }
        
        image.withTintColor(color)
        return image
    }
}
