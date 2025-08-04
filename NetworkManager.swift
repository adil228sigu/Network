import UIKit


class NetworkManager {
    static let shared = NetworkManager()
    
    func getCurrencies(completion: @escaping ([CharacterModel]) -> ()) {
        let url = URL(string: "https://thronesapi.com/api/v2/Characters")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error {
                print(error)
            }
            
            guard let data else { return }
            
            let decoder = JSONDecoder()
            
            do {
                let currencies = try decoder.decode([CharacterModel].self, from: data)
                completion(currencies)
            } catch {
                print(error)
            }
            
        }.resume()
    }
    
}
