import Foundation

class DietService {
    
    static let shared = DietService() // Singleton para uso global
    
    private init() {}
    
    func fetchDiets(userId: Int, completion: @escaping (Result<[Diet], Error>) -> Void) {
        guard let url = URL(string: "http://localhost:3000/diets/user/\(userId)") else {
            print("URL inválida")
            completion(.failure(NSError(domain: "URL inválida", code: -1, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            if let data = data {
                do {
                    let decodedDiets = try JSONDecoder().decode([Diet].self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(decodedDiets))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
        }.resume()
    }
}
