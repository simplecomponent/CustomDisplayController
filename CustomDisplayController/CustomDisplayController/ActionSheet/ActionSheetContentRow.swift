//
//  ActionSheetContentRow.swift
//  CustomDisplayController
//
//  Created by Mr.Zhu on 2020/2/23.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class ActionSheetContentRow: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        widthConstraint.constant = titleLabel.getSize(normalWidth: bounds.size.width).width
    }
    
    public func setAction(_ action: CustomDisplayAction){
        layoutSubviews()
        self.action = action
        titleLabel.text = action.title
        switch action.style {
        case .default:
            titleLabel.textColor = config.defaultColor
            titleLabel.font = config.defaultFont
        case .destructive:
            titleLabel.textColor = config.destructiveColor
            titleLabel.font = config.destructiveFont
        default:
            break
        }
    }
    
    public func setConfig(_ config: ZXActionSheetConfig.ContentConfig){
        self.config = config
    }
    
    @objc private func onTap(_ tap: UITapGestureRecognizer){
        guard tap.view != nil else { return }
        action.handler?(action)
        tapClosuer?(action)
    }
    
    
    
    private func setUpView(){
        
        addGestureRecognizer(tap)
        backgroundColor = config.rowBackColor
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: titleLabel,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .centerX,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: titleLabel,
                           attribute: .centerY,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .centerY,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: titleLabel,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .height,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        widthConstraint = NSLayoutConstraint(item: titleLabel,
                                             attribute: .width,
                                             relatedBy: .equal,
                                             toItem: nil,
                                             attribute: .notAnAttribute,
                                             multiplier: 1,
                                             constant: 0)
        widthConstraint.isActive = true
        
    }
    
    var tapClosuer: ((CustomDisplayAction)->Void)?
    lazy var tap = UITapGestureRecognizer(target: self, action: #selector(onTap))
    private var action = CustomDisplayAction()
    
    private var widthConstraint = NSLayoutConstraint()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    public var config = ZXActionSheetConfig.ContentConfig()
    
    deinit {
        removeGestureRecognizer(tap)
    }
}
