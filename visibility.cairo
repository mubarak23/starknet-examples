#[starknet::interface]
pub trait IExampleContract<TContractState> {
    fn (ref self: TContractState, value: u32 );
    fn (self: @TContractState )
}

#[starknet::contract]
pub mode ExampleContractDemo {
    #[storage]
    struct Storage {
        value: u32
    }

    // The `abi(embed_v0)` attribute indicates that all the functions in this implementation can be called externally.
    // Omitting this attribute would make all the functions in this implementation internal.
    #[abi(embed_v0)]
    impl ExampleContractDemo of super::IExampleContract<ContractState> {
        fn set(ref self: ContractState, value: u32){
            self.value.write(value);
        }

        // The `get` function can be called externally because it is written inside an implementation marked as `#[external]`.
        // However, it can't modify the contract's state is passed as a snapshot: it is only a "view" function.
        fn get(ref self: ContractState) -> u32 {
             // We can call an internal function from any functions within the contract
            PrivateFunctionsTrait::_read_value(self)
        }
    }

    #[generate_trait]
    impl privatwFunction of PrivateFunctionsTrait {

        fn _read_value(self: @ContractState) -> u32 {
            self.value.read()
        }
    }

}