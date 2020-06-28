//
//  rotatedLabel.swift
//  pass_ios
//
//  Created by jinkyu on 26/02/2020.
//  Copyright © 2020 EOM JUEON. All rights reserved.
//

import UIKit
import Foundation

class rotatedLabel:UILabel{
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.transform=CGAffineTransform(rotationAngle: 90);
    }
}
