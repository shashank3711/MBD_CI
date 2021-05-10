try
    result=runtests('tMatlabUnitTest.m');
    for iloop=1:length(result)
        disp(result(iloop))
    end
    exit(any([result.failed]))
catch ME
    disp('Error while executing main script')
    exit(1)
end