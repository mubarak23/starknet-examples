// https://starknet-by-example.voyager.online/ch00/basics/variables.html

// Local variables are used and accessed within the scope of a specific function or block of code. 
// They are temporary and exist only for the duration of that particular function or block execution.

#[starknet::interface]

pub trait ILocalVariablesExample<TContractState> {
    fn do_something(self: @TContractState, value: u32) -> u32; 
}

#[starknet::contract]
pub mod LocalVariablesExample {
    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl LocalVariablesExample of super::ILocalVariablesExample<ContractState> {
        fn do_something(self: @ContractState, value: u32) -> u32 {
            let increment = 24;
            {
                let sum = value + increment;
                sum 
            }
        }
    }
}
