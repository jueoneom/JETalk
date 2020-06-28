//
//  MDepthZeroVC.swift
//  pass_ios
//
//  Created by jinkyu on 13/02/2020.
//  Copyright © 2020 EOM JUEON. All rights reserved.
//

import UIKit


class MDepthZeroVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad();
        
        let gradient = CAGradientLayer()

        gradient.frame = view.bounds

        gradient.colors = [
            UIColor(named: "moonFirstColor")?.cgColor,
            UIColor(named: "moonSecondColor")?.cgColor
        ]
        self.view.layer.insertSublayer(gradient, at: 0)
    }
    
    @IBAction func unwindToMoonZeroScene(sender:UIStoryboardSegue){}

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        MoonAIData.shared.questionNum = 0;
        MoonAIData.shared.clear();
    }

    @IBAction func unwindFromMoon(_ sender: Any) {
        self.dismiss(animated: true, completion: nil);
    }
    
}
