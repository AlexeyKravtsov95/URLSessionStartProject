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
        let completion: EndpointClient.ObjectEndpointCompletion<Card> = { result, response in
            guard let responseUnwrapped = response else { return }

            print("\n\n response = \(responseUnwrapped.allHeaderFields) ;\n \(responseUnwrapped.statusCode) \n")
            switch result {
            case .success(let card):
                for value in card.cards {
                    print("""
                             Имя карты: \(value.name ?? "")
                             Тип: \(value.type ?? "")
                             Подтип: \(value.subtypes ?? "")
                             Редкость:\(value.rarity ?? "")
                             Сила: \(value.power ?? "")
                        """)
                    
                }
                
            case .failure(let error):
                print(error)
            }
        }
        endpointClient.executeRequest(endpoint, completion: completion)
    }
}

final class GetNameEndpoint: ObjectResponseEndpoint<Card> {
    
    override var method: RESTClient.RequestType { return .get }
    override var path: String { "/v1/cards" }
    // override var queryItems: [URLQueryItem(name: "id", value: "1")]?
    
    override init() {
        super.init()

        queryItems = [URLQueryItem(name: "name", value: "Black Lotus")]
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
