//
//  APICaller.swift
//  Game Catalogue
//
//  Created by Edo Lorenza on 07/06/21.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
    struct Constants {
        static let baseAPIURL = "https://api.rawg.io/api"
        static let apiKey = "a662239b3bb84a80b734450de92c662c"
    }
    
    enum APIError: Error {
        case failedToGetData
    }
    
    //MARK: - Get List of Games
    public func getListOfFeed(urlPath: serviceUrlPath, completion: @escaping(Result<GamesResponse, Error>) -> Void){
        createRequest(with: URL(string: Constants.baseAPIURL+"/\(urlPath)?key="+Constants.apiKey), type: .GET) {
            baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else{
                    completion(.failure(APIError.failedToGetData))
                    return
                }
    
                do{
                    let result = try JSONDecoder().decode(GamesResponse.self, from: data)
                    completion(.success(result))
                }
                catch{
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    //MARK: - Get List Of Creator
    public func getListOfCreatorFeed(urlPath: serviceUrlPath, completion: @escaping(Result<CreatorResponse, Error>) -> Void){
        createRequest(with: URL(string: Constants.baseAPIURL+"/\(urlPath)?key="+Constants.apiKey), type: .GET) {
            baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else{
                    completion(.failure(APIError.failedToGetData))
                    return
                }
    
                do{
                    let result = try JSONDecoder().decode(CreatorResponse.self, from: data)
                    completion(.success(result))
                }
                catch{
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    
    //MARK: - Get List Of genres
    public func getListOfGenres(urlPath: serviceUrlPath, completion: @escaping(Result<[Creator], Error>) -> Void){
        createRequest(with: URL(string: Constants.baseAPIURL+"/\(urlPath)?key="+Constants.apiKey), type: .GET) {
            baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else{
                    completion(.failure(APIError.failedToGetData))
                    return
                }
    
                do{
                    let result = try JSONDecoder().decode(CreatorResponse.self, from: data)
                    completion(.success(result.results))
                }
                catch{
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    //MARK: - Get detail Of gamaes
    public func getDetailOfGame(game: Games, completion: @escaping(Result<Games, Error>) -> Void){
        createRequest(with: URL(string: Constants.baseAPIURL+"/games/\(game.id)?key="+Constants.apiKey), type: .GET) {
            baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else{
                    completion(.failure(APIError.failedToGetData))
                    return
                }
    
                do{
                    let result = try JSONDecoder().decode(Games.self, from: data)
//                    var gameResult: [Games] = []
//                    gameResult.append(contentsOf: result.results.compactMap({$0}))
                    completion(.success(result))
                }
                catch{
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    //MARK: - Private
    
    enum HTTPMethod: String{
        case GET
        case POST
        case DELETE
        case PUT
    }
    
    enum serviceUrlPath: String {
        case games
        case creators
        case developers
        case genres
    }
    
    private func createRequest(with url: URL?, type: HTTPMethod, completion: @escaping (URLRequest) -> Void){
   
            guard let apiURL = url else {
                return
            }
            var request = URLRequest(url: apiURL)
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
        }
    }
