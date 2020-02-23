
//
//  ZXActionSheetFooterView.swift
//  CustomDisplayController
//
//  Created by apple on 2020/2/21.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
class ZXActionSheetFooterView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
    //MARK:- FUNC
    /*public*/
    func setConfig(_ config: ZXActionSheetConfig.FooterConfig){
        _config = config
        heightConstraint.constant = config.spacing
        spaceView.backgroundColor = config.spacingColor
        label.titleLabel?.font = config.titleFont
        label.setTitleColor(config.titleColor, for: .normal)
        label.backgroundColor = config.backColor
    }
    
    func setAction(_ action: CustomDisplayAction){
        _action = action
        label.setTitle(action.title, for: .normal)
        
    }
//    func
    var tap: (()->Void)?
    /*private*/
    private func setUpView(){
        
        addSubview(spaceView)
        addSubview(label)
        spaceView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: spaceView,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .top,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: spaceView,
                           attribute: .left,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .left,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: spaceView,
                           attribute: .width,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .width,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        
        heightConstraint = NSLayoutConstraint(item: spaceView,
                                              attribute: .height,
                                              relatedBy: .equal,
                                              toItem: nil,
                                              attribute: .notAnAttribute,
                                              multiplier: 1,
                                              constant: 0)
        
        heightConstraint.isActive = true
        label.addTarget(self, action: #selector(buttonOnClick), for: .touchUpInside)
        
    }
    @objc private func buttonOnClick(){
        _action.handler?(_action)
        tap?()
    }
    //MARK:- Getter Setter
    /*public*/
    public var size: CGSize{
        get{
            return CGSize(width: UIScreen.main.bounds.size.width, height: 50)
        }
    }
    /*private*/
    private var spaceView: UIView = {
        let view = UIView()
        return view
    }()
    private var label: UIButton = {
        let label = UIButton()
        label.titleLabel?.textAlignment = .center
        return label
    }()
    private var _action = CustomDisplayAction()
    private var heightConstraint = NSLayoutConstraint()
    private var _config = ZXActionSheetConfig.FooterConfig()
}
