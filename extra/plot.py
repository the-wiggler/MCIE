import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv('repeat_times.csv')

plt.plot(df['rep_parallel'], df['time_parallel'], label='Parallel', marker='o', markersize=3) 
plt.plot(df['rep_serial'], df['time_serial'], label='Serial', marker='o', markersize=3)  
plt.xlabel('Number of Repetitions')
plt.ylabel('Execution Time (seconds)')
plt.title('Execution Time vs. Number of Repetitions')
plt.legend()

plt.yscale('log')

plt.savefig('repeat_times_plot.png')
plt.show()
