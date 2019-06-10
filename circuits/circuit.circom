include "../circomlib/circuits/mimc.circom";

// Hash 2 inputs
template Hash2() {
    signal private input a;
    signal private input b;
    signal output out;

    component m = MultiMiMC7(2, 91);
    m.in[0] <== a;
    m.in[1] <== b;
    m.out ==> out;
}

component main = Hash2();
