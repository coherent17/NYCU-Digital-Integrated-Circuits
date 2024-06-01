import numpy as np
from scipy.optimize import minimize
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# Constants (given values)
C_A = 20e-12
C_B = 30e-12
f_clk1 = 10e6
K_A = 11.4e-9
K_B = 18.3e-9
V_t = 0.3
T_clk1 = 100e-9
T_c2q = 0.5e-9
T_MUX = 0.4e-9

# Objective function to minimize power (in W, but we will convert it to µW later)
def objective(x):
    Vdd_A = x[0]
    Vdd_B = x[1]
    return (C_A * Vdd_A**2 + C_B * Vdd_B**2) * f_clk1

# Constraint function to ensure timing requirements
def constraint(x):
    Vdd_A = x[0]
    Vdd_B = x[1]
    return T_clk1 - T_c2q - T_MUX - (K_A / (Vdd_A - V_t) + K_B / (Vdd_B - V_t))

# Calculate an informed initial guess
T_avail = T_clk1 - T_c2q - T_MUX
initial_guess_vdd = (K_A + K_B) / T_avail + V_t

# Define the bounds for Vdd_A and Vdd_B to ensure they are above V_t
bounds = [(V_t + 1e-3, 0.9), (V_t + 1e-3, 0.9)]

# Sweep around the informed initial guess
sweep_range = np.linspace(initial_guess_vdd - 0.1, initial_guess_vdd + 0.1, 300)
best_initial_guesses = []

# Parameter sweep to find good initial guesses
for Vdd_A_init in sweep_range:
    for Vdd_B_init in sweep_range:
        if Vdd_A_init > V_t and Vdd_B_init > V_t:
            x0 = [Vdd_A_init, Vdd_B_init]
            con = {'type': 'ineq', 'fun': constraint}
            # Check if the initial guess is feasible
            if constraint(x0) >= 0:
                obj_value = objective(x0)
                best_initial_guesses.append((x0, obj_value))

# Sort the initial guesses based on the objective function value (ascending order)
best_initial_guesses.sort(key=lambda x: x[1])

# Select the top 10 initial guesses from the sorted list
top_initial_guesses = best_initial_guesses[:10]

# Perform the optimization for the top 10 initial guesses
best_solution = None
best_solution_value = float('inf')

for initial_guess in top_initial_guesses:
    x0 = initial_guess[0]
    final_solution = minimize(objective, x0, constraints={'type': 'ineq', 'fun': constraint}, bounds=bounds, method='SLSQP')
    if final_solution.success and final_solution.fun < best_solution_value:
        best_solution = final_solution
        best_solution_value = final_solution.fun

# Extract the best solution found
if best_solution is not None:
    Vdd_A_opt = best_solution.x[0]
    Vdd_B_opt = best_solution.x[1]
    P_min = best_solution.fun * 1e6  # Convert power to µW

    print(f'Optimal Vdd_A: {Vdd_A_opt:.4f} V')
    print(f'Optimal Vdd_B: {Vdd_B_opt:.4f} V')
    print(f'Minimized Power: {P_min:.4f} µW')
else:
    print("No feasible solution found.")

# Prepare data for 3D plotting
Vdd_A_vals = np.linspace(0.5, 0.7, 300)
Vdd_B_vals = np.linspace(0.5, 0.7, 300)
Vdd_A_grid, Vdd_B_grid = np.meshgrid(Vdd_A_vals, Vdd_B_vals)
Power_grid = np.zeros_like(Vdd_A_grid)

for i in range(Vdd_A_grid.shape[0]):
    for j in range(Vdd_A_grid.shape[1]):
        Vdd_A = Vdd_A_grid[i, j]
        Vdd_B = Vdd_B_grid[i, j]
        if Vdd_A > V_t and Vdd_B > V_t and constraint([Vdd_A, Vdd_B]) >= 0:
            Power_grid[i, j] = objective([Vdd_A, Vdd_B]) * 1e6  # Convert power to µW
        else:
            Power_grid[i, j] = np.nan  # infeasible points

# Plotting the 3D surface
fig = plt.figure(figsize=[12,12])
ax = fig.add_subplot(111, projection='3d')
ax.plot_surface(Vdd_A_grid, Vdd_B_grid, Power_grid, cmap='viridis')

# Plotting the minimized point
if best_solution is not None:
    ax.scatter(Vdd_A_opt, Vdd_B_opt, P_min, color='r', s=200, label=f'Optimal Point (VA={Vdd_A_opt:.4f} V, VB={Vdd_B_opt:.4f} V, {P_min:.2f} µW)')

ax.set_xlabel('Vdd_A (V)', fontsize=16)
ax.set_ylabel('Vdd_B (V)', fontsize=16)
ax.set_zlabel('Power (µW)', fontsize=16)
ax.set_title('Vdd_A and Vdd_B versus Power', fontsize=16)
ax.legend()
plt.show()
