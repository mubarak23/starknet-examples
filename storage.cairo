#[starknet::interface]


// Storage variables are persistent data stored on the blockchain. They can be accessed from one execution
//  to another, allowing the contract to remember and update information over time.

pub trait IStorageVariableExample<TContractState> {
    fn set(ref self: TContractState, value: u32);
    fn get(self: @TContractState)
}
#[starknet::contract]
pub mod StorageVariableExample {

    #[storage]
    struct  Storage {
       value : u32,
    }

    #[abi(embed_v0)]
    impl StorageVariableExample of super::IStorageVariableExample<ContractState> {
        // // Write to storage variables by sending a transaction that calls an external function
        fn set(ref self: ContractState, value: u32) {
            self.value.write(value);
        }
        // read from storage variable without sending transaction
        fn get(self: @ContractState) -> u32 {
            self.value.read()
        }
    }
}
