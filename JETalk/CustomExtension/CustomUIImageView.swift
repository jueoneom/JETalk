//
//  CustomUIImageView.swift
//  pass_ios
//
//  Created by EOM JUEON on 2020/01/29.
//  Copyright © 2020 EOM JUEON. All rights reserved.
//

import Foundation
import UIKit
extension UIImageView{
    public func imageFromURL(urlString:String, placeholder:UIImage?, completion:@escaping()->()){
        if self.image==nil{
            self.image=placeholder;
        }
        URLSession.shared.dataTask(with: NSURL(string:urlString)! as URL, completionHandler: {(data, response, error)->Void in
            if error != nil{
                print(error as Any);
                return;
            }
            DispatchQueue.main.async (
                execute: { ()->Void in
                    let image=UIImage(data: data!);
                    self.image=image;
                    self.setNeedsLayout();
                    completion();
                }
            )
            
        }).resume();
    }
}
