//
//  DiyViewController.swift
//  MiaoHui
//
//  Created by ZW on 2021/9/29.
//

import UIKit
import SnapKit
import Photos

extension UIBezierPath {
    func addArrow(start: CGPoint, end: CGPoint, pointerLineLength: CGFloat, arrowAngle: CGFloat) {
        self.move(to: start)
        self.addLine(to: end)

        let startEndAngle = atan((end.y - start.y) / (end.x - start.x)) + ((end.x - start.x) < 0 ? CGFloat(Double.pi) : 0)
        let arrowLine1 = CGPoint(x: end.x + pointerLineLength * cos(CGFloat(Double.pi) - startEndAngle + arrowAngle), y: end.y - pointerLineLength * sin(CGFloat(Double.pi) - startEndAngle + arrowAngle))
        let arrowLine2 = CGPoint(x: end.x + pointerLineLength * cos(CGFloat(Double.pi) - startEndAngle - arrowAngle), y: end.y - pointerLineLength * sin(CGFloat(Double.pi) - startEndAngle - arrowAngle))

        self.addLine(to: arrowLine1)
        self.move(to: end)
        self.addLine(to: arrowLine2)
    }
}
    
class DiyViewController: UIViewController, UIScrollViewDelegate {
    
    let mainScrollView = UIScrollView()
    let topScrollView = UIScrollView()
    let pageControl = UIPageControl()
    var timer: Timer?
    var pageImage = [UIImage]()
    var scrollImageViews = [UIImageView]()
    var currentIndex: Int = 0
    
    var contentView = UIView()
    var titleLable_1 = UILabel()
    var titleLable_2 = UILabel()
    var titleLable_3 = UILabel()
    var upLoadButton = UIButton()
    var circlrView = UIView()
    var btnLable = UILabel()
    var animateView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMainScrollView()
        setUpMainView()
        setUpScrollView()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let arrow = UIBezierPath()
        arrow.addArrow(start: CGPoint(x: CGFloatAutoFit(45), y: CGFloatAutoFit(40)), end: CGPoint(x: CGFloatAutoFit(45), y: CGFloatAutoFit(20)), pointerLineLength: CGFloatAutoFit(13), arrowAngle: CGFloat(Double.pi / 4))

        let arrowLayer = CAShapeLayer()
        arrowLayer.strokeColor = UIColor.orange.cgColor
        arrowLayer.lineWidth = 3
        arrowLayer.path = arrow.cgPath
        arrowLayer.fillColor = UIColor.clear.cgColor
        arrowLayer.lineJoin = CAShapeLayerLineJoin.round
        arrowLayer.lineCap = CAShapeLayerLineCap.round
        animateView.layer.addSublayer(arrowLayer)
        
