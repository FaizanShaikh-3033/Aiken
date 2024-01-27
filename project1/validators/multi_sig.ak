// use aiken/bytearray 
// use aiken/hash.{Blake2b_224,Hash}
// use aiken/list
// use aiken/string
// use aiken/transaction.{ScriptContext}
// use aiken/transaction/credential.{VerificationKey}

// pub type Datum {
//    owner: Hash<Blake2b_224, VerificationKey>
// }

// pub type Redeemer {
//     msg: ByteArray,
// }

// fn validate_redeemer_msg(msg: ByteArray) -> Bool {
//     string.from_bytearray(msg) == "Hello, World!"
// }

// fn validate_signer(
//     extra_signatories: List<Hash<Blake2b_224, VerificationKey>>,
//     owner: Hash<Blake2b_224, VerificationKey>,
// ) -> Bool {
//     extra_signatories
//     |> list.any(fn(vk) {vk == owner})
// }

// pub fn spend(datum: Datum, redeemer: Redeemer, context: ScriptContext) -> Bool {
//     let must_say_hello = validate_redeemer_msg(redeemer.msg)
//     let must_be_signed = 
//         validate_signer(context.transaction.extra_signatories, datum.owner)
//     must_say_hello && must_be_signed
// }

// test test_validate_redeemer_msg_success(){
//     validate_redeemer_msg(bytearray.from_string("Hello, World"))
// }

// test test_validate_redeemer_msg_failer(){
//     validate_redeemer_msg(bytearray.from_string("Hello, People"))
// }

// test test_validate_signer_success(){
//     let owner = #[0,1,2,3]
//     validate_signer([owner],owner)
// }

// test test_validate_signer_failer(){
//     let owner = #[0,1,2,3]
//     validate_signer([#[0,0,0,0],owner])
// }