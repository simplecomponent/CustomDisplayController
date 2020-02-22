//
//  ZXActionSheetHeadView.swift
//  CustomDisplayController
//
//  Created by apple on 2020/2/21.
//  Copyright © 2020 apple. All rights reserved.
//
import UIKit

class CustomActionSheetHead: UIView{
    enum HeadTitleType: CGFloat {
        case none                 = 0
        case title                = 40
        case titleMessage         = 60
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleHeightConstraint?.constant = titleLabel.getSize(normalWidth: bounds.size.width-40).height
        messageHeightConstraint?.constant = messageLabel.getSize(normalWidth: bounds.size.width-40).height
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topRight,.topLeft],
                                cornerRadii: CGSize(width: _config.topCornerRadius,
                                                    height: _config.topCornerRadius))
        let cornerLayer = CAShapeLayer()
        cornerLayer.path = path.cgPath
        layer.mask = cornerLayer
    }
    
    //MARK:- FUNC
    /*public*/
    public func setConfig(_ config: ZXActionSheetConfig.HeadConfig){
        _config = config
        titleLabel.textColor = config.titleColor
        titleLabel.font = config.titleFont
        messageLabel.textColor = config.msgColor
        messageLabel.font = config.msgFont
        backgroundColor = config.backColor
        
    }
    
    public func setTitle(_ title: String?,AndMessage message: String?){
        let titleIsNull = title?.isEmpty ?? true
        let messageIsNull = message?.isEmpty ?? true
        if (!titleIsNull && messageIsNull) || (titleIsNull && !messageIsNull){
            headType = .title
            if title != nil{
                titleLabel.text = title
            }
            if message != nil{
                titleLabel.text = message
            }
        }
        else if !titleIsNull && !messageIsNull{
            headType = .titleMessage
            titleLabel.text = title
            messageLabel.text = message
        }
        else{
            headType = .none
        }
        
    }
    
    public var headSize: CGSize{
        get{
            let mainSize = UIScreen.main.bounds.size
            var headHeight: CGFloat = 0
            switch headType {
                case .none:
                    break
                case .title:
                    let titleHeight = titleLabel.getSize(normalWidth: mainSize.width-40).height
                    headHeight = titleHeight + 16
                case .titleMessage:
                    let titleHeight = titleLabel.getSize(normalWidth: mainSize.width-40).height
                    let msgHeight = messageLabel.getSize(normalWidth: mainSize.width-40).height
                    headHeight = titleHeight + msgHeight + 20
            }
            
            return CGSize(width: mainSize.width, height: headHeight)
        }
    }
    
    public func getHeadSize(_ config: ZXActionSheetConfig.HeadConfig)->CGSize{
        setConfig(config)
        let mainSize = UIScreen.main.bounds.size
        var headHeight: CGFloat = 0
        switch headType {
            case .none:
                break
            case .title:
                let titleHeight = titleLabel.getSize(normalWidth: mainSize.width-40).height
                headHeight = titleHeight + 16
            case .titleMessage:
                let titleHeight = titleLabel.getSize(normalWidth: mainSize.width-40).height
                let msgHeight = messageLabel.getSize(normalWidth: mainSize.width-40).height
                headHeight = titleHeight + msgHeight + 20
        }
        
        return CGSize(width: mainSize.width, height: headHeight)
    }
    
    /*private*/

    private func setUpView(){
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: titleLabel,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .top,
                           multiplier: 1,
                           constant: 10).isActive = true
        
        NSLayoutConstraint(item: titleLabel,
                           attribute: .left,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .left,
                           multiplier: 1,
                           constant: 20).isActive = true
        
        NSLayoutConstraint(item: titleLabel,
                           attribute: .width,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .width,
                           multiplier: 1,
                           constant: -40).isActive = true
                
        NSLayoutConstraint(item: messageLabel,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: titleLabel,
                           attribute: .bottom,
                           multiplier: 1,
                           constant: 2).isActive = true
        
        NSLayoutConstraint(item: messageLabel,
                           attribute: .left,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .left,
                           multiplier: 1,
                           constant: 20).isActive = true
        
        NSLayoutConstraint(item: messageLabel,
                           attribute: .width,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .width,
                           multiplier: 1,
                           constant: -40).isActive = true
        
        titleHeightConstraint = NSLayoutConstraint(item: titleLabel,
                                                   attribute: .height,
                                                   relatedBy: .equal,
                                                   toItem: nil,
                                                   attribute: .notAnAttribute,
                                                   multiplier: 1,
                                                   constant: 0)
        titleHeightConstraint?.isActive = true
        
        messageHeightConstraint = NSLayoutConstraint(item: messageLabel,
                                                     attribute: .height,
                                                     relatedBy: .equal,
                                                     toItem: nil,
                                                     attribute: .notAnAttribute,
                                                     multiplier: 1,
                                                     constant: 0)
        messageHeightConstraint?.isActive = true
        
    }
    //MARK:- Getter Setter
    /*public*/
    private var headType = HeadTitleType.none
    /*private*/
    private var titleHeightConstraint: NSLayoutConstraint?
    private var messageHeightConstraint: NSLayoutConstraint?
    private var _config = ZXActionSheetConfig.HeadConfig()
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private var messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
}
