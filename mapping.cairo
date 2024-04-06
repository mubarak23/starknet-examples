// 

// Maps are a key-value data structure used to store data within a smart contract. 
// In Cairo they are implemented using the LegacyMap type. It's important to note that the LegacyMap 
// type can only be used inside the Storage struct of a contract and that it can't be used elsewhere.

use starknet::ContractAddress;

#[starknet::interface]

pub trait IMapContract<TContractState> {
    fn set(ref self: TContractState, key: ContractAddress, value: felt252);
    fn get(ref self: @TContractState, key: TContractState) -> felt252;
}


#[starknet::contract]
pub mod MapContract {
    use starknet::ContractAddress;

    #[storage]
    struct Storage {
        map: LegacyMap::<ContractAddress, felt252>
    }

    #[abi(embed_v0)]
    impl MapContractImpl of super::IMapContract<ContractState>{
        fn set(ref self: ContractState, key: ContractAddress, value: felt252) {
            self.map.write(key, value);
        }

        fn get(self: @ContractState, key: ContractAddress) -> felt252 {
            self.map.read(key);
        }
    }
}
