//
//  Define.swift
//  CustomDisplayController
//
//  Created by apple on 2020/2/21.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

public extension UILabel{
    
    func getSize(normalWidth: CGFloat?=nil)->CGSize{
        let font = self.font ?? UIFont.systemFont(ofSize: 17)
        let text = self.text ?? ""
        let size = CGSize(width: normalWidth ?? bounds.size.width, height: 1000)
        let dic =  [NSAttributedString.Key.font : font]
        //        attributedText
        let labelSize = (text as NSString?)?.boundingRect(with: size,
                                                          options: .usesLineFragmentOrigin,
                                                          attributes:dic,
                                                          context: nil).size ?? .zero
        
        let finalSize = CGSize(width: ceil(labelSize.width), height: ceil(labelSize.height))
        return finalSize
    }
}

