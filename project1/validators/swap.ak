use aiken/hash.{Blake2b_224, Hash}
use aiken/list
use aiken/transaction.{
  OutputReference, ScriptContext, Spend, Transaction, TransactionId,
}
use aiken/transaction/credential.{VerificationKey}
 
type Datum {
  owner: Hash<Blake2b_224, VerificationKey>,
  beneficiary: Hash<Blake2b_224, VerificationKey>,
}
 
type Redeemer {
  msg: ByteArray,
}
 
validator {
 fn simple_lock(
    datum: Datum,
    redeemer: Redeemer,
    context: ScriptContext,
 ) -> Bool {
    let is_claim_request = redeemer.msg == "Claim Request"

    let is_signed_by_owner = must_be_signed_by(context.transaction, datum.owner)
    let is_signed_by_beneficiary = must_be_signed_by(context.transaction, datum.beneficiary)

    is_claim_request && is_signed_by_owner && is_signed_by_beneficiary
 }
}
 
fn must_be_signed_by(
 transaction: Transaction,
 vk: Hash<Blake2b_224, VerificationKey>,
) -> Bool {
 list.any(transaction.extra_signatories, fn(vk_in_list) { vk_in_list == vk })
}

test test_simple_lock_success() {
 let datum =
    Datum {
      owner: #[0,1,2,3],
      beneficiary: #[4,5,6,7],
    }
 
 let redeemer = Redeemer { msg: "Claim Request" }
 
 let placeholder_utxo =
    OutputReference { transaction_id: TransactionId(""), output_index: 0 }
 
 let test_purpose = Spend(placeholder_utxo)
 let transaction =
    transaction.placeholder()
      |> fn(transaction) {
           Transaction { ..transaction, extra_signatories: [datum.owner, datum.beneficiary] }
         }
 
 let context = ScriptContext { purpose: test_purpose, transaction }
 
 simple_lock(datum, redeemer, context)
}

test test_simple_lock_failer() {
 let datum =
    Datum {
      owner: #[0,1,2,3],
      beneficiary: #[4,5,6,7],
    }
 
 let redeemer = Redeemer { msg: "Claim Request" }
 
 let placeholder_utxo =
    OutputReference { transaction_id: TransactionId(""), output_index: 0 }
 
 let test_purpose = Spend(placeholder_utxo)
 let transaction =
    transaction.placeholder()
      |> fn(transaction) {
           Transaction { ..transaction, extra_signatories: [datum.owner] }
         }
 
 let context = ScriptContext { purpose: test_purpose, transaction }
 
 simple_lock(datum, redeemer, context)
}


// use aiken/hash.{Blake2b_224, Hash}
// use aiken/list
// use aiken/transaction.{
//   OutputReference, ScriptContext, Spend, Transaction, TransactionId,
// }
// use aiken/transaction/credential.{VerificationKey}
 
// type Datum {
//   owner: Hash<Blake2b_224, VerificationKey>,
//   beneficiary: Hash<Blake2b_224, VerificationKey>,
// }
 
// type Redeemer {
//   msg: ByteArray,
// }
 
// validator {
//  fn simple_lock(
//     datum: Datum,
//     redeemer: Redeemer,
//     context: ScriptContext,
//  ) -> Bool {
//     let is_claim_request = redeemer.msg == "Claim Request"

//     let is_signed_by_owner = must_be_signed_by(context.transaction, datum.owner)
//     let is_signed_by_beneficiary = must_be_signed_by(context.transaction, datum.beneficiary)

//     is_claim_request && is_signed_by_owner && is_signed_by_beneficiary
//  }
// }
 
// fn must_be_signed_by(
//  transaction: Transaction,
//  vk: Hash<Blake2b_224, VerificationKey>,
// ) -> Bool {
//  list.any(transaction.extra_signatories, fn(vk_in_list) { vk_in_list == vk })
// }

// test test_simple_lock_success() {
//  let datum =
//     Datum {
//       owner: #[0,1,2,3],
//       beneficiary: #[4,5,6,7],
//     }
 
//  let redeemer = Redeemer { msg: "Claim Request" }
 
//  let placeholder_utxo =
//     OutputReference { transaction_id: TransactionId(""), output_index: 0 }
 
//  let test_purpose = Spend(placeholder_utxo)
//  let transaction =
//     transaction.placeholder()
//       |> fn(transaction) {
//            Transaction { ..transaction, extra_signatories: [datum.owner, datum.beneficiary] }
//          }
 
//  let context = ScriptContext { purpose: test_purpose, transaction }
 
//  simple_lock(datum, redeemer, context)
// }

// test test_simple_lock_failer() {
//  let datum =
//     Datum {
//       owner: #[0,1,2,3],
//       beneficiary: #[4,5,6,7],
//     }
 
//  let redeemer = Redeemer { msg: "Claim Request" }
 
//  let placeholder_utxo =
//     OutputReference { transaction_id: TransactionId(""), output_index: 0 }
 
//  let test_purpose = Spend(placeholder_utxo)
//  let transaction =
//     transaction.placeholder()
//       |> fn(transaction) {
//            Transaction { ..transaction, extra_signatories: [datum.owner] }
//          }
 
//  let context = ScriptContext { purpose: test_purpose, transaction }
 
//  simple_lock(datum, redeemer, context)
// }




