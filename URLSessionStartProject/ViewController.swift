//
//  ViewController.swift
//  URLSessionStartProject
//
//  Created by Alexey Pavlov on 29.11.2021.
//

import UIKit
import CryptoKit

class ViewController: UIViewController {

    private let endpointClient = EndpointClient(applicationSettings: ApplicationSettingsService())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        executeCall()
    }
    
    func executeCall() {
        let endpoint = GetNameEndpoint()
        let completion: EndpointClient.ObjectEndpointCompletion<String> = { result, response in
            guard let responseUnwrapped = response else { return }

            print("\n\n response = \(responseUnwrapped.allHeaderFields) ;\n \(responseUnwrapped.statusCode) \n")
            switch result {
            case .success(let team):
                print("team = \(team)")
                
            case .failure(let error):
                print(error)
            }
        }
        endpointClient.executeRequest(endpoint, completion: completion)
    }
}

final class GetNameEndpoint: ObjectResponseEndpoint<String> {
    
    let publicKey = "5e89433b3d4a0dd170543ab353c8e33d"
    let privateKey = "f6a80a375b637fd8ef9d948f44d8cc56d08fcbfb"
    let ts = NSDate().timeIntervalSinceReferenceDate
    let hash: String = ""
    
    override var method: RESTClient.RequestType { return .get }
    override var path: String { "/v1/public/characters" }
    // override var path: String { "/v1/cards" }
    // override var queryItems: [URLQueryItem(name: "id", value: "1")]?
    
    override init() {
        super.init()

//        queryItems = [URLQueryItem(name: "name", value: "Black Lotus")]
        queryItems = [URLQueryItem(name: "name", value: "Spider-Man"),
                      URLQueryItem(name: "ts", value: "\(ts)"),
                      URLQueryItem(name: "apikey", value: publicKey),
                      URLQueryItem(name: "hash", value: hash.md5(string: "\(ts)" + privateKey + publicKey))]
    }
    
}











func decodeJSONOld() {
    let str = """
        {\"team\": [\"ios\", \"android\", \"backend\"]}
    """
    
    let data = Data(str.utf8)

    do {
        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            if let names = json["team"] as? [String] {
                print(names)
            }
        }
    } catch let error as NSError {
        print("Failed to load: \(error.localizedDescription)")
    }
}

