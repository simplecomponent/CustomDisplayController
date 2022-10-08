//
//  ZXActionSheetConfig.swift
//  CustomDisplayController
//
//  Created by apple on 2020/2/21.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

@objc public class ZXActionSheetConfig: NSObject {
    @objc public static let `default`: ZXActionSheetConfig = {
        let headConfig = HeadConfig()
        headConfig.titleFont = UIFont.boldSystemFont(ofSize: 20)
        headConfig.msgFont = UIFont.boldSystemFont(ofSize: 14)
        headConfig.titleColor = .black
        headConfig.topCornerRadius = 10
        headConfig.msgColor = UIColor(red: 150/255.0,
                                      green: 150/255.0,
                                      blue: 150/255.0,
                                      alpha: 1)
        
        let contentConfig = ContentConfig()
        contentConfig.defaultColor = .black
        contentConfig.destructiveColor = .red
        contentConfig.defaultFont = .systemFont(ofSize: 16)
        contentConfig.cancelFont = .systemFont(ofSize: 16)
        contentConfig.destructiveFont = .boldSystemFont(ofSize: 16)
        
        contentConfig.rowHeight = 50
        contentConfig.rowBackColor = .white
        
        
        let footerConfig = FooterConfig()
        footerConfig.titleFont = UIFont.boldSystemFont(ofSize: 20)
        footerConfig.titleColor = .black
        footerConfig.topCornerRadius = 10
        footerConfig.spacing = 10
        
        let def = ZXActionSheetConfig(headConfig: headConfig,
                                      contentConfig: contentConfig,
                                      footerConfig: footerConfig)
        
        return def
    }()
    
    public class HeadConfig: NSObject {
        public var backColor = UIColor.white
        public var titleColor = UIColor.black
        public var titleFont = UIFont.systemFont(ofSize: 17)
        public var msgColor = UIColor.black
        public var msgFont = UIFont.systemFont(ofSize: 17)
        public var topCornerRadius: CGFloat = 0
    }
    
    public class ContentConfig: NSObject {
        
//        var maxHeight: CGFloat = 0
        ///背景色
        public var rowBackColor = UIColor.white
        ///行高
        public var rowHeight: CGFloat = 0
        
        //color
        ///默认类型字体颜色
        public var defaultColor = UIColor.black
        ///destructive类型的字体颜色
        public var destructiveColor = UIColor.red
        ///分割线颜色
        public var separatorColor = UIColor.gray
        //font
        //默认类型字体
        public var defaultFont = UIFont.systemFont(ofSize: 17)
        //destructive类型字体
        public var destructiveFont = UIFont.systemFont(ofSize: 17)
        public var cancelFont = UIFont.systemFont(ofSize: 17)
    }
    
    public class FooterConfig: NSObject {
        public var backColor = UIColor.white
        public var titleColor = UIColor.black
        public var titleFont = UIFont.systemFont(ofSize: 17)
        public var topCornerRadius: CGFloat = 0
        ///选项和取消的间距
        public var spacing: CGFloat = 0
        ///间隔背景色
        public var spacingColor = UIColor(red: 200/255.0, green: 200/255.0, blue: 200/255.0, alpha: 1)
    }
    public var actionSheetBackgroundColor = UIColor.white
    @objc public var headConfig = HeadConfig()
    @objc public var contentConfig = ContentConfig()
    @objc public var footerConfig = FooterConfig()
    
    public convenience init(headConfig: HeadConfig,contentConfig: ContentConfig,footerConfig: FooterConfig) {
        self.init()
        self.headConfig = headConfig
        self.contentConfig = contentConfig
        self.footerConfig = footerConfig
    }
}
