// Global variables are predefined variables that provide information about the blockchain and the current 
// execution environment. They can be accessed at any time and from anywhere!

// In Starknet, you can access global variables by using specific functions contained in the starknet core libraries.

#[starknet::interface]
pub trait IGlobalExample<trait <TContractState> {
   fn foo(ref self: TContractState);
}

#[starknet::contract]
pub mod GlobalExample {
    
    use starknet::get_caller_address;

    #[storage]
    struct Storage{}

    #[abi(embed_v0)]
    impl GlobalExampleImpl of super::IGlobalExample<ContractState> {
        fn foo(ref self: ContractState) {
            // Call the get_caller_address function to get the sender address
            let _caller = get_caller_address();
        }
    }
}

// get_caller_address function returns the address of the caller of the current transaction, 
// and the get_contract_address function returns the address of the current contract.
