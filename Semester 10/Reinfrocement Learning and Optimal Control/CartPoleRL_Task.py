import gym
import numpy as np
import math
import matplotlib.pyplot as plt


env = gym.make('CartPole-v1')


Q_table = np.zeros([3334, 2], dtype=object)
epsilon = 0.05
alpha = 0.1
gamma = 0.9
print(env.reset())

reward_plot = np.zeros([500, 1])
x_plot = np.linspace(1, 500, 500)

print(x_plot)
def getSegments(observation):
    segments = np.zeros([1, 4])

    if -4.8 <= observation[0] < -2.4:
        segments[:, 0] = 0
    elif -2.4 <= observation[0] < 0:
        segments[:, 0] = 1
    elif 0 <= observation[0] < 2.4:
        segments[:, 0] = 2
    elif 2.4 <= observation[0] <= 4.8:
        segments[:, 0] = 3

    if -math.inf <= observation[1] < -1:
        segments[:, 1] = 0
    elif -1 <= observation[1] < 0:
        segments[:, 1] = 1
    elif 0 <= observation[1] < 1:
        segments[:, 1] = 2
    elif 1 <= observation[1] <= math.inf:
        segments[:, 1] = 3

    if -0.418 <= observation[2] < -0.209:
        segments[:, 2] = 0
    elif -0.209 <= observation[2] < 0:
        segments[:, 2] = 1
    elif 0 <= observation[2] < 0.209:
        segments[:, 2] = 2
    elif 0.209 <= observation[2] <= 0.418:
        segments[:, 2] = 3

    if -math.inf <= observation[3] < -0.1:
        segments[:, 3] = 0
    elif -0.1 <= observation[3] < 0:
        segments[:, 3] = 1
    elif 0 <= observation[3] < 0.1:
        segments[:, 3] = 2
    elif 0.1 <= observation[3] <= math.inf:
        segments[:, 3] = 3

    sum = 0
    x = 1
    for i in range(4):
        sum = sum + segments[0, i]*x
        x *= 10

    return segments, int(sum)


if __name__ == '__main__':
    obs, info = env.reset()
    observation, sum = getSegments(obs)
    print(observation)
    print(sum)
    for i in range(500):  # Sample loop (Main loop)

        obs, info = env.reset()
        observation, sum = getSegments(obs)
        current_state = int(sum)
        done = False

        # sum the rewards that the agent gets from the environment
        total_episode_reward = 0

        for j in range(500):
            if np.random.uniform(0, 1) < epsilon:
                action = env.action_space.sample()
            else:
                action = np.argmax(Q_table[current_state, :])

            next_state, reward, terminated, truncated, info = env.step(action)

            observation, state = getSegments(next_state)
            next_state = state

            # We update our Q-table using the Q-learning iteration
            Q_table[current_state, action] = Q_table[current_state, action] + alpha * (
                    reward + gamma * max(Q_table[next_state, :]))

            total_episode_reward = total_episode_reward + reward

            # If the episode is finished, we leave the for loop
            if terminated or truncated:
                break
            current_state = next_state
        reward_plot[i, 0] = total_episode_reward
    plt.plot(x_plot, reward_plot)
    plt.show()
env.close()
