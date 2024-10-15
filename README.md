# Monte Carlo Integration Estimation Program (`MCIE.f90`)
### Overview
This program estimates the integral of a function using Monte Carlo integration with OpenMP for parallelization. It calculates the integral over a given range, computes statistical values like variance, standard deviation, and relative error, and stores the results in a CSV file. The integral is computed in batches, where each batch has an increasing number of random samples (histories).

### Installation & Compilation
* Option 1: Compile and run the program using `./run.sh`
* Option 2: Compile using a FORTRAN compiler. `run.sh` uses OpenMP so the -fopenmp tag must be added to the custom command. However, this is not strictly necessary

### Usage
* `a` and `b`: These define the lower and upper bounds of the definite integral.
* `batches`: This is the number of times the integration is repeated with increasing histories.
* `histories`: Initial number of random points (histories) to calculate the integral for the first batch.
  * `hist_factor`: Increases the value of histories by a factor every new batch.
* `lit_val`: The known or exact value of the integral for comparison. (required for percent error calculation)

### Output
The program generates a CSV file named results.csv containing the results of each batch. It includes:
* Batch number
* Calculated integral (IMC value)
* Number of histories used in that batch
* Variance
* Standard deviation (stdv)
* Relative error (rel_err)
* Batch execution time

## Customizing the Function
The function being integrated is in terms of a one variable f(x) funciton. You can modify it by editing the `f(x)` function inside the program: </br>
```fortran
function f(x) result(y)
    real(dp) :: x, y
    y = x  ! Modify this to integrate a different function
end function f
```

# Python Plotting (`dataplot.py`)
###  Dependencies
* matplotlib
* pandas
* numpy

