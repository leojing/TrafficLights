//
//  ViewController.swift
//  Traffic Lights
//

import UIKit

class ViewController: UIViewController {
    
  @IBOutlet weak var lightOfNSImageView: UIImageView!
  @IBOutlet weak var lightOfEWImageView: UIImageView!
  
  fileprivate var lightOfNS: TrafficLight?
  fileprivate var lightOfEW: TrafficLight?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    // config traffic light for North-South direction
    lightOfNS = TrafficLight(with: .green, direction: .horizontal, imageView: lightOfNSImageView)
    lightOfNS?.lightFlag = 1
    lightOfNS?.createTimewith(lightOfNS?.lightFlag)
    
    // config traffic light for East-West direction
    lightOfEW = TrafficLight.init(with: .red, direction: .vertical, imageView: lightOfEWImageView)
    lightOfEW?.lightFlag = 2
    lightOfEW?.createTimewith(lightOfEW?.lightFlag)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
    
  @IBAction func switchButtonPressed(_ sender: Any?) {
    let button = sender as? UIButton
    let title = button?.titleLabel?.text
    if title == "start" {
      lightOfNS?.startTimer()
      lightOfEW?.startTimer()
      button?.setTitle("suspend", for: .normal)
    }
    else if title == "suspend" {
      lightOfNS?.suspendTimer()
      lightOfEW?.suspendTimer()
      button?.setTitle("resume", for: .normal)
    } else {
      lightOfNS?.resumeTimer()
      lightOfEW?.resumeTimer()
      button?.setTitle("suspend", for: .normal)
    }
  }

}

