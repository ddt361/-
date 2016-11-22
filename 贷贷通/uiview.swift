//
//  uiview.swift
//  贷贷通
//
//  Created by iMac on 16/3/4.
//  Copyright © 2016年 wujunbao. All rights reserved.
//

import UIKit

class uiview: UIView {
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        //设置画笔
        let context:CGContextRef = UIGraphicsGetCurrentContext()!
        //抗锯齿
        CGContextSetAllowsAntialiasing(context, true)
        //画点
        CGContextFillEllipseInRect(context, CGRectMake(75, 75, 50, 50))
        //设置画笔宽度
        CGContextSetLineWidth(context, 10)
        //设置画笔颜色
//        CGContextSetStrokeColorWithColor(context,UIColor().CGColor)
        //画圆
        CGContextAddEllipseInRect(context, CGRectMake(50, 50, 100, 100))
        CGContextStrokePath(context)
        //通过圆弧画圆
//        CGContextSetStrokeColorWithColor(context, UIColor.redColor().CGColor)
        CGContextAddArc(context, 100, 100, 60, CGFloat(270*M_PI/180), CGFloat(0*M_PI/180), 0)
        CGContextStrokePath(context)
        //使用path画图
//        let p1:CGMutablePathRef = CGPathCreateMutable()
//        CGPathMoveToPoint(p1, nil, 50, 20)
//        CGPathAddLineToPoint(p1, nil, 50, 350)
//        CGContextAddPath(context, p1)
//        CGContextStrokePath(context)
    }
}
