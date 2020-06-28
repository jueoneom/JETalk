//
//  MDepthStyleVC.swift
//  pass_ios
//
//  Created by jinkyu on 13/02/2020.
//  Copyright © 2020 EOM JUEON. All rights reserved.
//

import UIKit

struct StyleData{
    let icon:UIImage?;
    let styleText:String;
}

//현재 아직 스타일쪽은 answertype이 5밖에 없음
class MDepthStyleVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerCollection: UICollectionView!
    @IBOutlet var beforeBtn: UIButton!
    @IBOutlet var nextBtn: UIButton!
    @IBOutlet var collectionHeight: NSLayoutConstraint!
    @IBOutlet var progressLabel: UILabel!
    @IBOutlet var progressBar: UIProgressView!
    
    var answerType:Int=5;
    var itemArr = [StyleData]();
    var itemLabelArr=[String]();
    var itemIconArr=[UIImage]();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        answerCollection.delegate=self;
        answerCollection.dataSource=self;
        answerCollection.allowsMultipleSelection=true;
        
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
            switch MoonAIData.shared.questionList[MoonAIData.shared.questionNum].questionType{
            case 1,2,3,4,6:
                 self.navigationController?.popViewController(animated: true);
            case 5:
                self.answerCollection.reloadData();
            
            default:
                break;
            }
        }
    }
    @IBAction func toNextVC(_ sender: Any) {
        MoonAIData.shared.questionNum=MoonAIData.shared.questionNum+1;
        if MoonAIData.shared.questionNum>=MoonAIData.shared.questionList.count{
            nextBtn.setTitle("끝", for: .normal);
                     performSegue(withIdentifier: "ToResultMoonVC", sender: sender);
        }
        else{
            switch MoonAIData.shared.questionList[MoonAIData.shared.questionNum].questionType {
            case 1,2,3,6:
                performSegue(withIdentifier: "ToStyleGeneralVC", sender: sender);
            case 4:
                
                performSegue(withIdentifier: "ToStyleTextfieldVC", sender: sender);
                
            case 5:
                self.viewWillAppear(true);
                answerCollection.reloadData();
            default:
                break;
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="ToStyleGeneralVC"{
            let vc=segue.destination as! MDepthGeneralVC;
            vc.questionType=MoonAIData.shared.questionList[MoonAIData.shared.questionNum].questionType;
        }
    }
    
    func checkProgress(){
          
          let progressText=(Double(MoonAIData.shared.questionNum+1)/Double(MoonAIData.shared.questionList.count))*100;
        progressLabel.text=String(Int(round(progressText)))+"%";
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

extension MDepthStyleVC:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        itemLabelArr=(MoonAIData.shared.questionList[MoonAIData.shared.questionNum].questionList ?? nil)!;
        checkProgress();
        
        itemIconArr=(MoonAIData.shared.questionList[MoonAIData.shared.questionNum].imageList ?? nil)!;
        questionLabel.text=MoonAIData.shared.questionList[MoonAIData.shared.questionNum].questionText;
        answerType=MoonAIData.shared.questionList[MoonAIData.shared.questionNum].questionType;
        if answerType==5{
            collectionHeight.constant=CGFloat((itemLabelArr.count/4+itemLabelArr.count%4)*100);
        }
        return itemLabelArr.count;
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell=answerCollection.dequeueReusableCell(withReuseIdentifier: "answerStyleCell", for: indexPath) as! answerStyleCell;
        cell.styleLabel.text=itemLabelArr[indexPath.row];
        cell.styleIconImg.image=itemIconArr[indexPath.row];
    
        for index in MoonAIData.shared.questionList[MoonAIData.shared.questionNum].answerList!{
            
            print(index)
            if indexPath.row==index{
                DispatchQueue.main.async(execute: {
                    self.answerCollection.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition.bottom);
                    self.collectionView(self.answerCollection, didSelectItemAt: indexPath);
                });
            }
        }
        
        return cell;
      }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let cell=collectionView.cellForItem(at: indexPath) as! answerStyleCell;

        if collectionView.indexPathsForSelectedItems!.count<2{
        cell.isSelected=true;
            return true;}
        else{
            return false;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        let cell=collectionView.cellForItem(at: indexPath) as! answerStyleCell;
        cell.isSelected=false;
        return true;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell=collectionView.cellForItem(at: indexPath) as! answerStyleCell;
        cell.styleLabel.font=UIFont.boldSystemFont(ofSize: 11.0);
        cell.styleView.backgroundColor=UIColor.white;
        cell.styleView.borderWidth=2;
        if collectionView.indexPathsForSelectedItems!.count==2{
            MoonAIData.shared.questionList[MoonAIData.shared.questionNum].answerList?.removeAll();
           
            for indexPath in collectionView.indexPathsForSelectedItems!{
                MoonAIData.shared.questionList[MoonAIData.shared.questionNum].answerList?.append(indexPath.row);
            }
           
            changeBtn(buttonType: true);
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
         let cell=collectionView.cellForItem(at: indexPath) as! answerStyleCell;
        cell.styleLabel.font=UIFont.systemFont(ofSize: 11.0);
        cell.styleView.backgroundColor=UIColor(named: "DaliciousWhite");
        cell.styleView.borderWidth=0;
        if collectionView.indexPathsForSelectedItems!.count<2{
            changeBtn(buttonType: false);}
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let checkCell=cell as! answerStyleCell;
        if MoonAIData.shared.questionList[MoonAIData.shared.questionNum].answerList?.count ?? 0<2{
            changeBtn(buttonType: false);
        }
        else{
            changeBtn(buttonType: true);
        }
        if checkCell.isSelected{
            checkCell.styleLabel.font=UIFont.boldSystemFont(ofSize: 11.0);
            checkCell.styleView.backgroundColor=UIColor.white;
            checkCell.styleView.borderWidth=2;
        }
        else{
            checkCell.styleLabel.font=UIFont.systemFont(ofSize: 11.0);
                   checkCell.styleView.backgroundColor=UIColor(named: "DaliciousWhite");
                   checkCell.styleView.borderWidth=0;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width=view.frame.size.width-48;
        
        return CGSize(width: width/4, height: 98);
    }
}
