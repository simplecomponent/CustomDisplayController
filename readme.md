# 展示控制器
可以传入基于 `UIView` 的自定义 `View`
可传入自定义 `Controller`

- 传入时需要自己计算View相对位置

## 用法

- customView

```

let customView = UIView(frame: CGRect(origin: CGPoint(x: view.bounds.size.width/2-150,
                                                      y: view.bounds.size.height/2-80),
                                      size: CGSize(width: 300, height: 160)))
customView.backgroundColor = .red        
let disPlay = CoutomDisplayController(customView: customView, showType: .scale)
self.present(disPlay, animated: true, completion: nil)

```

- customController

```
let customVC = UIViewController()
customVC.view.backgroundColor = .blue
customVC.view.frame = CGRect(origin: CGPoint(x: 0, y: 200),
                             size: CGSize(width: view.bounds.size.width,
                                          height: view.bounds.size.height))
let disPlay = CoutomDisplayController(controller: customVC, showType: .translation)
self.present(disPlay, animated: true, completion: nil)
```


> 显示后修改传入View的frame可及时改变，支持动画



```
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
```