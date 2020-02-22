//
//  ZXActionSheet.swift
//  CustomDisplayController
//
//  Created by apple on 2020/2/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class ZXActionSheet: UITableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }
    
    convenience init(target: CustomDisplayController) {
        self.init(frame: .zero, style: .plain)
        _target = target
        delegate = self
        dataSource = self
        separatorInset = .zero
        delaysContentTouches = false
        bounces = false
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 配置 ActionSheet
    /// - Parameter config: ZXActionSheetConfig
    public func setConfig(_ config: ZXActionSheetConfig = ZXActionSheetConfig.default){
        _headConfig = config.headConfig
        _contentConfig = config.contentConfig
    }
    
    public func setActionList(_ actionList: [CustomDisplayAction]){
        _actionList = actionList
        _actionList.sort(by: { $0.style.rawValue < $1.style.rawValue })
        reloadData()
    }
    
    public func setTitle(_ title: String?,AndMessage message: String?){
        headView.setTitle(title, AndMessage: message)
    }
    
    public var actionSheetSize: CGSize{
        get{
            var contentHeight = _contentConfig.rowHeight * CGFloat(_actionList.count)
            if _actionList.contains(where: { $0.style == .cancel }){
                contentHeight += _contentConfig.spacing
            }
            let headerHeight = headView.getHeadSize(_headConfig).height
            let totalH = contentHeight + headerHeight
            let finalHeight = totalH > _contentConfig.maxHeight ? _contentConfig.maxHeight : totalH
            return CGSize(width: UIScreen.main.bounds.size.width,height: finalHeight)
        }
    }
    
    private var _contentConfig = ZXActionSheetConfig.ContentConfig()
    private var _headConfig = ZXActionSheetConfig.HeadConfig()
    
    private var isContainCancel: Bool{
        get{
            return _actionList.contains(where: { $0.style == .cancel })
        }
    }
    private var _target: CustomDisplayController?
    private var cellId = ""
    private var _actionList = [CustomDisplayAction]()
    private var headView: CustomActionSheetHead = {
        let head = CustomActionSheetHead()
        return head
    }()
    
}

extension ZXActionSheet: UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headView.getHeadSize(_headConfig).height
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if _actionList[indexPath.row].style == .cancel{
            return _contentConfig.rowHeight + _contentConfig.spacing
        }
        return _contentConfig.rowHeight
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? CustomActionSheetCell else { return }
        let action = _actionList[indexPath.row]
        cell.setConfig(_contentConfig)
        cell.setAction(action)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _target?.dismiss(completion: nil)
        let action = _actionList[indexPath.row]
        action.handler?(action)
    }
    
}

extension ZXActionSheet: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _actionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? CustomActionSheetCell
        cell = cell == nil ? CustomActionSheetCell(style: .default, reuseIdentifier: cellId) : cell
        return cell!
    }
    
}




