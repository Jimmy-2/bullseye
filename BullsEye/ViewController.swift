//
//  ViewController.swift
//  BullsEye
//
//  Created by Jimmy  on 9/9/21.
//  Due to a bug in where the slider defaults to the minimum value at the start of the app instead of the initial value, I have decided to use chapter 3 final source code in hopes of fixing the problem, in the case that the bug was on my end. However, after using the source code, the problem continues to persist. Changing the initial value of the slider in the interface builder still doesn't stop the app from starting the slider value at the minimum value, which is 1. I have no idea if this is a problem in xcode but have decided to ignore it as the bug is not a huge deal as the next parts of chapter 4 overwrites this part of the bug.


import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var slider: UISlider!
  @IBOutlet weak var slider2: UISlider!
  @IBOutlet var targetLabel: UILabel!
  
  @IBOutlet var scoreLabel: UILabel!
  @IBOutlet var roundLabel: UILabel!
  
  var currentValue = 0
  var currentValue2 = 0
  //var currentValue: Int = 0
  
  //stores random number
  var targetValue = 0
  var targetValue2 = 0
  var scoreValue = 0
  var round = 0
  
  //called once when the view controller is created during app startup
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    //currentValue = lroundf(slider.value)
    
    startOver()
    let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
    slider.setThumbImage(thumbImageNormal, for: .normal)
    slider2.setThumbImage(thumbImageNormal, for: .normal)

    let thumbImageHighlighted = UIImage(
      named: "SliderThumb-Highlighted")!
    slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
    slider2.setThumbImage(thumbImageHighlighted, for: .highlighted)
    
    let insets = UIEdgeInsets(
      top: 0,
      left: 14,
      bottom: 0,
      right: 14)

    let trackLeftImage = UIImage(named: "SliderTrackLeft")!
    let trackLeftResizable = trackLeftImage.resizableImage(
      withCapInsets: insets)
    slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
    slider2.setMinimumTrackImage(trackLeftResizable, for: .normal)


    let trackRightImage = UIImage(named: "SliderTrackRight")!
    let trackRightResizable = trackRightImage.resizableImage(
      withCapInsets: insets)
    slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    slider2.setMaximumTrackImage(trackRightResizable, for: .normal)
    //random integer from 1 to 100
    //targetValue = Int.random(in:1...100)
    
    //1..<100 would exclude 100 (1 to 99)
  }
  
  func startNewRound() {
    round += 1
    targetValue = Int.random(in:0...99)
    currentValue = 0
    currentValue2 = 0
    slider.value = Float(currentValue)
    slider2.value = Float(currentValue2)
    updateLabels()
  }
  
  func updateLabels() {
    //targetValue is an int so you cannot out it into a String object
    targetLabel.text = String(targetValue)
    scoreLabel.text = String(scoreValue)
    roundLabel.text = String(round)
  }
  
  @IBAction func startOver() {
    round = 0
    scoreValue = 0
    startNewRound()
    
    //make nice transitions
    let transition = CATransition()
    transition.type = CATransitionType.fade
    transition.duration = 1
    transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
    view.layer.add(transition, forKey:nil)
  
  }
  
  //method is called when hit me button is pressed
  //@IBAction is the same as any other method like updateLabels but allows the user to hook up the method to storyboard objects
  @IBAction func showAlert() {
    let difference = abs(currentValue+currentValue2 - targetValue)
    
    //let is constant, difference will no longer need to be changed
    /*if difference < 0 {
      difference *= -1
      //difference = difference * -1
      //difference = -difference
    }*/
    
    var points = 100 - difference
    
    

    let title: String
    if difference == 0 {
      title = "Perfect!"
      points += 100
    }else if difference < 10 {
      title = "You almost had it!"
      if difference == 1 {
        points += 50
      }
    }else if difference < 25 {
      title = "Pretty good"
    }else {
      title = "Haha you tried"
    }
    scoreValue += points
    
    let message = "You scored \(points) points \(currentValue+currentValue2)"
    
    let alert = UIAlertController(
      title: title,
      message: message,
      preferredStyle: .alert)

    let action = UIAlertAction(
      title: "Ok",
      style: .default,
      //startsnewround is called only when this ok button is pressed
      handler: {_ in
        self.startNewRound()
      })

    alert.addAction(action)

    present(alert, animated: true, completion: nil)
    
    //self.startNewRound()
    //receiver.methodName(parameters)
  }
  
  //method is called when slider is dragged
  @IBAction func sliderMoved(_ slider: UISlider) {
    currentValue = lroundf(slider.value)*10
    
  }
  @IBAction func sliderMoved2(_ slider2: UISlider) {
    currentValue2 = lroundf(slider2.value)
    
  }
}
