//
//  Artwork.swift
//  breatheAir
//
//  Created by Amir Hesam Rayatnia on 2019-12-28.
//  Copyright © 2019 Amir Hesam Rayatnia. All rights reserved.
//

import Foundation
import MapKit


class Artwork: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    let type: StatusType

    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D, type: StatusType) {
    self.title = title
    self.locationName = locationName
    self.discipline = discipline
    self.coordinate = coordinate
    self.type = type
    super.init()
  }

    var imageName: String? {
      return "Flag"
    }

  var subtitle: String? {
    return locationName
  }

  // pinTintColor for disciplines: Sculpture, Plaque, Mural, Monument, other
  var markerTintColor: UIColor  {
    return  UIColor(hexStr: self.type.getColor(type: self.type))
  }

  


}
