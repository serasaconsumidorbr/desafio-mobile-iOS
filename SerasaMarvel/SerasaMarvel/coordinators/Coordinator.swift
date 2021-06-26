//
//  Coordinator.swift
//  SerasaMarvel
//
//  Created by Tito Albino Evangelista da Silva Junior on 25/06/21.
//

import Foundation

protocol Coordinator {
  
  var childCoordinator : [String : Coordinator] { get set }
  
  func start()
  
}
