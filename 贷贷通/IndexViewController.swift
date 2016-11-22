//
//  ViewController.swift
//  贷贷通
//
//  Created by iMac on 16/3/2.
//  Copyright © 2016年 wujunbao. All rights reserved.
//

import UIKit

class IndexViewController: UIViewController, UIScrollViewDelegate{
    var pageControl:UIPageControl!
    var scrollview:UIScrollView!
    var timer:NSTimer!
    var yuan = uiview()
    override func viewDidLoad() {
        super.viewDidLoad()
        //image width
        scrollview = UIScrollView(frame:CGRect(x: 0, y: 0, width: self.view.bounds.width , height: 300))
        pageControl = UIPageControl(frame:CGRect(x: 10, y: 100, width:200, height: 100))
        pageControl.frame = CGRectMake(self.view.bounds.width/2-65,280, 130, 20)
        pageControl.currentPageIndicatorTintColor = UIColor.redColor()
        pageControl.pageIndicatorTintColor = UIColor.greenColor()
        self.view.addSubview(scrollview)
        self.view.addSubview(pageControl)
        let imageW:CGFloat = scrollview.frame.size.width
        let imageH:CGFloat = scrollview.frame.size.height
        let imageY:CGFloat = 0;
        let totalCount:NSInteger = 5;
        for index in 0..<totalCount{
            let imageView:UIImageView = UIImageView()
            let imageX:CGFloat = CGFloat(index) * imageW;
            imageView.frame = CGRectMake(imageX, imageY, imageW, imageH)
            let name:NSString = NSString(format: "%d", index+1)
            imageView.image = UIImage(named: name as String)
            scrollview.showsHorizontalScrollIndicator = false
            imageView.backgroundColor = UIColor.greenColor()
            scrollview.addSubview(imageView)
        }
        let contentW:CGFloat = imageW * CGFloat(totalCount)
        pageControl.numberOfPages = 5
        scrollview.contentSize = CGSizeMake(contentW, 0)
        scrollview.pagingEnabled = true
        scrollview.delegate = self
        self.addTimer()
        pageControl.currentPage = 0
        yuan.frame = CGRectMake(0, 300, self.view.bounds.width, 300)
        yuan.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        self.view.addSubview(yuan)
    }
    
    func nextImage(sender:AnyObject!){
        var page:Int = pageControl.currentPage;
        if(page == 4){
            page = 0;
        }else{
            ++page
        }
        
        let x:CGFloat = CGFloat(page) * scrollview.frame.size.width
        self.scrollview.setContentOffset(CGPointMake(x, 0), animated: true)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let scrollviewW:CGFloat = scrollview.frame.size.width
        let x:CGFloat = scrollview.contentOffset.x;
        let page:Int = (Int)((x + scrollviewW / 2) / scrollviewW)
        pageControl.currentPage = page
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.removeTimer()
    }
    
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.addTimer()
    }
    
    
    func addTimer(){
        self.timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "nextImage:", userInfo: nil, repeats: true);
        NSRunLoop.currentRunLoop().addTimer(self.timer, forMode: NSRunLoopCommonModes)
    }
    
    func removeTimer(){
        self.timer.invalidate()
    }
}



class pri : UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


