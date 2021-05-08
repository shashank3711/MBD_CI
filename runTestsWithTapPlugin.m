% We don't want the test output produced in MATLAB to get in the way of the 
% TAP stream and invalidate it
% so we need to ensure the tap stream is directed somewhere other than the 
% Command Window. We also need the TAP stream to output to a file that the 
% Jenkins plugin can find for analysis. 
%
% Both of these issues are conveniently solved by sending the TAPPlugin 
% output to a ToFile stream.


% matlab.unittest.TestSuite - Class for grouping tests to run
% matlab.unittest.TestRunner - Class for running tests in matlab.unittest framework
% matlab.unittest.plugins.TAPPlugin - Class that enables Test Anything
% Protocol (TAP) stream results printing

try
    % Group the tests to run, you can combine test points from different files
    % Here we are combining all tests from a file to create a suite
    fileSuite = matlab.unittest.TestSuite.fromFile('tMatlabUnitTest.m');
    
    % Print all the logs to an external file
    stream = matlab.unittest.plugins.ToFile('myTapFile.tap');
    
    % Create a test runner object and attach TAP plugin
    runner = matlab.unittest.TestRunner.withTextOutput('LoggingLevel',3); % Static method withTextOutput
    runner.addPlugin(matlab.unittest.plugins.TAPPlugin.producingOriginalFormat(stream))
    
    result=runner.run(fileSuite);
    
    for iloop=1:length(result)
        disp(result(iloop))
    end
    exit(any([result.failed]))
catch ME
    disp('Error while executing main script')
    getReport(ME)
    exit(1)
end
