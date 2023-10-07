program test_parallel_do

    integer :: a(32), i

    print '(a)', '1..32'

    a = [(i, i = 1, size(a))]

    !$omp parallel do
    do i = 1, size(a)
        a(i) = a(i) ** 2
    end do

    do i = 1, size(a)
        if (a(i) .eq. i ** 2) then
            print '(a,i6)', 'ok ', i
        else
            print '(a,i6)', 'not ok ', i
        end if
    end do

end program
