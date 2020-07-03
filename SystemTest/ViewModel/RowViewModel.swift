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
    
    //    MARK:- Objects & Variables
    var rowsArray = [Rows]()
    weak var vc : ViewController!
    
    //    MARK:- Get API Calls
    
    /// Get Rows Info API Call
    func getRowsInfoFromService() {
        
        Network.getApiCallWithRequestString(requestString: URLConstants.rowsURL) { (response) in
            
            switch response {
            case .failure(let error):
                
                if let urlError = error as? URLError{
                    switch urlError {
                    case .dataNotFound:     print("Data not found")
                    case .unformatedURL:    print("Unformated url")
                    }
                } else {
                    let alert = UIAlertController(title: "Alert", message:"\(error)", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default)
                    alert.addAction(ok)
                    DispatchQueue.main.async {
                        self.vc.present(alert, animated: true, completion: nil)
                    }
                }
                
            case .success(let responseData):
                
                do {
                    let str = String(decoding: responseData, as: UTF8.self)
                    if let data = str.data(using: .utf8) {
                        let jsonDecoder = JSONDecoder()
                        /// Converting response to our custom model
                        let responseModel = try jsonDecoder.decode(MainJson.self, from: data)
                        if let rows = responseModel.rows {
                            self.rowsArray = rows
                        }
                        /// reloading the table view and updating the navigation title
                        DispatchQueue.main.async {
                            self.vc.navTitle = responseModel.title ?? ""
                            self.vc.rowsTableView.reloadData()
                        }
                    }
                }
                catch(let error) {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
