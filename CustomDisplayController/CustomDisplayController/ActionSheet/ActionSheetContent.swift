//
//  ActionSheetContent.swift
//  CustomDisplayController
//
//  Created by apple on 2020/2/22.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class ActionSheetContent: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentStack.frame = bounds
    }
    //MARK:- FUNC
    /*public*/
    func setContentList(_ list: [CustomDisplayAction]){
        
    }
    
    /*private*/
    private func setUpView(){
        backgroundColor = .yellow
        addSubview(contentStack)
    }
    //MARK:- Getter Setter
    /*public*/
    public var size: CGSize{
        get{
            return CGSize(width: 375, height: 100)
        }
    }
    /*private*/
    
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView()
        return stack
    }()

}
