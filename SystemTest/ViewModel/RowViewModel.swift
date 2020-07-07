//
//  RowViewModel.swift
//  WiproTest
//
//  Created by Raidu on 7/2/20.
//  Copyright © 2020 Raidu. All rights reserved.
//

import Foundation
import UIKit

class RowsViewModel {
    
    /// Get Rows Info API Call
    func getRowsInfoFromService( completion : @escaping(_ response:MainJson)-> Void) {
        
        Network.getApiCallWithRequestURLString(requestString: URLConstants.rowsURL, completionBlock: { (data) in
            do {
                let str = String(decoding: data, as: UTF8.self)
                if let data = str.data(using: .utf8) {
                    let jsonDecoder = JSONDecoder()
                    /// Converting response to our custom model
                    let responseModel = try jsonDecoder.decode(MainJson.self, from: data)
                    completion(responseModel)
                }
            }
            catch(let error) {
                ShowAlert.showAlert("Alert", "\(error.localizedDescription)")
            }
        }) { (error) in
            ShowAlert.showAlert("Alert", "\(error.localizedDescription)")
        }
    }
   
}
