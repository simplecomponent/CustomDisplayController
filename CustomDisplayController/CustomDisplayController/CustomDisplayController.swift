//
//  DisplayController.swift
//  ExperimentalPlot
//
//  Created by apple on 2019/10/28.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

extension CustomDisplayAction {
    
    @objc public enum Style : Int {
        
        case `default` = 0
        
        case destructive
        
        case cancel
    }
}

extension CustomDisplayController {
    
    @objc public enum Style : Int {
        
        case actionSheet = 0
        
        case alert
        
    }
}

open class CustomDisplayAction {
    
    convenience init(title: String?, style: CustomDisplayAction.Style, handler: ((CustomDisplayAction) -> Void)? = nil) {
        self.init()
        self._title = title
        self._handler = handler
        self._style = style
    }
    private var _title: String?
    private var _handler: ((CustomDisplayAction) -> Void)?
    private var _style = CustomDisplayAction.Style.default
    
    open var handler: ((CustomDisplayAction) -> Void)? { return _handler }
    open var title: String? { return _title }
    open var style: CustomDisplayAction.Style { return _style }
    //    open var isEnabled: Bool
}

/**
 注意：
 - 不管CustomView还是CustomController，定义好view的frame再传入。
 - 此控制器已监听键盘出现消失事件
 - 传入View可在外部做动画
 */

