#[starknet::contract]

pub mod ExampleConstructor {
    use starknet::ContractAddress;

    #[storage]
    struct Storage {
        names: LegacyMap::<ContractAddress, felt252>,
    }

    #[constructor]
    fn constructor(ref self: ContractState, name: felt252, address: ContractAddress){
        self.names.write(address, name);
    }
}