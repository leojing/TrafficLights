//
//  TrafficLight.swift
//  Traffic Lights
//
//  Created by JINGLUO on 23/5/17.
//
//

import Foundation
import UIKit

class TrafficLight: NSObject {
  
  enum Direction {
    // two directions of TrafficLight shows up.
    case horizontal
    case vertical
    
    // the angle to rotate the TrafficLight image view.
    func lightAngle() -> CGFloat {
      switch self {
      case .horizontal:
        return CGFloat(0)
        
      case .vertical:
        return CGFloat(Double.pi/2)
      }
    }
    
    // exchange the two directions after the "switch" button tapped.
    func nextDirection() -> Direction {
      switch self {
      case .horizontal:
        return .vertical
        
      case .vertical:
        return .horizontal
      }
    }
  }
  
  enum LightType {
    // three status for TrafficLight
    case red
    case yellow
    case green
    
    func imageForLightType() -> UIImage {
      // return image for different status
      switch self {
      case .red:
        guard let image = UIImage(named: "red") else {
          preconditionFailure()
        }
        return image
        
      case .yellow:
        guard let image = UIImage(named: "amber") else {
          preconditionFailure()
        }
        return image
        
      case .green:
        guard let image = UIImage(named: "green") else {
          preconditionFailure()
        }
        return image
      }
    }
    
    func nextLight() -> LightType {
      // follow the sequence "green->yellow->red->go back to green" to change light status
      switch self {
      case .green:
        return .yellow
        
      case .yellow:
        return .red
        
      case .red:
        return .green
      }
    }
    
    func configTimeInterval() -> DispatchTimeInterval {
      // for stay 30s of green and red, 5s of yellow, should set different time interval
      switch self {
      case .red:
        return Constants.longInterval
        
      case .yellow:
        return Constants.shortInterval
        
      case .green:
        return Constants.normalInterval
      }
    }
  }
  
  enum Constants {
    fileprivate static let longInterval = DispatchTimeInterval.seconds(6)
    fileprivate static let normalInterval = DispatchTimeInterval.seconds(5)
    fileprivate static let shortInterval = DispatchTimeInterval.seconds(1)
  }
  
  var type: LightType?
  var direction: Direction?
  var timer: DispatchSourceTimer?
  
  var lightImageView: UIImageView?
  var lightFlag: Int?
  
  init(with type: LightType, direction: Direction, imageView: UIImageView) {
    self.type = type
    self.direction = direction
    self.lightImageView = imageView
    self.lightImageView?.transform = CGAffineTransform.identity.rotated(by: (self.direction?.lightAngle())!)
    
    super.init()
  }
  
  func createTimewith(_ flag: Int? = 0) {
    // use DispatchSource timer for a reschedule interval timer.
    timer = DispatchSource.makeTimerSource(flags: DispatchSource.TimerFlags(rawValue: UInt(flag!)), queue: DispatchQueue.main)
    timer?.setEventHandler(handler: {
      guard let t = self.type else {
        preconditionFailure()
      }
      self.lightImageView?.image = t.imageForLightType()

      let timeInterval = t.configTimeInterval()
      self.timer?.scheduleRepeating(deadline: .now() + timeInterval, interval: timeInterval)
      self.type = t.nextLight()
    })
  }
  
  func startTimer() {
    guard let timeInterval = self.type?.configTimeInterval() else {
      return
    }
    timer?.scheduleRepeating(deadline: .now(), interval: timeInterval)
    if #available(iOS 10.0, *) {
      timer?.activate()
    } else {
      // Fallback on earlier versions
      timer?.resume()
    }
  }
  
  func resumeTimer() {
    timer?.resume()
  }
  
  func suspendTimer() {
    timer?.suspend()
  }

}
