//
//  MResultVC.swift
//  pass_ios
//
//  Created by jinkyu on 13/02/2020.
//  Copyright © 2020 EOM JUEON. All rights reserved.
//

import UIKit

class MResultVC: UIViewController {

    @IBOutlet var resultTitle: UILabel!
    @IBOutlet var resultDescription: UITextView!
    @IBOutlet var resultHashTag: UILabel!
    @IBOutlet var resultImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let ud=UserDefaults.standard
//        if let moonPKey=ud.string(forKey: "MoonPKey"){
//            let moonId=Int(moonPKey)!-1;
//            requestMoonSurveyGet(moonId: String(moonId))
//        }
//        else{
//            requestPostMoon(vc: self)
//        }
    }
    @IBAction func dismissView(_ sender: Any) {
        dismiss(animated: true, completion: nil);
    }
    
    @IBAction func dismissView2(_ sender: Any) {
        dismiss(animated: true, completion: nil);
    }
}

//extension MResultVC{
//    func requestMoonSurveyGet(moonId:String){
//
//        API.shared.requestMySurveyGet(vc: self, gourmandTypeId: moonId){(result) in
//            DispatchQueue.main.async {
//                if let item=result["Data"] as? [String:Any]{
//                    let pkey=item["PKey"] as! String;
//                    let name=item["Name"] as! String;
//                    let description=item["Description"] as! String;
//
//                    var hashText="";
//                    if let hash1=item["Hash1"] as? String{
//                        hashText = hashText + " #"+hash1;
//                    }
//                    if let hash2=item["Hash2"] as? String{
//
//                        hashText = hashText + " #"+hash2;
//                    }
//                    if let hash3=item["Hash3"] as? String{
//                        hashText = hashText + " #"+hash3;
//                    }
//                    self.resultTitle.text=name;
//                    let imgNum=Int(pkey)!;
//                    self.resultImg.image=UIImage(named: MoonAIData.shared.resultImgList[imgNum-1]);
//                    self.resultDescription.text=description;
//
//
//                    self.resultHashTag.text=hashText
//                }
//            }
//
//        }
//
//    }
//
//    func requestPostMoon(vc:UIViewController){
//
//            var menu="";
//
//            for index in MoonAIData.shared.questionList[7].answerList!{
//                menu+=String(index);
//                menu+=","
//            }
//        let serviceEnd=MoonAIData.shared.questionList[0].answerStringData!.index(MoonAIData.shared.questionList[0].answerStringData!.endIndex, offsetBy: -1);
//        let moonFirstText=String(MoonAIData.shared.questionList[0].answerStringData![..<serviceEnd]);
//
//
//            let menuEnd=menu.index(menu.endIndex, offsetBy: -1);
//            menu=String(menu[..<menuEnd]);
//
//        API.shared.requestSurvey(vc: self, interest: moonFirstText, gender: String(MoonAIData.shared.questionList[1].answerData!), hometown: String(MoonAIData.shared.questionList[2].answerData!), birth: MoonAIData.shared.questionList[3].answerStringData!, exercise: String(MoonAIData.shared.questionList[4].answerData!), alcohol: String(MoonAIData.shared.questionList[5].answerData!), night: String(MoonAIData.shared.questionList[6].answerData!), menu: menu, rain: String(MoonAIData.shared.questionList[8].answerData!), winter: String(MoonAIData.shared.questionList[9].answerData!), friend: String(MoonAIData.shared.questionList[10].answerData!), favorite: String(MoonAIData.shared.questionList[11].answerData!), hotplace: String(MoonAIData.shared.questionList[12].answerData!), samePrice: String(MoonAIData.shared.questionList[13].answerData!)){(result) in
//                    DispatchQueue.main.async {
//                        if let item=result["Data"] as? [String:Any]{
//                            let pkey=item["PKey"] as! String;
//                            let name=item["Name"] as! String;
//
//                            let description=item["Description"] as! String;
//
//                            var hashText="";
//                            if let hash1=item["Hash1"] as? String{
//                                hashText = hashText + " #"+hash1;
//                            }
//                            if let hash2=item["Hash2"] as? String{
//
//                                hashText = hashText + " #"+hash2;
//                            }
//                            if let hash3=item["Hash3"] as? String{
//                                 hashText = hashText + " #"+hash3;
//                            }
//
//                            self.resultTitle.text=name;
//                            let imgNum=Int(pkey)!;
//                            self.resultImg.image=UIImage(named: MoonAIData.shared.resultImgList[imgNum-1]);
//                            self.resultDescription.text=description;
//
//
//                            self.resultHashTag.text=hashText
//                            let ud=UserDefaults.standard;
//                            ud.set(name, forKey: "MoonName");
//                            ud.set(pkey, forKey: "MoonPKey");
//
//                            ud.set(description,forKey: "MoonDescription");
//                            ud.set(hashText,forKey: "MoonHash");
//                        }
//
//                    }
//
//            }
//        }
//}

