import Array "mo:base/Array";

actor games {

  type game = {
    username:Text;
    title: Text;
    genre: Nat;
    rating: Nat;
  };

  var games  : [game] = [];

  public func addgame(rating: Nat, title : Text, genre : Nat, username : Text) : async  Bool {
    let newusergame = Array.size(games) + 1;
    let newgame = {
      username = username;
      title = title;
      genre = genre;
      rating = rating;
    };
    games := Array.append<game>(games, [newgame]);
    return true;
  };

  public func getAllgames() : async  [game] {
    return games;
  };

  public func getgameByusername(username: Text) : async ?game {
    return Array.find<game>(games, func(g) {g.username == username});
  };

  public func updategame(username : Text, title : Text, rating : Nat, genre : Nat) :async Bool {
    let gameToUpdate = Array.find<game>(games, func(game) { game.username == username});

    switch(gameToUpdate) {
      case(null) { return false };
      case(?gameToUpdate) {
        let updatedgame = {
          username = username;
          title = title ;
          rating = rating;
          genre = genre;
        };
        games := Array.map<game, game>(games, func(g) { if (g.username == username) { updatedgame } else { g } });
        return true;
      };
    };
  };

  public func deletegame(username : Text) : async Bool {
    let game = Array.find<game>(games, func(game) { game.username == username});
    if (game != null) {
      games := Array.filter<game>(games, func (game) {game.username != username});
      return true;
    } else {
      return false;
    };
  };
};