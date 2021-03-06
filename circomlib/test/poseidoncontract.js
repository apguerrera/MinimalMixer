const TestRPC = require("ganache-cli");
const Web3 = require("web3");
const chai = require("chai");
const poseidonGenContract = require("../src/poseidon_gencontract.js");
const Poseidon = require("../src/poseidon.js");
const bigInt = require("snarkjs").bigInt;

const assert = chai.assert;
const log = (msg) => { if (process.env.MOCHA_VERBOSE) console.log(msg); };

const SEED = "mimc";

describe("Poseidon Smart contract test", () => {
    let testrpc;
    let web3;
    let mimc;
    let accounts;

    before(async () => {
        testrpc = TestRPC.server({
            ws: true,
            gasLimit: 5800000,
            total_accounts: 10,
        });

        testrpc.listen(8546, "127.0.0.1");

        web3 = new Web3("ws://127.0.0.1:8546");
        accounts = await web3.eth.getAccounts();
    });

    after(async () => testrpc.close());

    it("Should deploy the contract", async () => {
        const C = new web3.eth.Contract(poseidonGenContract.abi);

        mimc = await C.deploy({
            data: poseidonGenContract.createCode()
        }).send({
            gas: 2500000,
            from: accounts[0]
        });
    });

    it("Shold calculate the mimic correctly", async () => {

        const res = await mimc.methods.poseidon([1,2]).call();

        // console.log("Cir: " + bigInt(res.toString(16)).toString(16));

        const hash = Poseidon.createHash(6, 8, 57);

        const res2 = hash([1,2]);
        // console.log("Ref: " + bigInt(res2).toString(16));

        assert.equal(res.toString(), res2.toString());
    });
});

