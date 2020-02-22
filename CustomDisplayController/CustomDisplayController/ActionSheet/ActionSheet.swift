//
//  ActionSheet.swift
//  CustomDisplayController
//
//  Created by apple on 2020/2/21.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

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
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        headViewConstraint.constant = headView.headSize.height
        contentConstraint.constant = contentView.size.height
    }
    //MARK:- FUNC
    /*public*/
    public func setTitle(_ title: String?,AndMessage message: String?){
        headView.setTitle(title, AndMessage: message)
    }
    /// 配置 ActionSheet
    /// - Parameter config: ZXActionSheetConfig
    public func setConfig(_ config: ZXActionSheetConfig = ZXActionSheetConfig.default){
        _headConfig = config.headConfig
        headView.setConfig(_headConfig)
        _contentConfig = config.contentConfig
    }
    
    public func setActionList(_ actionList: [CustomDisplayAction]){
        _actionList = actionList
        _actionList.sort(by: { $0.style.rawValue < $1.style.rawValue })
    }
    /*private*/
    private func setUpView(){
        addSubview(headView)
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
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
    }
    
    //MARK:- Getter Setter
    /*public*/
    public var actionSheetSize: CGSize{
        get{
//            var contentHeight = _contentConfig.rowHeight * CGFloat(_actionList.count)
//            if _actionList.contains(where: { $0.style == .cancel }){
//                contentHeight += _contentConfig.spacing
//            }
//            let headerHeight = headView.getHeadSize(_headConfig).height
//            let totalH = contentHeight + headerHeight
//            let finalHeight = totalH > _contentConfig.maxHeight ? _contentConfig.maxHeight : totalH
//            return CGSize(width: UIScreen.main.bounds.size.width,height: finalHeight)
            
            
            return CGSize(width: UIScreen.main.bounds.size.width,height: 300)
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
    private var headViewConstraint = NSLayoutConstraint()
    private var contentConstraint = NSLayoutConstraint()
    
    
    private var _contentConfig = ZXActionSheetConfig.ContentConfig()
    private var _headConfig = ZXActionSheetConfig.HeadConfig()
}
