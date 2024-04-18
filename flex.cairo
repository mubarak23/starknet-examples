# UsernameStore contract to store usernames on-chain

# Define event for UserCreated and UserTransferred
event UserCreated(user: felt252, address: felt252)
event UserTransferred(user: felt252, from: felt252, to: felt252)

# Define UsernameStore contract
contract UsernameStore:

    # Define state variables
    usernames: [felt252] felt252
    userAddresses: felt252[]
    ownerOf: felt252[num]
    userCount: felt252 = 0

    # Function to claim a username
    # Only callable if username is not already claimed
    # Emits UserCreated event
    define public claimUsername(username: felt252, userAddress: felt252):
        # Ensure username is not already claimed
        require usernames[username] == felt252, "Username already claimed"
        
        # Store the username and associated address
        usernames[username] = userAddress
        userAddresses[userCount] = userAddress
        ownerOf[userCount] = username
        userCount = userCount + 1
        
        # Emit UserCreated event
        emit UserCreated(username, userAddress)

    # Function to transfer username ownership
    # Only callable by the current owner of the username
    # Emits UserTransferred event
    define public transferUsername(username: felt252, toAddress: felt252):
        # Ensure the sender is the owner of the username
        require msg.sender == usernames[username], "You are not the owner of this username"
        
        # Update the username's address
        usernames[username] = toAddress
        
        # Emit UserTransferred event
        emit UserTransferred(username, msg.sender, toAddress)
