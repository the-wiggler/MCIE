program integralMCF
    use omp_lib
    implicit none
    integer, parameter :: dp = selected_real_kind(15, 307)
    integer(dp) :: i, j, k, batches, histories, sum_hist, repeat_idx, n_repeats, batch_increment
    real(dp) :: x, a, b, IMC, mean, start_time, end_time, total_time, sum_fx
    real(dp), allocatable :: IMC_val(:), batch_time(:)
    integer(dp), allocatable :: history_count(:)
    character(len=20) :: csv_file
    integer :: csv_unit

    call random_seed()

    a = 0.0_dp ! lower range of integration
    b = 1_dp   ! upper range of integration
    batches = 100 ! Initial number of integrations to compute
    histories = 1000
    n_repeats = 70  ! Number of times to repeat the entire batch process
    batch_increment = 1  ! How much to increase batches by for each repeat
    csv_file = 'repeat_times.csv'
    csv_unit = 10  ! Assign a unit number for the CSV file

    open(unit=csv_unit, file=csv_file, status='unknown', action='write')

    write(csv_unit, '(A)') 'Repeat Index, Total Time (s)'

    do repeat_idx = 1, n_repeats
        print *, 'Repeat number:', repeat_idx
        print *, 'Number of batches:', batches

        allocate(IMC_val(batches), history_count(batches), batch_time(batches))

        do k = 1, batches
            history_count(k) = histories
            histories = histories * 1.001
        end do

        sum_hist = sum(history_count)
        total_time = 0.0_dp 

        !$OMP PARALLEL DO PRIVATE(j, i, histories, x, sum_fx, IMC, start_time, end_time) &
        !$OMP& SHARED(a, b, IMC_val, batches, batch_time)
        do j = 1, batches
            start_time = omp_get_wtime()
            ! BEGIN CALCULATION ***********************************************************************************
            histories = history_count(j)
            sum_fx = 0.0_dp

            do i = 1, histories
                call random_number(x)
                x = a + x * (b - a) ! scales x to be within a range from b to a
                sum_fx = sum_fx + f(x) ! adds rand f(x) value to sum
            end do

            IMC = (b - a) * (sum_fx / histories) ! CALCULATES INTEGRAL
            ! END CALCULATION *************************************************************************************
            end_time = omp_get_wtime()
            batch_time(j) = end_time - start_time

            IMC_val(j) = IMC

            total_time = total_time + batch_time(j)  ! Accumulate the time for this batch

            sum_hist = sum_hist - histories
        end do
        !$OMP END PARALLEL DO

        write(csv_unit, '(I0, ",", F8.6)') repeat_idx, total_time

        deallocate(IMC_val, history_count, batch_time)

        batches = batches + batch_increment
    end do ! End of repeat loop

    close(csv_unit)

contains

    function f(x) result(y)
        real(dp) :: x, y
        y = log(1 + x) / x
    end function f

end program integralMCF