        UIView.animate(withDuration: 0.6, delay: 0, options: [.curveEaseIn, .repeat, .autoreverse], animations: {self.animateView.frame.origin.y += CGFloatAutoFit(12)}, completion: {_ in})
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.mainScrollView.contentSize = CGSize(width: CGFloatAutoFit(390), height: CGFloatAutoFit(750))
    }
    
    private func setUpMainScrollView(){
        self.view.addSubview(mainScrollView)
        self.mainScrollView.frame = self.view.bounds
        mainScrollView.contentSize = CGSize(width: CGFloatAutoFit(390), height: CGFloatAutoFit(750))
        mainScrollView.showsVerticalScrollIndicator = false
        mainScrollView.bounces = false
        mainScrollView.delegate = self
        mainScrollView.isScrollEnabled = true
        
        mainScrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(view)
            make.top.bottom.equalTo(mainScrollView)
        }
    }
    
    
    private func setUpMainView(){
        
        contentView.addSubview(topScrollView)
        self.topScrollView.snp.makeConstraints{make in
            make.top.equalTo(mainScrollView.snp.top)
            make.height.equalTo(CGFloatAutoFit(350))
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
        }
        topScrollView.backgroundColor = .systemGray
        
        contentView.addSubview(titleLable_1)
        self.titleLable_1.snp.makeConstraints{make in
            make.top.equalTo(topScrollView.snp.bottom).offset(CGFloatAutoFit(10))
            make.height.equalTo(CGFloatAutoFit(100))
            make.centerX.equalToSuperview()
            make.width.equalTo(CGFloatAutoFit(300))
        }
        titleLable_1.text = "上传半身照即刻生成"
        titleLable_1.textAlignment = .center
        titleLable_1.font = UIFont.systemFont(ofSize: CGFloatAutoFit(40), weight: UIFont.Weight(rawValue: 7))
        titleLable_1.numberOfLines = 2
        
        contentView.addSubview(titleLable_2)
        self.titleLable_2.snp.makeConstraints{make in
            make.top.equalTo(titleLable_1.snp.bottom).offset(CGFloatAutoFit(10))
            make.height.equalTo(CGFloatAutoFit(100))
            make.centerX.equalToSuperview()
            make.width.equalTo(CGFloatAutoFit(300))
        }
        titleLable_2.text = "定制款专属伴手礼"
        titleLable_2.textAlignment = .center
        titleLable_2.textColor = .brown
        titleLable_2.font = UIFont.systemFont(ofSize: CGFloatAutoFit(40), weight: UIFont.Weight(rawValue: 7))
        titleLable_2.numberOfLines = 2
        
        contentView.addSubview(titleLable_3)
        self.titleLable_3.snp.makeConstraints{make in
            make.top.equalTo(titleLable_2.snp.bottom).offset(CGFloatAutoFit(5))
            make.height.equalTo(CGFloatAutoFit(60))
            make.centerX.equalToSuperview()
            make.width.equalTo(CGFloatAutoFit(250))
        }
        titleLable_3.text = "生成专属艺术形象即可前往描绘商城下单～"
        titleLable_3.textAlignment = .center
        titleLable_3.textColor = .gray
        titleLable_3.font = UIFont.systemFont(ofSize: CGFloatAutoFit(18))
        titleLable_3.numberOfLines = 2
        
        contentView.addSubview(upLoadButton)
        self.upLoadButton.snp.makeConstraints{make in
            make.top.equalTo(titleLable_3.snp.bottom).offset(CGFloatAutoFit(10))
            make.height.equalTo(CGFloatAutoFit(80))
            make.centerX.equalToSuperview()
            make.width.equalTo(CGFloatAutoFit(300))
        }
        print("按下去")
        upLoadButton.backgroundColor = .orange
        upLoadButton.layer.cornerRadius = CGFloatAutoFit(40)
        upLoadButton.addTarget(self, action: #selector(addAlert), for: .touchUpInside)
        
        upLoadButton.addSubview(circlrView)
        circlrView.snp.makeConstraints{make in
            make.centerY.equalToSuperview()
            make.height.equalTo(CGFloatAutoFit(50))
            make.left.equalTo(upLoadButton.snp.left).offset(CGFloatAutoFit(20))
            make.width.equalTo(CGFloatAutoFit(50))
        }
        circlrView.layer.cornerRadius = CGFloatAutoFit(25)
        circlrView.backgroundColor = .white

        upLoadButton.addSubview(btnLable)
        btnLable.snp.makeConstraints{make in
            make.centerY.equalToSuperview()
            make.height.equalTo(CGFloatAutoFit(50))
            make.left.equalTo(circlrView.snp.right).offset(CGFloatAutoFit(20))
            make.width.equalTo(CGFloatAutoFit(200))
        }
        btnLable.text = "上传正面半身照"
        btnLable.textColor = .white
        btnLable.font = UIFont.systemFont(ofSize: CGFloatAutoFit(25), weight: UIFont.Weight(1.5))
        
        upLoadButton.addSubview(animateView)
        self.animateView.snp.makeConstraints{make in
            make.top.equalTo(titleLable_3.snp.bottom).offset(CGFloatAutoFit(10))
            make.height.equalTo(CGFloatAutoFit(80))
            make.centerX.equalToSuperview()
            make.width.equalTo(CGFloatAutoFit(300))
        }
        animateView.backgroundColor = .none
    }
    
    func setUpScrollView(){
        
        pageImage = [UIImage(named: "橙心橙意-小蓝")!,
                     UIImage(named: "繁花物语")!,
                     UIImage(named: "国韵蓝")!,
                     UIImage(named: "浪漫满溢")!]
        
        topScrollView.isPagingEnabled = true
        topScrollView.bounces = false
        topScrollView.showsHorizontalScrollIndicator = false
        topScrollView.showsVerticalScrollIndicator = false
        topScrollView.contentSize = CGSize(width: CGFloatAutoFit(390) * 3, height: CGFloatAutoFit(350))
        topScrollView.scrollRectToVisible(CGRect(x: 0, y: 0, width: CGFloatAutoFit(400), height: CGFloatAutoFit(250)), animated: false)
        topScrollView.delegate = self
        
        for index in -1 ... 1 {
            let imageView = UIImageView(frame: CGRect(x: CGFloat(index + 1) * CGFloatAutoFit(390), y: 0, width: CGFloatAutoFit(390), height: CGFloatAutoFit(350)))
            imageView.isUserInteractionEnabled = true
            imageView.contentMode = .scaleToFill
            imageView.image = pageImage[(index + pageImage.count) % pageImage.count]
            scrollImageViews.append(imageView)
            topScrollView.addSubview(imageView)
        }
        
        view.addSubview(pageControl)
        pageControl.isUserInteractionEnabled = true
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = UIColor.gray
        pageControl.numberOfPages = pageImage.count
        pageControl.currentPage = 0
        pageControl.snp.makeConstraints { make in
            make.width.equalTo(CGFloatAutoFit(200))
            make.height.equalTo(CGFloatAutoFit(20))
            make.bottom.equalTo(topScrollView.snp.bottom).offset(CGFloatAutoFit(-10))
            make.centerX.equalToSuperview()
        }
        pageControl.addTarget(self, action: #selector(pageClick(sender:)), for: .valueChanged)
        startTimer()
    }
    
    
    @objc func pageClick(sender: UIPageControl){
        stopTimer()
        if (sender.currentPage > currentIndex){
            UIView.animate(withDuration: 0.4, animations: {
                self.topScrollView.contentOffset = CGPoint(x: self.topScrollView.frame.width * 2, y: 0)
            }, completion: { ok in
                if ok {
                    self.refreshPage()
                }
            })
        } else {
            UIView.animate(withDuration: 0.4, animations: {
                self.topScrollView.contentOffset = CGPoint(x: 0, y: 0)
            }, completion: { ok in
                if ok {
                    self.refreshPage()
                }
            })
        }
        startTimer()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    func stopTimer(){
        timer?.invalidate()
        timer = nil
    }
    
    func refreshPage() {
        let count = pageImage.count
        let offset = topScrollView.contentOffset
        if offset.x > topScrollView.frame.width {
            currentIndex = (currentIndex + 1) % count
        } else if offset.x < topScrollView.frame.width {
            currentIndex = (currentIndex - 1 + count) % count
        }
        let leftIndex = (currentIndex - 1 + count) % count
        let rightIndex = (currentIndex + 1) % count
        
        scrollImageViews[0].image = pageImage[leftIndex]
        scrollImageViews[1].image = pageImage[currentIndex]
        scrollImageViews[2].image = pageImage[rightIndex]
        topScrollView.setContentOffset(CGPoint(x: topScrollView.frame.width, y: 0), animated: false)
        pageControl.currentPage = currentIndex
    }
    
    @objc func timerAction() {
        UIView.animate(withDuration: 0.5, animations: {
            self.topScrollView.contentOffset = CGPoint(x: self.topScrollView.frame.width * 2, y: 0)
        }, completion: { ok in
            if ok {
                self.refreshPage()
            }
        })
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startTimer()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        refreshPage()
    }

    @objc func addAlert() {
        
        let alertController = UIAlertController(title: nil, message: nil,preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消",style: .cancel,handler: nil)
        alertController.addAction(cancelAction)
        let photoLibraryAction = UIAlertAction(title: "相册选取",style: .default,handler: nil)
        alertController.addAction(photoLibraryAction)
        let cameraAction = UIAlertAction(title: "拍照", style: .default, handler: nil)
        alertController.addAction(cameraAction)
        self.present(alertController ,animated: true ,completion: nil)

    }
}
//访问相机
extension DiyViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func judgeAlbumPermissions() {
            
            // 获取相册权限
            let authStatus = PHPhotoLibrary.authorizationStatus()
            
            //用户尚未授权
            if authStatus == .notDetermined {
                // 第一次触发授权 alert
                PHPhotoLibrary.requestAuthorization({ [weak self] (states) in
                    // 判断用户选择了什么
                    
                    guard let strongSelf = self else { return }
                    
                    if states == .authorized {
                        strongSelf.openPhoto()
                        
                    } else if states == .restricted || states == .denied {
                        // 提示没权限
                        
                    }
                    
                })
                
            } else if authStatus == .authorized {
                // 可以访问 去打开相册
                self.openPhoto()
                
            } else if authStatus == .restricted || authStatus == .denied {
                // App无权访问照片库 用户已明确拒绝
            }
            
        }
    func openPhoto() {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            DispatchQueue.main.async {
                let picker = UIImagePickerController()
                picker.delegate = self
                picker.sourceType = .photoLibrary
                self.present(picker, animated: true)
            }
        }
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            // 获取选择的图片
            guard let pickedImage = info[UIImagePickerController.InfoKey.originalImage]
                as? UIImage else {
                    print("选择失败")
                    return
            }
            picker.dismiss(animated: true) {
//                self.dealwith(image: pickedImage)
            }
            
        }
}
