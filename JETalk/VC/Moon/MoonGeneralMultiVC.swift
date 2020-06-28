//
//  MoonGeneralMultiVC.swift
//  pass_ios
//
//  Created by jinkyu on 19/02/2020.
//  Copyright © 2020 EOM JUEON. All rights reserved.
//

import UIKit

class MoonGeneralMultiVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerCollection: UICollectionView!
    @IBOutlet var collectionHeight: NSLayoutConstraint!
    @IBOutlet var beforeBtn: UIButton!
    @IBOutlet var nextBtn: UIButton!
    
    @IBOutlet var progressBar: UIProgressView!
    @IBOutlet var progressLabel: UILabel!
    
    
    var itemArr=[String]();
    var questionType:Int=6;
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        answerCollection.delegate=self;
        answerCollection.dataSource=self;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if MoonAIData.shared.questionNum>=MoonAIData.shared.questionList.count-1{
            nextBtn.setTitle("제출", for: .normal);
        }
        self.answerCollection.reloadData();
    }
    
    @IBAction func toBeforeVC(_ sender: Any) {
        MoonAIData.shared.questionNum=MoonAIData.shared.questionNum-1;
        if MoonAIData.shared.questionNum<0{
            self.navigationController?.popViewController(animated: true);
        }
        else{
            switch MoonAIData.shared.questionList[MoonAIData.shared.questionNum].questionType {
                       case 1,2,3:
                           self.answerCollection.reloadData();
                       case 4, 5:
                           self.navigationController?.popViewController(animated: true);
                       default:
                           break;
                       }
        }
    }
    
    @IBAction func toNextVC(_ sender: Any) {
        MoonAIData.shared.questionNum=MoonAIData.shared.questionNum+1;
        
        if MoonAIData.shared.questionNum>=MoonAIData.shared.questionList.count{
            performSegue(withIdentifier: "ToResultMoonVC", sender: sender);
        }
        else{
            switch MoonAIData.shared.questionList[MoonAIData.shared.questionNum].questionType {
            case 1,2,3:
                self.viewWillAppear(true);
                answerCollection.reloadData();
                
            case 4:
                performSegue(withIdentifier: "ToGeneralTexfieldVC", sender: sender);
            case 5:
                performSegue(withIdentifier: "ToGeneralStyleVC", sender: sender);
            default:
                break;
            }
        }
    }
    
    func checkProgress(){
        let progressText=(Double(MoonAIData.shared.questionNum+1)/Double(MoonAIData.shared.questionList.count))*100;
        progressLabel.text=String(Int(round(progressText)))+"%"
        progressBar.setProgress(Float(Double(progressText)/100), animated: false);
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

    
}

extension MoonGeneralMultiVC{
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        itemArr=(MoonAIData.shared.questionList[MoonAIData.shared.questionNum].questionList!);
        checkProgress();
        questionLabel.text=MoonAIData.shared.questionList[MoonAIData.shared.questionNum].questionText;
        questionType=MoonAIData.shared.questionList[MoonAIData.shared.questionNum].questionType;
         collectionHeight.constant=CGFloat((itemArr.count/2+itemArr.count%2)*100);
        return itemArr.count;
       }
       
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=answerCollection.dequeueReusableCell(withReuseIdentifier: "ansCell", for: indexPath) as! answerMultiCell;
         if indexPath.row==MoonAIData.shared.questionList[MoonAIData.shared.questionNum].answerData{
                   
                   DispatchQueue.main.async(execute: {
                       self.answerCollection.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition.bottom);
                       self.collectionView(self.answerCollection, didSelectItemAt: indexPath);
                   });
                  
               }
               
               cell.answerLabel.text=MoonAIData.shared.questionList[MoonAIData.shared.questionNum].questionList![indexPath.row];
               return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let cell=collectionView.cellForItem(at: indexPath) as! answerCell;
        cell.isSelected=true;
         MoonAIData.shared.questionList[MoonAIData.shared.questionNum].answerData=indexPath.row;
        return true;
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        let cell=collectionView.cellForItem(at: indexPath) as! answerCell;
        cell.isSelected=false;
        
        return true;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell=collectionView.cellForItem(at: indexPath) as! answerCell;
        cell.answerLabel.font=UIFont.boldSystemFont(ofSize: 11.0);
        cell.answerView.backgroundColor=UIColor.white;
        cell.answerView.borderWidth=2;
        cell.checkImg.alpha=1;
        changeBtn(buttonType: true);
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
           let cell=collectionView.cellForItem(at: indexPath) as? answerCell;
           cell?.answerLabel?.font=UIFont.systemFont(ofSize: 11.0);
           cell?.answerView?.backgroundColor=UIColor(named: "DaliciousWhite");
           cell?.answerView?.borderWidth=0;
           cell?.checkImg.alpha=0.3;
           changeBtn(buttonType: false);
       }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5;
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let checkCell=cell as! answerCell;
        changeBtn(buttonType: false);
        if checkCell.isSelected{
            checkCell.answerLabel.font=UIFont.boldSystemFont(ofSize: 11.0);
            checkCell.answerView.borderWidth=2;
            checkCell.answerView.backgroundColor=UIColor.white;
        }
        else{
            checkCell.answerLabel.font=UIFont.systemFont(ofSize: 11.0);
            checkCell.answerView.backgroundColor=UIColor(named: "DaliciousWhite");
            checkCell.answerView.borderWidth=0;
        }
    }
       
}
