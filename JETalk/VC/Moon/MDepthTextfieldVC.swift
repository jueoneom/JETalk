//
//  MDepthTextfieldVC.swift
//  pass_ios
//
//  Created by jinkyu on 13/02/2020.
//  Copyright © 2020 EOM JUEON. All rights reserved.
//

import UIKit

class MDepthTextfieldVC: UIViewController, UITextFieldDelegate {

    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerTextfield: UITextField!{didSet{answerTextfield.delegate=self;}}
    @IBOutlet var beforeBtn: UIButton!
    @IBOutlet var nextBtn: UIButton!
    @IBOutlet var progressBar: UIProgressView!
    @IBOutlet var progressLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        let dismissGesture=UITapGestureRecognizer(target: self, action: #selector(self.dismissNumberpad(sender:)));
        self.view.addGestureRecognizer(dismissGesture);
        questionLabel.text=MoonAIData.shared.questionList[MoonAIData.shared.questionNum].questionText;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.answerTextfield.text=MoonAIData.shared.questionList[MoonAIData.shared.questionNum].answerStringData;
        checkProgress();
        changeBtn(buttonType: self.answerTextfield.text!.count>7);
        if MoonAIData.shared.questionNum>=MoonAIData.shared.questionList.count-1{
                   nextBtn.setTitle("제출", for: .normal);
               }
        
    }
    
    @objc func dismissNumberpad(sender:UIGestureRecognizer){
        if self.answerTextfield.isFirstResponder{
            self.answerTextfield.resignFirstResponder();
        }
    }
    func changeBtn(buttonType:Bool){
        nextBtn.isEnabled=buttonType;
        if buttonType{
            nextBtn.backgroundColor=UIColor(named: "kurrantPurple");
            nextBtn.setImage(UIImage(named: "nextBtn"), for: .normal);
        }
        else{
            nextBtn.backgroundColor=UIColor(named: "buttonGrey");
            nextBtn.setImage(UIImage(named: "nextBtnWhite"), for: .normal)
        }
    }
    @IBAction func toBeforeVC(_ sender: Any) {
        MoonAIData.shared.questionNum=MoonAIData.shared.questionNum-1;
        if MoonAIData.shared.questionNum<0{
            self.navigationController?.popViewController(animated: true);
        }
        else{
            switch MoonAIData.shared.questionList[MoonAIData.shared.questionNum].questionType {
                       case 1,2,3,5,6:
                        self.navigationController?.popViewController(animated: true);
                       case 4:
                        checkProgress();
                        self.answerTextfield.text=MoonAIData.shared.questionList[MoonAIData.shared.questionNum].answerStringData;
                         questionLabel.text=MoonAIData.shared.questionList[MoonAIData.shared.questionNum].questionText;
                       default:
                           break;
                       }
        }
    }
    
    @IBAction func toNextVC(_ sender: Any) {
        MoonAIData.shared.questionList[MoonAIData.shared.questionNum].answerStringData=answerTextfield.text;
        MoonAIData.shared.questionNum = MoonAIData.shared.questionNum+1;
               
               if MoonAIData.shared.questionNum>=MoonAIData.shared.questionList.count{
                   performSegue(withIdentifier: "ToResultMoonVC", sender: sender);
               }
               else{
                switch MoonAIData.shared.questionList[MoonAIData.shared.questionNum].questionType {
                case 1,2,3,6:
                    performSegue(withIdentifier: "ToTexfieldGeneralVC", sender: sender);
                case 4:
                    answerTextfield.text="";
                    checkProgress();
                     nextBtn.isEnabled=false;
                     nextBtn.backgroundColor=UIColor(named: "buttonGrey");questionLabel.text=MoonAIData.shared.questionList[MoonAIData.shared.questionNum].questionText;
                case 5:
                    performSegue(withIdentifier: "ToTextfieldStyleVC", sender: sender);
                default:
                    break;
                }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="ToTexfieldGeneralVC"{
            let vc=segue.destination as! MDepthGeneralVC;
            vc.questionType=MoonAIData.shared.questionList[MoonAIData.shared.questionNum].questionType;
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;}
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var maxLength=0;
        guard let text=textField.text else{return true;}
        let newLength=text.count+string.count-range.length;
        if textField==answerTextfield{
            maxLength=8;
        }
        else{
            return true;
        }
        changeBtn(buttonType: newLength>=maxLength);
        
        return newLength<=maxLength;
    }
    
    func checkProgress(){
        let progressText=(Double(MoonAIData.shared.questionNum+1)/Double(MoonAIData.shared.questionList.count))*100;
        progressLabel.text=String(Int(round(progressText)))+"%";
        progressBar.setProgress(Float(Double(progressText)/100), animated: false);
    }

}
