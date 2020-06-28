//
//  CustomUILabel.swift
//  pass_ios
//
//  Created by EOM JUEON on 2019/12/11.
//  Copyright © 2019 EOM JUEON. All rights reserved.
//

import UIKit

extension UILabel{
  
    //stroke style
    @IBInspectable
       var strikeStyle : String{
           get{
               return "Nil";
           }
           set{
               switch newValue {
               case "through":
                   setStrikeThrough(self.text);
               case "underline":
                   setStrikeUnderline(self.text);
               default:
                   setNoStrike(self.text);
               }
           }
       }
    
    
    func setStrikeThrough(_ text:String?){
        
        if text==nil {return;}
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: text!);
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length));
        
        self.attributedText = attributeString;
    }
    
    func setStrikeUnderline(_ text:String?){
        if text==nil {return;}
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: text!);
        attributeString.addAttribute(NSAttributedString.Key.underlineStyle, value: 2, range: NSMakeRange(0, attributeString.length));
        
        self.attributedText = attributeString;
    }
    
    func setNoStrike(_ text:String?){
        if text==nil {return;}
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: text!);
        attributeString.removeAttribute(NSAttributedString.Key.strikethroughStyle, range: NSMakeRange(0, attributeString.length));
        attributeString.removeAttribute(NSAttributedString.Key.underlineStyle, range: NSMakeRange(0, attributeString.length));
    }
    

}

