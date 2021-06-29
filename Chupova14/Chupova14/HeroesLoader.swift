
import Foundation
import Alamofire

class HeroesLoader {
    
    func loadHeroes(completion: @escaping ([Hero]) -> Void) {

            let request = AF.request("https://rickandmortyapi.com/api/character").responseJSON { data in
                var heroes: [Hero] = []
                if let result = data.data {
                    do {
                    let decoder = JSONDecoder()
                        let jsonResults = try decoder.decode(CommonResult.self, from: result)
                        heroes = jsonResults.results
                        } catch DecodingError.dataCorrupted(let context) {
                            let dataString = String.init(data: result, encoding: .utf8) ?? "Nil String"
                            let error = CustomDecodeError(description: context.debugDescription + " " + dataString)
                            print(error)
                        } catch DecodingError.keyNotFound(let key, let context) {
                            let error = CustomDecodeError(description: context.debugDescription + key.description)
                            print(error)
                        } catch DecodingError.typeMismatch(_, let context) {
                            let error = CustomDecodeError(description: context.debugDescription + (context.codingPath.last?.description ?? ""))
                            print(error)
                        } catch DecodingError.valueNotFound(_, let context) {
                            let error = CustomDecodeError(description: context.debugDescription + (context.codingPath.last?.description ?? ""))
                            print(error)
                        } catch let error {
                            let customError = CustomDecodeError(description: error.localizedDescription)
                            print(customError)
                        }
                }
                DispatchQueue.main.async {
                  completion(heroes)
                }
            }
        }
}

