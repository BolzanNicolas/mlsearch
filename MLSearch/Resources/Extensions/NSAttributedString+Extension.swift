//
//  NSAttributedString+Extension.swift
//  MLSearch
//
//  Created by Nicolas Bolzan on 18/05/2021.
//

import UIKit

extension NSMutableAttributedString {
    
    func normalText(_ string: String, size: CGFloat = 17) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: string,
                                         attributes: [.font : UIFont.systemFont(ofSize: size)])
    }
    
    func boldText(_ string: String, size: CGFloat = 17) -> NSMutableAttributedString {
        let range = (self.string.lowercased() as NSString).range(of: string.lowercased())
        
        addAttributes([.font : UIFont.systemFont(ofSize: size, weight: .bold)], range: range)
        
        return self
    }
}
