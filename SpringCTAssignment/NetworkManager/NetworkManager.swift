//
//  NetworkManager.swift
//  SpringCTAssignment
//
//  Created by Moumita Paul Ghosh on 21/06/24.
//

import Foundation
import Combine

class NetworkManager {
    
    private var cancellables = Set<AnyCancellable>()
    private let baseURL = "https://reqres.in/api/"
    
    
    static let shared = NetworkManager()
    
    private init() {
        
    }
        
    func getData<T: Decodable>(endpoint: String, parameters: [String: Any]?, type: T.Type) -> Future< T, Error> {
        return Future< T, Error> { [weak self] promise in
            
            guard let self = self, let url = URL(string: self.baseURL.appending(endpoint)) else {
                return promise(.failure(NetworkError.invalidURL))
            }
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            let encoder = JSONEncoder()
            if parameters != nil {
                if let parameter = parameters {
                    if !parameter.isEmpty {
                        request.httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: [])
                    }
                }
            }
            
            
            print("URL is \(url.absoluteString)")
            URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                        throw NetworkError.responseError
                    }
                    return data
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { (completion) in
                    if case let .failure(error) = completion {
                        switch error {
                        case let decodingError as DecodingError:
                            promise(.failure(decodingError))
                        case let apiError as NetworkError:
                            promise(.failure(apiError))
                        default:
                            promise(.failure(NetworkError.unknown))
                        }
                    }
                }, receiveValue: {
                    
                    promise(.success($0))
                })
                .store(in: &self.cancellables)
        }
    }
  
}
enum NetworkError: Error {
    case invalidURL
    case responseError
    case unknown
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "Invalid URL")
        case .responseError:
            return NSLocalizedString("Unexpected status code", comment: "Invalid response")
        case .unknown:
            return NSLocalizedString("Unknown error", comment: "Unknown error")
        }
    }
}
