#[starknet::interface]
pub trait IMessage<TContractState> {
    fn append(ref self: TContractState, str: ByteArray);
    fn prepend(ref self: TContractState, str: ByteArray);
}

#[starknet::contract]
pub mod MessageContract {
    
    #[storage]
    Struct Storage {
        message: ByteArray
    }

    #[constructor]
    fn contructor(ref self: ContractState) {
        self.message.write("Hello Mubarak");
    }

    #[abi(embed_v0)]
    impl MessageContract of super::IMessage<ContractState> {
        fn append(ref self: ContractState, str: ByteArray){
            self.message.write(self.message.read() + str);
        }
        fn prepend(ref self: ContractState, str: ByteArray) {
            self.message.write(str + self.message.read());
        }
    }
}
