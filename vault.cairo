pub mod VaultErrors {
    pub const INSUFFICIENT_BALANCE: felt252 = 'insufficient_balance';
}

#[starknet::interface]
pub trait IVaultErrorsExample<trait <TContractState> {
   fn deposit( ref self: TContractState, amount: u256);
   fn withdraw( ref self: TContractState, amount: u256);
}

#[starknet::contract]
pub mod VaultErrorsExample {
    use super::VaultErrors;

    #[storage]
    struct Storage {
        balance : u256,
    }

    #[abi(embed_v0)]
    impl VaultErrorsExample of super::IVaultErrorsExample<ContractState> {
        fn deposit (ref self: ContractState, amount: u256) {
            let mut balance = self.balance.read();
            balance = balance + amount;
            self.balance.write(balance)
        }
        fn withdraw (ref self: ContractState, amount: u256) {
            let mut balance = self.balance.read();

           //  assert(balance >= amount, VaultErrors::INSUFFICIENT_BALANCE);

           if (balance >= amount) {
                core::panic_with_felt252(VaultErrors::INSUFFICIENT_BALANCE);
           }

           let balance = balance - amount;

           self.balance.write(balance);
        }
    }
}