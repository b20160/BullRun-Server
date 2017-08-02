import Vapor
extension Droplet {
    func setupRoutes() throws {
        
        
        post("balance") { req in
            
            guard let address = req.data["address"]?.string else {
                
                return Abort.badRequest.reason
            }
            let json = Ripple(drop:self).balance(address: address)
            
            return json
            
        }
        
        post("send") { req in
            
            guard let address1 = req.data["address1"]?.string else {
                
                return Abort.badRequest.reason
            }
            
            guard let address2 = req.data["address2"]?.string else {
                
                return Abort.badRequest.reason
            }
            
            guard let secret = req.data["secret"]?.string else {
                
                return Abort.badRequest.reason
            }
            
            guard let amount = req.data["amount"]?.string else {
                
                return Abort.badRequest.reason
            }
            
            let json = Ripple(drop:self).send(address1: address1, address2: address2, secret: secret, amount: amount)
            
            return json
            
        }
        
        get("newAddress") { req in
            
            let json = Ripple(drop: self).generateWallet()
        
            return json
        }
        
        get("hourRound") { req in 
            
            Schedule(drop: self).hourRound()
            
            return "Running Hour Round"
            
        }
        
        get("dailyRound") { req in
            
            Schedule(drop: self).dayRound()
            
            return "Running Day Round"
            
        }
        
        get("weekRound") { req in
            
            Schedule(drop: self).weekRound()
            
            return "Running week Round"
            
        }
        
        get("hello") { req in
            var json = JSON()
            try json.set("hello", "world")
            MongoClient()
            return json
        }

        get("plaintext") { req in
            return "Hello, world!"
        }

        // response to requests to /info domain
        // with a description of the request
        get("info") { req in
            return req.description
        }

        get("description") { req in return req.description }
        
        try resource("posts", PostController.self)
    }
}
