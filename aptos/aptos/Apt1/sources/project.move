module MyModule::TaskBoard {

    use aptos_framework::signer;
    use aptos_framework::coin;
    use aptos_framework::aptos_coin::AptosCoin;

    /// Struct representing a task in the board.
    struct Task has store, key {
        reward: u64,  // Reward for completing the task
        is_completed: bool,  // Task completion status
    }

    /// Function to create a new task with a reward.
    public fun create_task(owner: &signer, reward: u64) {
        let task = Task {
            reward,
            is_completed: false,
        };
        move_to(owner, task);
    }
}
