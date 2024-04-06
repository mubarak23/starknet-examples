#[starknet::interface]
pub trait ISimpleCounter<TContractState> {
   fn get_current_counter(self @TContractState) -> u128
   fn increment(ref self @TContractState);
   fn decrement(ref self @TContractState);
}


#[starknet::contract]
pub mod SimpleCounter{

    #[storage]
    struct storage {
        counter: u128
    }

    // this function get call once we deploy the contract
    #[constructor]
    fn constructor(ref self: ContractState, initial_value: u128){
        self.counter.write(initial_value);
    }

    #[abi(embed_v0)]
    impl SimpleCounter of super::ISimpleCounter<ContractState> {
        fn get_current_counter(self: @ContractState) -> u128 {
            return self.counter.read();
        }

        fn increment (ref self: ContractState) {
            let counter = self.counter.read() + 1;
            self.counter.write(counter);
        }

        fn decrement(ref self: ContractState) {
            let counter = self.counter.read() - 1;
            self.counter.write(counter);
        }
    }

}