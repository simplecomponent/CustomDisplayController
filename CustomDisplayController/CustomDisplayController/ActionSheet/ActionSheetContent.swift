//
//  ActionSheetContent.swift
//  CustomDisplayController
//
//  Created by apple on 2020/2/22.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
private let lineWidth: CGFloat = 0.5

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
        
    }
    
    //MARK:- FUNC
    /*public*/
    var target: CustomDisplayController?
    var headHeight: CGFloat = 0
    func setConfig(_ config: ZXActionSheetConfig,footerIsShow: Bool){
        _config = config
        let footerHeight: CGFloat = (footerIsShow ? 50 + config.footerConfig.spacing : 0)
        maxHeight = mainSize.height - headHeight - footerHeight - UIApplication.shared.statusBarFrame.size.height - 30
    }
    
    func appendDisplayAction(_ action: CustomDisplayAction){
        _actionList.append(action)
        let frame = CGRect(origin: .zero, size: CGSize(width:bounds.size.width ,
                                                       height: _config.contentConfig.rowHeight))
        let row = ActionSheetContentRow(frame: frame)
        row.setConfig(_config.contentConfig)
        row.setAction(action)
        row.tapClosuer = {
            [weak self] action in
            guard let weakSelf = self else { return }
            weakSelf.target?.dismiss(completion: nil)
        }
        contentStack.addArrangedSubview(row)
        
    }
    
    /*private*/
    private func setUpView(){
        backgroundColor = .gray
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentStack)
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: scrollView,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .top,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: scrollView,
                           attribute: .left,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .left,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: scrollView,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .height,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: scrollView,
                           attribute: .width,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .width,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: contentStack,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: scrollView,
                           attribute: .top,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: contentStack,
                           attribute: .left,
                           relatedBy: .equal,
                           toItem: scrollView,
                           attribute: .left,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: contentStack,
                           attribute: .width,
                           relatedBy: .equal,
                           toItem: scrollView,
                           attribute: .width,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        heightConstraint = NSLayoutConstraint(item: contentStack,
                                              attribute: .height,
                                              relatedBy: .equal,
                                              toItem: nil,
                                              attribute: .notAnAttribute,
                                              multiplier: 1,
                                              constant: 0)
        heightConstraint.isActive = true
        
        scrollView.addSubview(contentStack)
    }
    
    //MARK:- Getter Setter
    /*public*/
    public var size: CGSize{
        get{
            let height: CGFloat = CGFloat(_actionList.count) * (_config.contentConfig.rowHeight+lineWidth)
            heightConstraint.constant = height
            scrollView.contentSize.height = height
            let finalHeight = height > maxHeight ? maxHeight : height
            
            scrollView.isScrollEnabled = height > finalHeight
            return CGSize(width: mainSize.width, height: finalHeight)
        }
    }
    
    /*private*/
    private var heightConstraint = NSLayoutConstraint()
    private var mainSize = UIScreen.main.bounds.size
    private var maxHeight: CGFloat = 0
    private var _actionList = [CustomDisplayAction]()
    private var _config = ZXActionSheetConfig()
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.bounces = false
        return scroll
    }()
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = lineWidth
        stack.distribution = .fillEqually
        
        return stack
    }()

}
