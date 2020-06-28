//
//  triangleView.swift
//  pass_ios
//
//  Created by jinkyu on 26/02/2020.
//  Copyright © 2020 EOM JUEON. All rights reserved.
//

import UIKit

class triangleView:UIView{
    override func draw(_ rect: CGRect) {
        let layerHeight=layer.frame.height;
        let layerWidth=layer.frame.width;
        
        let bezierPath=UIBezierPath();
        
        bezierPath.move(to: CGPoint(x: 0, y: layerHeight));
        bezierPath.addLine(to: CGPoint(x: layerWidth, y: layerHeight));
        bezierPath.addLine(to: CGPoint(x: layerWidth/2, y: 0));
        bezierPath.addLine(to: CGPoint(x: 0, y: layerHeight));
        
        backgroundColor?.setFill();
        bezierPath.fill();
        
        let shapeLayer=CAShapeLayer();
        shapeLayer.path=bezierPath.cgPath;
        layer.mask=shapeLayer;
        
        
    }
}
