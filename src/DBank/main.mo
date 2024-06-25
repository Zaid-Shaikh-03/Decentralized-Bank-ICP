import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";

actor DBank {
  stable var currentValue : Float = 10; //(we use var for varibel which going to change)
  //in starting we use stable mean we are going to use Orthogonal Persistance and it mean variable manage it state over many different cycles and updates.
  //Orthogonal Persistance:Being able to hold on  to state over many differnet cycles and updates.
  //currentValue := 20; //replace operator(currentValue = 20)
  stable var startTime = Time.now();
  let id = 83289479234; //(we use let for varibel which not going to change)

  //Debug.print(debug_show (id)); // to print variable we use Debug Module and Debug module we have print methode and print methode take text and for printng variable we  use debug_show methode it take variable name.

  public func topUp(amount : Float) {
    //if we change datatype variable loss its state.
    // to assign variable dataType variable: datatype
    currentValue += amount;
    Debug.print(debug_show (currentValue));
  };

  public func withdraw(amount : Float) {
    let tempValue : Float = currentValue - amount;

    if (tempValue >= 0) {
      currentValue -= amount;
      Debug.print(debug_show (currentValue));
    } else {
      Debug.print("Please Enter Right Amount");
    };
  };

  public query func checkBalance() : async Float {
    return currentValue;
  };

  // topUp();

  // Debug.print(debug_show (startTime));

  public func compound() {
    let currentTime = Time.now();
    let timeElapsedNS = currentTime - startTime;
    // Debug.print(debug_show (currentTime));
    let timeElapsedS = Float.fromInt(timeElapsedNS) / 1000_000_000.0;
    currentValue *= (1.01 ** timeElapsedS); //we cannot convert  Nat into Float.
    startTime := currentTime;
  };

};

// to get canister UI id (dfx canister id __Candid_UI)
//http://127.0.0.1:8000/?canisterId=<Canister_id>
//After
//dfx canister id DBank
