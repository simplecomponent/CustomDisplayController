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
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if event?.allTouches?.count ?? 0 > 1{
            
            let customVC = UITableViewController()
            let customVC2 = UITableViewController()
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
            
        }else{
            customView = UIView(frame: CGRect(origin: CGPoint(x: view.bounds.size.width/2-150,
                                                              y: view.bounds.size.height/2-80),
                                              size: CGSize(width: 300, height: 160)))
            customView.backgroundColor = .red
            let disPlay = CustomDisplayController(customView: customView, showType: .scale)
            self.present(disPlay, animated: true, completion: nil)
            self.perform(#selector(changeView), with: nil, afterDelay: 1)
        }
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
}

