//
//  MDepthGeneralVC.swift
//  pass_ios
//
//  Created by jinkyu on 13/02/2020.
//  Copyright © 2020 EOM JUEON. All rights reserved.
//

import UIKit


//1단, 2단, 3단 answerList를 작성해야함.
class MDepthGeneralVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerCollection: UICollectionView!
    @IBOutlet var collectionHeight: NSLayoutConstraint!
    @IBOutlet var stepProgress: UIProgressView!
    @IBOutlet var beforeBtn: UIButton!
    @IBOutlet var nextBtn: UIButton!
    
    var itemArr = [String]();
    var questionType:Int=6;
    
    @IBOutlet var progressBar: UIProgressView!
    @IBOutlet var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        answerCollection.delegate=self;
        answerCollection.dataSource=self;
        answerCollection.allowsMultipleSelection=false;
       
    }
    override func viewWillAppear(_ animated: Bool) {
        
        if questionType==6{
            answerCollection.allowsMultipleSelection=true;
        }
        else{
            answerCollection.allowsMultipleSelection=false;
        }
        if MoonAIData.shared.questionNum>=MoonAIData.shared.questionList.count-1{
            nextBtn.setTitle("제출", for: .normal);
        }
        self.answerCollection.reloadData();
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
                
                answerCollection.allowsMultipleSelection=false;
                answerCollection.reloadData();
            case 6:
                self.viewWillAppear(true);
                answerCollection.allowsMultipleSelection=true;
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
    
    @IBAction func toBeforeVC(_ sender: Any) {
        MoonAIData.shared.questionNum=MoonAIData.shared.questionNum-1;
        if MoonAIData.shared.questionNum<0{
            self.navigationController?.popViewController(animated: true);
        }
        else{
            switch MoonAIData.shared.questionList[MoonAIData.shared.questionNum].questionType {
                       case 1,2,3:
                        answerCollection.allowsMultipleSelection=false;
                           self.answerCollection.reloadData();
            case 6:
                answerCollection.allowsMultipleSelection=true;
                answerCollection.reloadData();
            case 4, 5:
                           self.navigationController?.popViewController(animated: true);
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

extension MDepthGeneralVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        itemArr=(MoonAIData.shared.questionList[MoonAIData.shared.questionNum].questionList!);
        checkProgress(); questionLabel.text=MoonAIData.shared.questionList[MoonAIData.shared.questionNum].questionText; questionType=MoonAIData.shared.questionList[MoonAIData.shared.questionNum].questionType;
        
        switch questionType{
        case 1:
            collectionHeight.constant=CGFloat((itemArr.count)*100);
        case 2,6:
            collectionHeight.constant=CGFloat((itemArr.count/2+itemArr.count%2)*100);
        case 3:
            collectionHeight.constant=CGFloat((itemArr.count/3+itemArr.count%3)*100);
        default: break;
        }

        return itemArr.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width=view.frame.size.width-56;
        switch questionType{
        case 1:
            return CGSize(width: width, height: 46);
        case 2,6:
            return CGSize(width: width/2,height: 46);
        case 3:
            return CGSize(width: width/3, height: 46);
           
        default: break;
        }
        return CGSize(width: width, height: 46);

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=answerCollection.dequeueReusableCell(withReuseIdentifier: "answerCell", for: indexPath) as! answerCell;

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
        if (questionType==6)&&(collectionView.indexPathsForSelectedItems?.count ?? 0>=3){
            return false;
        }
        let cell=collectionView.cellForItem(at: indexPath) as! answerCell;
        cell.isSelected=true;
        if questionType==6{
            if MoonAIData.shared.questionList[MoonAIData.shared.questionNum].answerStringData == nil{
                MoonAIData.shared.questionList[MoonAIData.shared.questionNum].answerStringData="";
            }; MoonAIData.shared.questionList[MoonAIData.shared.questionNum].answerStringData!+=String(indexPath.row);
            MoonAIData.shared.questionList[MoonAIData.shared.questionNum].answerStringData! += ",";
        }
        else{
            MoonAIData.shared.questionList[MoonAIData.shared.questionNum].answerData=indexPath.row;
        }
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
        if questionType==6{
            if collectionView.indexPathsForSelectedItems?.count ?? 0>=3{
                changeBtn(buttonType: true);
            }
        }
        else{
            changeBtn(buttonType: true);
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell=collectionView.cellForItem(at: indexPath) as? answerCell;
        cell?.answerLabel?.font=UIFont.systemFont(ofSize: 11.0);
        cell?.answerView?.backgroundColor=UIColor(named: "DaliciousWhite");
        cell?.answerView?.borderWidth=0;
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