@objc public class CustomDisplayController: UIViewController {
    override public var preferredScreenEdgesDeferringSystemGestures: UIRectEdge{
        return [.bottom,.right,.left,.right]
    }
    private var inputViewList = [UIView]()
    private var actionList = [CustomDisplayAction]()
    //MARK:- lifeCircle
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = maskColor
        addController(containerController)
        signNotification()
    }
    
    public func addAction(action: CustomDisplayAction){
        switch action.style {
        case .cancel:
            actionSheet?.setCancelView(action)
            break
        default:
            actionList.append(action)
            actionSheet?.appendDisplayAction(action)
        }
        //        actionSheet?.setActionList(actionList)
        actionSheet?.frame.size = actionSheet?.actionSheetSize ?? .zero
        let height = actionSheet?.frame.size.height ?? 0
        actionSheet?.frame.origin = CGPoint(x: 0, y: UIScreen.main.bounds.size.height-height)
    }
    
    private func signNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHidden(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardDidHidden(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc private func keyBoardWillShow(_ notification:Notification){
        guard let userInfo = notification.userInfo else { return }
        let keyboardRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        let keyboardH = keyboardRect?.size.height ?? 0
        if inputViewList.isEmpty { return }
        let nextInputView = getNextInputView()
        let converFrame = nextInputView.convert(nextInputView.bounds, to: view)
        let nextBottomY = converFrame.origin.y+converFrame.size.height
        let keyBoardTopY = UIScreen.main.bounds.size.height-keyboardH
        let offset = keyBoardTopY - (nextBottomY + inputOffsetY)
        ZXDebugSimplePrint("offset:\(offset)")
        if offset >= 0 { return }
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseInOut], animations: {
            self.containerController?.view.frame.origin.y += offset
        }) { (isFinished) in
            
        }
        
    }
    
    @objc private func keyBoardWillHidden(_ notification:Notification){
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseInOut], animations: {
            self.containerController?.view.frame.origin.y = self.showViewFrame.origin.y
        }) { (isFinished) in
            
        }
    }
    
    @objc private func keyBoardDidHidden(_ notification:Notification){
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseInOut], animations: {
            self.containerController?.view.frame.origin.y = self.showViewFrame.origin.y
        }) { (isFinished) in
            
        }
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let controller = self.containerController else { return }
        switch showType {
        case .scale:
            scale(controller)
        case .translation:
            translation(controller)
        }
    }
    
    private func getInputViewsWith(_ view: UIView){
        for subview in view.subviews{
            if subview.isKind(of: UITextView.self) || subview.isKind(of: UITextField.self){
                if !inputViewList.contains(where: { $0===subview }){
                    inputViewList.append(subview)
                }
            }
            if subview.subviews.count > 0{
                getInputViewsWith(subview)
            }
        }
    }
    
    private func getNextInputView()->UIView{
        
        guard let currentInputView = inputViewList.filter({ $0.isFirstResponder }).first else{
            ///如果没有第一响应者，返回输入view列表中第一个view
            return inputViewList.first ?? UIView()
        }
        
        if let index = inputViewList.firstIndex(where: {$0 === currentInputView}){
            ///是否是最后一个view
            if index >= inputViewList.count-1{
                ///如果是最后一个view返回当前的input view 的frame
                return currentInputView
            }
            let nextInput = inputViewList[index+1]
            return nextInput
        }
        ///如果没有匹配到返回当前input view 的frame
        return currentInputView
    }
    
    //MARK:- 父类方法
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        touches.forEach({
            if $0.view === content_view{
                return
            }
            
            let point = $0.location(in: view)
            touchBegin = point
        })
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        touches.forEach({
            let point = $0.location(in: view)
            touchEnd = point
        })
        if didTapMask() && isAllowTapHidden{
            dismiss(completion: nil)
        }
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        touches.forEach({
            let point = $0.location(in: view)
            touchEnd = point
        })
        if didTapMask() && isAllowTapHidden{
            dismiss(completion: nil)
        }
    }
    
    //MARK:- 初始化方法
    
    /// 自定义view
    /// - Parameters:
    ///   - customView: 自定义view
    ///   - showType: 动画类型
    @objc public convenience init(customView: UIView,showType: DisplayAnimationType){
        self.init(nibName: nil, bundle: nil)
        self.showType = showType
        self.containerController = getVCByCustomView(customView)
    }
    
    /// 自定义控制器
    /// - Parameters:
    ///   - controller: 自定义控制器
    ///   - showType: 动画类型
    @objc public convenience init(controller: UIViewController,showType: DisplayAnimationType) {
        self.init(nibName: nil, bundle: nil)
        self.showType = showType
        self.containerController = controller
    }
    
    /// 默认视图
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 副标题
    ///   - preferredStyle: CustomDisplayController.Style
    @objc public convenience init(title: String?,message:String?,preferredStyle: CustomDisplayController.Style){
        self.init(nibName: nil, bundle: nil)
        self.showType = .translation
        //        actionSheet = ZXActionSheet(target: self)
        actionSheet = ActionSheet(target: self)
        actionSheet?.setTitle(title, AndMessage: message)
        actionSheet?.setConfig()
        self.containerController = getVCByCustomView(actionSheet!)
    }
    
    //    private var actionSheet: ZXActionSheet?
    private var actionSheet: ActionSheet?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- func
    
    /*public*/
    
    /// 配置 ActionSheet
    /// - Parameter config: ZXActionSheetConfig
    @objc public func setActionSheetConfig(_ config: ZXActionSheetConfig = ZXActionSheetConfig.default){
        actionSheet?.setConfig(config)
    }
    
    /// 消失方法
    /// - Parameter completion: 动画完成回调
    @objc public func dismiss(_ animation:Bool=true,completion:(()->())?){
        guard let vc = self.containerController else { return }
        delegate?.willDismiss?(self)
        switch showType {
        case .scale:
            dismissScale(vc,animation, completion: completion)
        case .translation:
            dismissTr(vc,animation, completion: completion)
        }
    }
    
    /*private*/
    
    ///controller初始设置
    private func initController(){
        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve
        navigationController?.modalPresentationStyle = .currentContext
    }
    
    ///添加子controller
    private func addController(_ controller: UIViewController?){
        
        guard let controller = self.containerController else { return }
        addChild(controller)
        content_view = controller.view
        view.addSubview(content_view)
        showViewFrame = content_view.convert(content_view.bounds, to: view)
        getInputViewsWith(content_view)
        
    }
    
    ///传入自定义view时自定义controller
    private func getVCByCustomView(_ customView: UIView)->UIViewController{
        let vc = ZXCustomController()
        content_view = customView
        vc.view = content_view
        customView.isUserInteractionEnabled = true
        getInputViewsWith(content_view)
        return vc
    }
    
    ///大小动画
    private func scale(_ controller: UIViewController){
        controller.view.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: .curveEaseInOut, animations: {
            controller.view.transform = CGAffineTransform(scaleX: 1, y: 1)
        }) { (isFinished) in
            
        }
    }
    
    ///位移动画
    private func translation(_ controller: UIViewController){
        controller.view.transform = CGAffineTransform(translationX: 0,
                                                      y: controller.view.bounds.size.height)
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            controller.view.transform = CGAffineTransform(translationX: 0,y: 0)
        }) { (isFinished) in
            
        }
    }
    
    private func didTapMask()->Bool{
        let frame = content_view.convert(content_view.bounds, to: view)
        let tapMask = !frame.contains(touchBegin) && !frame.contains(touchEnd)
        ZXDebugSimplePrint("\(tapMask ? "" : "没有")点击mask")
        return tapMask
    }
    
    private func dismissScale(_ vc: UIViewController,_ animation:Bool=false,completion:(()->())?){
        
        if !animation{
            vc.view.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
            vc.view.backgroundColor = vc.view.backgroundColor?.withAlphaComponent(0)
            dismiss(animated: false) {
                vc.view.backgroundColor = vc.view.backgroundColor?.withAlphaComponent(1)
                completion?()
                self.delegate?.didDismiss?(self)
            }
            return
        }
        
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            vc.view.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
            vc.view.backgroundColor = vc.view.backgroundColor?.withAlphaComponent(0)
        }) { (isFinised) in
            vc.view.backgroundColor = vc.view.backgroundColor?.withAlphaComponent(1)
            completion?()
            self.delegate?.didDismiss?(self)
        }
        dismiss(animated: true, completion: nil)
    }
    
    private func dismissTr(_ vc: UIViewController,_ animation:Bool=false,completion:(()->())?){
        if !animation{
            vc.view.transform = CGAffineTransform(translationX: 0, y: vc.view.bounds.size.height)
            vc.view.backgroundColor = vc.view.backgroundColor?.withAlphaComponent(0)
            dismiss(animated: false) {
                vc.view.backgroundColor = vc.view.backgroundColor?.withAlphaComponent(1)
                completion?()
                self.delegate?.didDismiss?(self)
            }
            return
        }
        
        UIView.animate(withDuration:0.24, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.19, options: .curveEaseInOut, animations: {
            vc.view.transform = CGAffineTransform(translationX: 0, y: vc.view.bounds.size.height)
            vc.view.backgroundColor = vc.view.backgroundColor?.withAlphaComponent(0)
        }) { (isFinised) in
            vc.view.backgroundColor = vc.view.backgroundColor?.withAlphaComponent(1)
            //            guard let weakSelf = self else { return }
            completion?()
            self.delegate?.didDismiss?(self)
        }
        dismiss(animated: true, completion: nil)
    }
    //MARK:- Getter Setter
    /*public*/
    ///输入view底部Y轴偏移距离（UIText**）
    @objc public var inputOffsetY: CGFloat = 10
    //    @objc public var
    ///显示的view
    @objc public var contentView: UIView{
        return content_view
    }
    @objc public weak var delegate: CustomDisplayControllerDelegate?
    ///点击mask是否消失
    @objc public var isAllowTapHidden = true
    @objc public var maskColor = UIColor.black.withAlphaComponent(0.3)
    /*private*/
    
    private var containerController: UIViewController?
    private var content_view = UIView()
    private var touchBegin = CGPoint.zero
    private var touchEnd = CGPoint.zero
    //    private var normalFrame
    ///出现动画类型
    private var showType = DisplayAnimationType.scale
    ///显示View的frame
    private var showViewFrame = CGRect.zero
    
    //MARK:- 析构
    deinit {
        ZXDebugSimplePrint("DisplayController 析构")
        NotificationCenter.default.removeObserver(self)
    }
}

extension CustomDisplayController{
    @objc public enum DisplayAnimationType: Int{
        case scale
        case translation
    }
}

@objc public protocol CustomDisplayControllerDelegate {
    @objc optional func willAppear(_ alert:CustomDisplayController)
    @objc optional func willDismiss(_ alert:CustomDisplayController)
    @objc optional func didDismiss(_ alert:CustomDisplayController)
}

class ZXCustomController: UIViewController{
    override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge{
        return [.bottom,.right]
    }
    
}
