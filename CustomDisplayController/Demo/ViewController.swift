//
//  ViewController.swift
//  DisplayController
//
//  Created by apple on 2019/12/27.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(tableView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    private var customView = UIView()
    
    @objc private func changeView(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [.curveLinear], animations: {
            self.customView.frame = CGRect(origin: CGPoint(x: self.view.bounds.size.width/2-150,
                                                           y: self.view.bounds.size.height/2-200),
                                           size: CGSize(width: 300, height: 400))
            self.customView.layer.cornerRadius = 20
        }, completion: {
            isFinished in
            
            UIView.animate(withDuration: 0.5, delay: 1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [.curveEaseInOut], animations: {
                self.customView.frame = CGRect(origin: CGPoint(x: self.view.bounds.size.width/2-100,
                                                               y: self.view.bounds.size.height/2-100),
                                               size: CGSize(width: 200, height: 200))
                self.customView.layer.cornerRadius = 100
            }, completion: {
                isFinished in
                
                UIView.animate(withDuration: 0.5, delay: 1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [.curveEaseInOut], animations: {
                    self.customView.frame = CGRect(origin: CGPoint(x: self.view.bounds.size.width/2-150,
                                                                   y: self.view.bounds.size.height/2-50),
                                                   size: CGSize(width: 300, height: 100))
                    self.customView.layer.cornerRadius = 0
                }, completion: {
                    isFinished in
                })
            })
        })
    }
    
    private func showCustomController(){
        let customVC = UITableViewController()
        customVC.title = "首页"
        let customVC2 = UITableViewController()
        customVC2.title = "第二页"
        customVC2.view.backgroundColor = .blue
        let navigation = UINavigationController(rootViewController: customVC)
        customVC.view.backgroundColor = .red
        navigation.view.frame = CGRect(origin: CGPoint(x: 0, y: 200),
                                       size: CGSize(width: view.bounds.size.width,
                                                    height: view.bounds.size.height-200))
        
        let label = UILabel(frame: navigation.view.bounds)
        label.text = "controller"
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 20)
        customVC.view.addSubview(label)
        let disPlay = CustomDisplayController(controller: navigation, showType: .translation)
        self.present(disPlay, animated: true, completion: {
            customVC.navigationController?.pushViewController(customVC2, animated: true)
        })
    }
    
    private func showCustomView(){
        customView = UIView(frame: CGRect(origin: CGPoint(x: view.bounds.size.width/2-150,
                                                          y: view.bounds.size.height/2-80),
                                          size: CGSize(width: 300, height: 160)))
        customView.backgroundColor = .red
        let disPlay = CustomDisplayController(customView: customView, showType: .scale)
        self.present(disPlay, animated: true, completion: nil)
        self.perform(#selector(changeView), with: nil, afterDelay: 1)
    }
    
    
    private let cellId = "Cell"
    private var list = ["自定义View","自定义控制器","ActionSheet"]
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
            case 0:
            showCustomView()
            case 1:
            showCustomController()
            case 2:
                let config = ZXActionSheetConfig.default
                config.contentConfig.rowHeight = 50
                config.footerConfig.titleColor = .blue
//                let alert = CustomDisplayController(title: "nilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnil\nnilnilnilnilnilnil", message: "messagemessagemessagemessagemessagemessagemessagemessagemessagemessage", preferredStyle: .actionSheet)
//                let alert = CustomDisplayController(title: nil, message: "messagemessagemessagemessagemessagemessagemessagemessagemessagemessage", preferredStyle: .actionSheet)
//                let alert = CustomDisplayController(title: "nilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnil", message: nil, preferredStyle: .actionSheet)
//                let alert = CustomDisplayController(title: nil, message: nil, preferredStyle: .actionSheet)
                let alert = CustomDisplayController(title: "选择你喜欢的内容", message: "嘿嘿~\n吼吼~", preferredStyle: .actionSheet)
                alert.delegate = self
//                alert.setActionSheetConfig(config)
                
                for index in 0..<1{
                    alert.addAction(action: CustomDisplayAction(title: "cancel\(index+1)", style: .cancel, handler: { (action) in
                        ZXDebugSimplePrint("cancel")
                    }))
                    alert.addAction(action: CustomDisplayAction(title: "loli\(index+1)", style: .default, handler: { (action) in
                        ZXDebugSimplePrint("loli\(index+1)")
                    }))
                    alert.addAction(action: CustomDisplayAction(title: "default\(index+1)", style: .default, handler: { (action) in
                        ZXDebugSimplePrint("default\(index+1)")
                    }))
                    alert.addAction(action: CustomDisplayAction(title: "destructive\(index+1)", style: .destructive, handler: { (action) in
                        ZXDebugSimplePrint("destructive\(index+1)")
                    }))
                }
                
                present(alert, animated: true, completion: nil)
            
                return
                
                let alert2 = UIAlertController(title: "nilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnil", message:"nilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnilnil", preferredStyle: .actionSheet)
                for index in 0...12{
                    let action = UIAlertAction(title: "第\(index+1)个", style: .default, handler: nil)
                    alert2.addAction(action)
                }
                let actionCancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                alert2.addAction(actionCancel)
                present(alert2, animated: true, completion: nil)
            default:
            break
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.textLabel?.text = list[indexPath.row]
    }
}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        cell = cell == nil ? UITableViewCell(style: .default, reuseIdentifier: cellId) : cell
        return cell!
    }
    
}

extension ViewController: CustomDisplayControllerDelegate{
    func willAppear(_ alert: CustomDisplayController) {
        
    }
    func willDismiss(_ alert: CustomDisplayController) {
        
    }
    func didDismiss(_ alert: CustomDisplayController) {
        ZXDebugSimplePrint("dismiss")
    }
}
