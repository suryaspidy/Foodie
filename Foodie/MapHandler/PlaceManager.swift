//
//  PlaceManager.swift
//  Foodie
//
//  Created by surya-zstk231 on 22/09/22.
//

import Foundation
import GooglePlaces
import GoogleMaps

class PlaceManager {
    
    static let client = GMSPlacesClient.shared()
    
    /// Used to get searched places list 
    /// - Parameter val : searchable string value
    /// - Returns: It returns Array of places object and error.
    static func getPlaceList(_ val: String, completion: @escaping(Result<[GMSAutocompletePrediction], Error>) -> Void) {
        let filter = GMSAutocompleteFilter()
        filter.type = .geocode
        client.findAutocompletePredictions(fromQuery: val, filter: filter, sessionToken: nil) { results, error in
            guard let results = results, error == nil else {
                completion(.failure(error!))
                return
            }
            completion(.success(results))
        }
    }
    
    static func getCurrentPlace(completion: @escaping(Result<(CLLocationCoordinate2D), Error>) -> Void) {
        client.currentPlace { (hoodList, error) in
            guard let hoodList = hoodList?.likelihoods.first, error == nil else {
                completion(.failure(error!))
                return
            }
            let place = hoodList.place.coordinate
            completion(.success(place))
        }
    }
    
    static func getLocationFromID(_ placeId: String,completion: @escaping(Result<(GMSPlace), Error>) -> Void) {
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
                                                  UInt(GMSPlaceField.placeID.rawValue))

        client.fetchPlace(fromPlaceID: placeId, placeFields: fields, sessionToken: nil, callback: {
          (place: GMSPlace?, error: Error?) in
            guard error == nil, let place = place else {
                completion(.failure(error!))
                return
            }
            completion(.success(place))
        })
    }
    
    static func getLocation(cordinate: CLLocationCoordinate2D) {
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(cordinate) { (response, error) in
            
            if error != nil{
                print("reverse geodcode fail: \(error!.localizedDescription)")
            }else{
                if let places = response?.results(){
                    if let place = places.first{
                        print("GMS Address Place-->", place)
                        if let lines = place.lines{
                            print("GEOCODE: Formatted Address: \(lines[0])")
                        }
                    }else{
                        print("GEOCODE: nil first in places")
                    }
                }else{
                    print("GEOCODE: nil in places")
                }
            }
        }
    }
}
