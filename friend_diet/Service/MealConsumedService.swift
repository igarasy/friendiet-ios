import Foundation

class MealConsumedService {
    
    func fetchMealsConsumed(for userId: Int, completion: @escaping (Result<[MealConsumed], Error>) -> Void) {
        let urlString = "http://localhost:3000/meals-consumed/user/\(userId)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(error))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let isoDateFormatter = ISO8601DateFormatter()
                isoDateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
                decoder.dateDecodingStrategy = .custom { decoder in
                    let container = try decoder.singleValueContainer()
                    let dateString = try container.decode(String.self)
                    
                    if let date = isoDateFormatter.date(from: dateString) {
                        return date
                    } else {
                        throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date format: \(dateString)")
                    }
                }
                
                let mealsConsumed = try decoder.decode([MealConsumed].self, from: data)
                completion(.success(mealsConsumed))
            } catch let decodingError as DecodingError {
                // Tratar erro de decodificação
                switch decodingError {
                case .dataCorrupted(let context):
                    print("Data corrupted: \(context.debugDescription)")
                case .keyNotFound(let key, let context):
                    print("Key '\(key)' not found: \(context.debugDescription), codingPath: \(context.codingPath)")
                case .typeMismatch(let type, let context):
                    print("Type '\(type)' mismatch: \(context.debugDescription), codingPath: \(context.codingPath)")
                case .valueNotFound(let value, let context):
                    print("Value '\(value)' not found: \(context.debugDescription), codingPath: \(context.codingPath)")
                default:
                    print("Decoding error: \(decodingError.localizedDescription)")
                }
                completion(.failure(decodingError))
            } catch {
                print("Erro desconhecido: \(error.localizedDescription)")
                completion(.failure(error))
            }

        }
        
        task.resume()
    }
}
