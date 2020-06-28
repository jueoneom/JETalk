//
//  MoonAIData.swift
//  pass_ios
//
//  Created by jinkyu on 14/02/2020.
//  Copyright © 2020 EOM JUEON. All rights reserved.
//

import Foundation
import UIKit

//-1이면 없는 순서
struct QuestionData{
    var questionType:Int=1; //type 1 : general type1 type 2: general type2, type3 : general type3,  4: textfield type 5: style
    var answerType:Int=1;
    var questionText:String;
    var imageList:[UIImage]?;
    var questionList:[String]?;
    var answerData:Int?;
    var answerStringData:String?;
    var answerList:[Int]?;
}

class MoonAIData{
    static let shared = MoonAIData();
    
    var questionNum = -1;
    var questionList=[QuestionData]();
    let resultImgList=["moonResult5","moonResult10","moonResult6","moonResult9","moonResult1","moonResult7","moonResult12","moonResult11","moonResult4","moonResult2","moonResult8","moonResult3"];
    
    let resultNameList=["경제적","위대한", "사냥꾼","지인형","완벽한","4차원","민주주의","합리적","대나무","미어캣","모범적","도전적"];
    
    private init(){
        clear();
    }
    func clear(){
        questionList.removeAll();
        questionList.append(QuestionData(questionType: 6,answerType: 3, questionText: "관심사 3가지를 골라주세요.", imageList: nil, questionList: ["가족", "친구","회사 및 커리어", "나만의 식사", "커뮤니티 와 모임", "취미생활", "운동 및 다이어트", "식도락"],answerData: -1))
        questionList.append(QuestionData(questionType: 2, questionText: "성별을 알려주세요.", imageList: nil, questionList: ["여성", "남성"],answerData: -1));
        questionList.append(QuestionData(questionType: 3, questionText: "출생지는 어디인가요?", imageList: nil, questionList: ["서울","경기", "강원", "충북", "충남", "전북", "전남", "경북", "경남", "제주"],answerData: -1));
        questionList.append(QuestionData(questionType: 4, questionText: "생년월일을 알려주세요.", imageList: nil, questionList: nil, answerStringData: nil));
        questionList.append(QuestionData(questionType: 1, questionText: "야식을 얼마나 드시나요?", imageList: nil, questionList: ["주 1회 이하", "주 2-3회", "주 4회 이상"], answerData: -1));
        questionList.append(QuestionData(questionType: 1, questionText: "운동을 얼마나 하시나요?", imageList: nil, questionList: ["주 1회 이하", "주 2-3회", "주 4회 이상"], answerData: -1));
        questionList.append(QuestionData(questionType: 1, questionText: "음주는 일주일에...", imageList: nil, questionList: ["주 1회 이하", "주 2-3회", "주 4회 이상"],answerData: -1));
        questionList.append(QuestionData(questionType: 5, questionText: "영원히 2가지 음식만 먹을 수 있다면?", imageList: [UIImage(named: "moon1")!,UIImage(named: "moon2")!,UIImage(named: "moon3")!,UIImage(named: "moon4")!,UIImage(named: "moon5")!], questionList: ["한식", "중식", "일식", "양식", "동남아"], answerList: []));
        questionList.append(QuestionData(questionType: 1, questionText: "비 내리는 날, 가장 먼저 떠오르는 것은?", imageList: nil, questionList: ["술집", "국밥집", "레스토랑", "깔끔한 곳이라면 상관 없어"], answerData: -1));
        questionList.append(QuestionData(questionType: 1, questionText: "추운 겨울날, 가장 먼저 떠오르는 음식은?", imageList: nil, questionList: ["따뜻한 국물", "매운 음식", "따뜻한 곳이라면 상관 없어"], answerData: -1));
        questionList.append(QuestionData(questionType: 1, questionText: "친한 친구들과 만났어, 메뉴는?", imageList: nil, questionList: ["내가 직접 골라야지", "친구가 골라주는 편이야"], answerData: -1));
        questionList.append(QuestionData(questionType: 1, questionText: "나는 요즘 꽂힌 메뉴가...", imageList: nil, questionList: ["있어", "없어"], answerData: -1));
        questionList.append(QuestionData(questionType: 1, questionText: "나는 맛집을?", imageList: nil, questionList: ["찾아다녀", "가끔 찾아다녀", "딱히 찾아서 먹진 않아"], answerData: -1));
        questionList.append(QuestionData(questionType: 1, questionText: "같은 가격이라면?", imageList: nil, questionList: ["양이 적어도 맛있는 음식", "적당히 맛있다면 양 많이"], answerData: -1));
    }
    
    
}
