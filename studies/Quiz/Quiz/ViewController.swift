//
//  ViewController.swift
//  Quiz
//
//  Created by Varis Darasirikul on 4/6/2559 BE.
//  Copyright © 2559 BigNerdRangh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    
    @IBOutlet var currentQuestionLabel: UILabel!
    @IBOutlet var currentQuestionLabelCenterXConstraint: NSLayoutConstraint!
    
    @IBOutlet var nextQuestionLabel: UILabel!
    @IBOutlet var nextQuestionLabelCenterXConstraint: NSLayoutConstraint!
    
    let questions: [String] = ["Question 01","Question 02","Question 03"]
    let answers: [String] = ["Answer01","Answer02","Answer03"]
    var currentQuestionIndex: Int = 0
    
    @IBAction func showNextQuestion(sender: AnyObject){
        currentQuestionIndex += 1
        if currentQuestionIndex == questions.count {
            currentQuestionIndex = 0
        }
        
        let question: String = questions[currentQuestionIndex]
        //questionLabel.text = question
        nextQuestionLabel.text = question
        answerLabel.text = "???"
        
        animateLabelTransitions()
        
    }
    
    @IBAction func showAnswer(sender: AnyObject){
        
        let answer: String = answers[currentQuestionIndex]
        answerLabel.text = answer
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let question = questions[currentQuestionIndex]
        
        //questionLabel.text = questions[currentQuestionIndex]
        
        currentQuestionLabel.text = question
        updateOffScreenLabel()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Set the label's initial alpha
        //questionLabel.alpha = 0
        nextQuestionLabel.alpha = 0
    }
    
    func animateLabelTransitions() {
        
        view.layoutIfNeeded()
        
        let animationClosure = { () -> Void in
            //self.questionLabel.alpha = 1
            self.currentQuestionLabel.alpha = 0
            self.nextQuestionLabel.alpha = 1
            self.view.layoutIfNeeded()
        }
        
        // Animate the alpha
        // and the center X Constraints
        let screenWidth = view.frame.width
        self.nextQuestionLabelCenterXConstraint.constant = 0
        self.currentQuestionLabelCenterXConstraint.constant += screenWidth
        UIView.animateWithDuration(0.5,
                                   delay: 0,
                                   options: [.CurveLinear],
                                   animations: animationClosure,
                                   completion: { _ in
                                    swap(&self.currentQuestionLabel,
                                        &self.nextQuestionLabel)
                                    swap(&self.currentQuestionLabelCenterXConstraint,
                                        &self.nextQuestionLabelCenterXConstraint)
                                    
                                    self.updateOffScreenLabel()
                                    
        })
        
    }
    
    func updateOffScreenLabel() {
        let screenWidth = view.frame.width
        nextQuestionLabelCenterXConstraint.constant = -screenWidth
    }

}

