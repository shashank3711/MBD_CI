% We don't want the test output produced in MATLAB to affect TAP stream.
% To compartmentalize the TAP stream we will output it to a file that
% Jenkins plugin can find for analysis.

% matlab.unittest.TestSuite - Class for grouping tests to run
% matlab.unittest.TestRunner - Class for running tests in matlab.unittest framework
% matlab.unittest.plugins.TAPPlugin - Class that enables Test Anything
% Protocol (TAP) stream results printing

try
    % Group the tests to run, you can combine test points from different files
    % Here we are combining all tests from a file to create a suite
    fileSuite = matlab.unittest.TestSuite.fromFile('tMatlabUnitTest.m');
    
    % Create a test runner object and attach TAP plugin
    runner = matlab.unittest.TestRunner.withTextOutput('LoggingLevel',3); % Static method withTextOutput
    runner.addPlugin(matlab.unittest.plugins.XMLPlugin.producingJUnitFormat('testResults.xml'))
    
    result=runner.run(fileSuite);
    disp(result);
    exit;
catch ME
    disp('Error while executing main script')
    getReport(ME)
    exit;
end
