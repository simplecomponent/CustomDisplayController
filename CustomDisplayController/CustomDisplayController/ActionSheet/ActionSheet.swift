//
//  ActionSheet.swift
//  CustomDisplayController
//
//  Created by apple on 2020/2/21.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
private let footMargin: CGFloat = UIScreen.main.bounds.size.height >= 812 ? 34 : 0
class ActionSheet: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    convenience init(target: CustomDisplayController) {
        self.init()
        _target = target
        contentView.target = target
        footerView.tap = {
            target.dismiss(completion: nil)
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        headViewConstraint.constant = headView.headSize.height
        contentConstraint.constant = contentView.size.height
        footerConstraint.constant = footerView.size.height
    }
    //MARK:- FUNC
    /*public*/
    public func setTitle(_ title: String?,AndMessage message: String?){
        headView.setTitle(title, AndMessage: message)
    }
    
    /// 配置 ActionSheet
    /// - Parameter config: ZXActionSheetConfig
    public func setConfig(_ config: ZXActionSheetConfig = ZXActionSheetConfig.default){
        headView.setConfig(config.headConfig)
        contentView.headHeight = headView.headSize.height
        contentView.setConfig(config, footerIsShow: false)
        footerView.setConfig(config.footerConfig)
        self.config = config
    }
    
    public func appendDisplayAction(_ action: CustomDisplayAction){
        contentView.appendDisplayAction(action)
    }
    
    public func setCancelView(_ action: CustomDisplayAction){
        footerView.isHidden = false
        contentView.setConfig(config, footerIsShow: true)
        footerView.setConfig(config.footerConfig)
        footerView.setAction(action)
    }

    /*private*/
    private func setUpView(){
        addSubview(headView)
        addSubview(contentView)
        addSubview(footerView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        footerView.translatesAutoresizingMaskIntoConstraints = false
        headView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: headView,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .top,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: headView,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .centerX,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: headView,
                           attribute: .width,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .width,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        headViewConstraint = NSLayoutConstraint(item: headView,
                                                attribute: .height,
                                                relatedBy: .equal,
                                                toItem: nil,
                                                attribute: .notAnAttribute,
                                                multiplier: 1,
                                                constant: headView.headSize.height)
        headViewConstraint.isActive = true
        
        
        NSLayoutConstraint(item: contentView,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: headView,
                           attribute: .bottom,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: contentView,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .centerX,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: contentView,
                           attribute: .width,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .width,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        contentConstraint = NSLayoutConstraint(item: contentView,
                                               attribute: .height,
                                               relatedBy: .equal,
                                               toItem: nil,
                                               attribute: .notAnAttribute,
                                               multiplier: 1,
                                               constant: contentView.size.height)
        contentConstraint.isActive = true
        
        
        NSLayoutConstraint(item: footerView,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .bottom,
                           multiplier: 1,
                           constant: -footMargin).isActive = true
        
        NSLayoutConstraint(item: footerView,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .centerX,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: footerView,
                           attribute: .width,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .width,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        footerConstraint = NSLayoutConstraint(item: footerView,
                                               attribute: .height,
                                               relatedBy: .equal,
                                               toItem: nil,
                                               attribute: .notAnAttribute,
                                               multiplier: 1,
                                               constant: footerView.size.height)
        footerConstraint.isActive = true
    }
    
    //MARK:- Getter Setter
    /*public*/
    public var actionSheetSize: CGSize{
        get{
            let footerHeight: CGFloat = footerView.size.height + config.footerConfig.spacing
            let totalHeight: CGFloat = headView.headSize.height + contentView.size.height + (footerView.isHidden ? 0 : footerHeight) + footMargin
            return CGSize(width: UIScreen.main.bounds.size.width,height: totalHeight)
        }
    }
    /*private*/
    private var _target: CustomDisplayController?
    private var _actionList = [CustomDisplayAction]()
    private var headView: CustomActionSheetHead = {
        let head = CustomActionSheetHead()
        return head
    }()
    private var contentView: ActionSheetContent = {
        let content = ActionSheetContent(frame: .zero)
        return content
    }()
    private var footerView: ZXActionSheetFooterView = {
        let footer = ZXActionSheetFooterView(frame: .zero)
        footer.isHidden = true
        return footer
    }()
    private var headViewConstraint = NSLayoutConstraint()
    private var contentConstraint = NSLayoutConstraint()
    private var footerConstraint = NSLayoutConstraint()
    
    private var config = ZXActionSheetConfig()
}
