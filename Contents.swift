//1. შევქმნათ Class-ი SuperEnemy with properties: String name, Int hitPoints (ანუ სიცოცხლის რაოდენობა).
//სურვილისამებრ დაამატებ properties რომელიც მას აღწერს.

class SuperEnemy {
    var name: String
    var hitPoints: Int
    
    init(name: String, hitPoints: Int){
        self.name = name
        self.hitPoints = hitPoints
    }
}

//2. შევქმნათ Superhero Protocol-ი.
//შემდეგი get only properties: String name, String alias, Bool isEvil და დიქშენარი (dictionary) superPowers [String: Int], სადაც String-ი არის სახელი და Int არის დაზიანება (damage).
//Method attack, რომელიც მიიღებს target SuperEnemy-ის და დააბრუნებს (return) Int-ს ანუ დარჩენილ სიცოცხლე.
//Method performSuperPower, რომელიც მიიღებს SuperEnemy-ის და დააბრუნებს (return) Int-ს, აქაც დარჩენილ სიცოცხლე.

protocol SuperHero {
    var name: String { get }
    var alias: String { get }
    var isEvil: Bool { get }
    var superPowers: [String: Int] { get set }
    
    func attack(target: SuperEnemy) -> Int
    
    mutating func performSuperPower(superEnemy: SuperEnemy) -> Int
}

// 3. Superhero-ს extension-ი გავაკეთოთ სადაც შევქმნით method-ს რომელიც დაგვი-print-ავს ინფორმაციას სუპერ გმირზე და მის დარჩენილ superPower-ებზე.

extension SuperHero {
    func informationAboutSuperHero() {
        print(self.name, self.alias, self.isEvil, self.superPowers)
    }
    
    mutating func performSuperPower(superEnemy: SuperEnemy) -> Int {
        if let superPower = superPowers.randomElement() {
            print("Using super power \(superPower.key)")
            superEnemy.hitPoints -= superPower.value
            print("Damaging enemy by \(superPower.value) points")
            superPowers.removeValue(forKey: superPower.key)
        }
        return superEnemy.hitPoints
    }
    
    func attack(target: SuperEnemy) -> Int {
        var damage = Int.random(in: 20...40)
        target.hitPoints -= damage
        return target.hitPoints
    }
}

//4. შევქმნათ რამოდენიმე სუპერგმირი Struct-ი რომელიც ჩვენს Superhero protocol-ს დააიმპლემენტირებს მაგ:
//struct SpiderMan: Superhero და ავღწეროთ protocol-ში არსებული ცვლადები და მეთოდები.
//attack მეთოდში -> 20-იდან 40-ამდე დავაგენერიროთ Int-ის რიცხვი და ეს დაგენერებული damage დავაკლოთ SuperEnemy-ს სიცოცხლეს და დარჩენილი სიცოცხლე დავაბრუნოთ( return).
//performSuperPower-ს შემთხვევაში -> დიქშენერიდან ერთ superPower-ს ვიღებთ და ვაკლებთ enemy-ს (სიცოცხლეს ვაკლებთ). ვშლით ამ დიქშენერიდან გამოყენებულ superPower-ს. გამოყენებული superPower-ი უნდა იყოს დარანდომებული. დარჩენილ enemy-ს სიცოცხლეს ვაბრუნებთ (return).

 struct IronMan: SuperHero {
    var name: String
    var alias: String
    var isEvil: Bool
    var superPowers: [String : Int]
}

struct SpiderMan: SuperHero {
    var name: String
    var alias: String
    var isEvil: Bool
    var superPowers: [String : Int]
}

struct Thanos: SuperHero {
    var name: String
    var alias: String
    var isEvil: Bool
    var superPowers: [String : Int]
}

//5. შევქმნათ class SuperherSquad,
//რომელიც ჯენერიკ Superhero-s მიიღებს. მაგ: class SuperheroSquad<T: Superhero>.
//შევქმნათ array სუპერგმირების var superheroes: [T].
//შევქმნათ init-ი.
//შევქმნათ method რომელიც ჩამოგვითვლის სქვადში არსებულ სუპერგმირებს.

class SuperHeroSquad {
    var superHeroes: [SuperHero]
    
    init(superHeros: [SuperHero]) {
        self.superHeroes = superHeros
    }
    
    func superHeroNames() -> [String] {
        return superHeroes.map({ $0.name })
    }
}

//6.ამ ყველაფრის მერე მოვაწყოთ ერთი ბრძოლა. 🤺🤜🏻🤛🏻
//შევქმნათ method simulateShowdown. ეს method იღებს სუპერგმირების სქვადს და იღებს SuperEnemy-ს.
//სანამ ჩვენი super enemy არ მოკვდება, ან კიდევ სანამ ჩვენ სუპერგმირებს არ დაუმთავრდებათ სუპერ შესაძლებლობები გავმართოთ ბრძოლა.
//ჩვენმა სუპერ გმირებმა რანდომად შეასრულონ superPowers, ყოველი შესრულებული superPowers-ი იშლება ამ გმირის ლისტიდან. თუ გმირს დაუმთავრდა superPowers, მას აქვს ბოლო 1 ჩვეულებრივი attack-ის განხორციელება (ამ attack განხორიციელება მხოლოდ ერთხელ შეუძლია როცა superPowers უმთავრდება).

func simulateShowdown(superHeroSquad: SuperHeroSquad, superEenemy: SuperEnemy) {
    for var hero in superHeroSquad.superHeroes {
        print("Super hero \(hero.name) is fighting against enemy")
        print("Super enemy points 🥊🚀🤺🤜🏻🤛🏻 : \(superEenemy.hitPoints)")
        
        while hero.superPowers.count > 0 {
            let superEenemyPointNow = hero.performSuperPower(superEnemy: superEenemy)

            if superEenemyPointNow <= 0 {
                print("")
                print ("Super heroes win!! \(superHeroSquad.superHeroNames()) 🏅🦸‍♀️🦸🦸‍♂️🌠🎇🎇🎇🎇")
                return
            }
            
            print("")
        }
        
        let superEenemyPointNow = hero.attack(target: superEenemy)
        
        if superEenemyPointNow <= 0 {
            print("")
            print ("Super heroes win!! \(superHeroSquad.superHeroNames()) 🏅🦸‍♀️🦸🦸‍♂️🌠🎇🎇🎇🎇")
            return
        }
    }
    
    print("")
    print("Super enemy win!! 🥊🥊 \(superEenemy.name)")
}

var ironMan = IronMan(name: "Ironman", alias: "Ironman", isEvil: false, superPowers: ["Shooting": 50, "Beating": 100])
var spiderMan = SpiderMan(name: "Spiderman", alias: "Spiderman", isEvil: false, superPowers: ["Shooting fires": 50])
var thanos = Thanos(name: "Thanos", alias: "Thanos", isEvil: true, superPowers: ["Shooting fires" : 50, "Beating": 100])

let superHeros: [SuperHero] = [ironMan, spiderMan, thanos]

var superHeroSquad = SuperHeroSquad(superHeros: superHeros)
var superEnemy = SuperEnemy(name: "Chaos", hitPoints: 300)

simulateShowdown(superHeroSquad: superHeroSquad, superEenemy: superEnemy)

