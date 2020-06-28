//
//  CustomUIView.swift
//  test_1130
//
//  Created by EOM JUEON on 2019/12/03.
//  Copyright © 2019 EOM JUEON. All rights reserved.
//

import UIKit


extension UIView{
    @IBInspectable
    var cornerRadius: CGFloat{
        get{
            return layer.cornerRadius;
        }
        set{
            layer.cornerRadius=newValue;
        }
    }
    
    @IBInspectable
    var cornerCircle: Bool{
        get{
            if layer.cornerRadius==layer.frame.size.height/2{return true;}
            else {return false;}

        }
        set{
            layer.cornerRadius = layer.frame.size.height/2;
        }
    }
    
    @IBInspectable
    var cornerWCircle: Bool{
        get{
            if layer.cornerRadius==layer.frame.size.width/2{return true;}
            else {return false;}

        }
        set{
            layer.cornerRadius = layer.frame.size.width/2;
        }
    }
    
    
    @IBInspectable
    var borderWidth:CGFloat{
        get{
            return layer.borderWidth;
        }
        set{
            layer.borderWidth=newValue;
        }
    }
    
    @IBInspectable
    var borderColor:UIColor?{
        get{
            if let color=layer.borderColor{
                return UIColor(cgColor:color);
            }
            return nil;
        }
        set{
            if let color=newValue{
                layer.borderColor=color.cgColor;
            }else{
                layer.borderColor=nil;
            }
        }
    }
    
    enum ViewSide: String {
        case Left = "Left", Right = "Right", Top = "Top", Bottom = "Bottom"
    }
    
    func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {
        
        let border = CALayer()
        border.borderColor = color
        border.name = side.rawValue
        switch side {
        case .Left: border.frame = CGRect(x: 0, y: 0, width: thickness, height: frame.height)
        case .Right: border.frame = CGRect(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)
        case .Top: border.frame = CGRect(x: 0, y: 0, width: frame.width, height: thickness)
        case .Bottom: border.frame = CGRect(x: 0, y: frame.height - thickness, width: frame.width, height: thickness)
        }
        
        border.borderWidth = thickness
        
        layer.addSublayer(border)
    }
    
    @IBInspectable
    var addTopBorder :CGFloat{
        get{
            return layer.borderWidth
        }
        set{
            let border = CALayer();
            border.borderColor=borderColor?.cgColor;
            border.frame = CGRect(x: 0, y: 0, width: frame.width, height: newValue);
            border.borderWidth=newValue;
            layer.addSublayer(border);
        }
    }
    
    @IBInspectable
    var addBottomBorder:CGFloat{
        get{
            return layer.borderWidth
        }
        set{
            let border=CALayer();
            border.borderColor=borderColor?.cgColor;
            border.frame=CGRect(x:0, y:frame.height-newValue, width:frame.width, height:newValue);
            border.borderWidth=newValue;
            layer.addSublayer(border);
        }
    }
    
    @IBInspectable
       var addLeftBorder:CGFloat{
           get{
               return layer.borderWidth
           }
           set{
                let border=CAShapeLayer();
                border.strokeColor=borderColor?.cgColor;
                border.fillColor=nil;
                border.lineDashPattern=[4,5];
            
            //border.frame=CGRect(x:0, y:0, width:newValue+2, height:frame.height);
            border.frame=layer.bounds;
               //border.borderWidth=newValue;
            //border.path=UIBezierPath(rect:border.frame).cgPath;
            let path=CGMutablePath();
            path.addLines(between: [CGPoint(x:layer.frame.minX, y:layer.frame.minY), CGPoint(x:layer.frame.minX, y:layer.frame.maxY)]);
            border.path=path;
        
            layer.addSublayer(border);
                
           }
       }
       

    
    @IBInspectable
    var shadowOffset:CGSize{
        get{
            return layer.shadowOffset;
        }
        set{
            layer.shadowOffset=newValue;
        }
    }
    
    
    @IBInspectable
    var shadowColor:UIColor?{
        get{
            if let color=layer.shadowColor{
                return UIColor(cgColor:color);
            }
            return nil;
        }
        set{
            if let color=newValue{
                layer.shadowColor=color.cgColor;
            }else{
                layer.shadowColor=nil;
            }
        }
    }
    
    func fadeIn(withDuration duration:TimeInterval=1.0){
        UIView.animate(withDuration: duration, animations: {
            self.alpha=1.0;
        })
    }
    
    func fadeOut(withDuration duration:TimeInterval=1.0){
        UIView.animate(withDuration: duration, animations: {
                   self.alpha=0.0;
               })
    }
    
   

}

