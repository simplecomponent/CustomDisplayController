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
        contentConfig.cancelColor = .blue
        contentConfig.defaultFont = .systemFont(ofSize: 16)
        contentConfig.cancelFont = .systemFont(ofSize: 16)
        contentConfig.destructiveFont = .systemFont(ofSize: 16)
        contentConfig.spacing = 10
        contentConfig.rowHeight = 50
        contentConfig.maxHeight = 500
        contentConfig.rowBackColor = .white
        
        let def = ZXActionSheetConfig(headConfig: headConfig,
                                      contentConfig: contentConfig)
        
        return def
    }()
    
    class HeadConfig: NSObject {
        var backColor = UIColor.white
        var titleColor = UIColor.black
        var titleFont = UIFont.systemFont(ofSize: 17)
        var msgColor = UIColor.black
        var msgFont = UIFont.systemFont(ofSize: 17)
        var topCornerRadius: CGFloat = 0
    }
    
    class ContentConfig: NSObject {
        
        var maxHeight: CGFloat = 0
        ///背景色
        var rowBackColor = UIColor.white
        ///行高
        var rowHeight: CGFloat = 0
        ///选项和取消的间距
        var spacing: CGFloat = 0
        ///背景色
        var spacingColor = UIColor(red: 200/255.0, green: 200/255.0, blue: 200/255.0, alpha: 1)
        //color
        var defaultColor = UIColor.black
        var destructiveColor = UIColor.red
        var cancelColor = UIColor.blue
        
        //font
        var defaultFont = UIFont.systemFont(ofSize: 17)
        var destructiveFont = UIFont.systemFont(ofSize: 17)
        var cancelFont = UIFont.systemFont(ofSize: 17)
    }
    
    @objc var headConfig = HeadConfig()
    @objc var contentConfig = ContentConfig()
    
    convenience init(headConfig: HeadConfig,contentConfig: ContentConfig) {
        self.init()
        self.headConfig = headConfig
        self.contentConfig = contentConfig
    }
}
