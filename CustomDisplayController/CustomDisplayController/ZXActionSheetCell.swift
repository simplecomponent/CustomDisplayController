//
//  ZXActionSheetCell.swift
//  CustomDisplayController
//
//  Created by apple on 2020/2/21.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class CustomActionSheetCell: UITableViewCell{
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted{
            titleLabel.backgroundColor = UIColor(red: 240/255.0,
                                      green: 240/255.0,
                                      blue: 240/255.0,
                                      alpha: 1)
        }else{
            titleLabel.backgroundColor = _config.rowBackColor
        }
    }
    
    //MARK:- FUNC
    /*public*/
    public func setConfig(_ config: ZXActionSheetConfig.ContentConfig){
        _config = config
        backgroundColor = _config.spacingColor
    }
    public func setAction(_ action: CustomDisplayAction){
        self.action = action
        self.setContent(action)
    }
    
    /*private*/
    private func setContent(_ action: CustomDisplayAction){
        
        titleLabel.text = action.title
        switch action.style {
            case .default:
                titleLabel.font = _config.defaultFont
            case .destructive:
                titleLabel.font = _config.destructiveFont
                titleLabel.textColor = _config.destructiveColor
            case .cancel:
                titleLabel.font = _config.cancelFont
                titleLabel.textColor = _config.cancelColor
        }
    }
    
    private var _config = ZXActionSheetConfig.ContentConfig()
    
    private func setUpView(){
        contentView.addSubview(titleLabel)
        selectionStyle = .none
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let bottomLayout = NSLayoutConstraint(item: titleLabel,
                                              attribute: .bottom,
                                              relatedBy: .equal,
                                              toItem: self,
                                              attribute: .bottom,
                                              multiplier: 1,
                                              constant: 0)
        bottomLayout.isActive = true
        
        let leftLayout = NSLayoutConstraint(item: titleLabel,
                                            attribute: .left,
                                            relatedBy: .equal,
                                            toItem: self,
                                            attribute: .left,
                                            multiplier: 1,
                                            constant: 0)
        leftLayout.isActive = true
        
        let widthLayout = NSLayoutConstraint(item: titleLabel,
                                             attribute: .width,
                                             relatedBy: .equal,
                                             toItem: self,
                                             attribute: .width,
                                             multiplier: 1,
                                             constant: 0)
        widthLayout.isActive = true
        
        let heightLayout = NSLayoutConstraint(item: titleLabel,
                                              attribute: .height,
                                              relatedBy: .equal,
                                              toItem: nil,
                                              attribute: .notAnAttribute,
                                              multiplier: 1,
                                              constant: 50)
        heightLayout.isActive = true
    }
    //MARK:- Getter Setter
    /*public*/
    
    /*private*/
    
    private var action: CustomDisplayAction?
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
}
