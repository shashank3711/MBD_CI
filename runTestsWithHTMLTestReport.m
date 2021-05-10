% matlab.unittest.TestSuite - Class for grouping tests to run
% matlab.unittest.TestRunner - Class for running tests in matlab.unittest framework
% matlab.unittest.plugins.TestReportPlugin - Class to generate report
% towards the end. The supported formats are HTML, docx, pdf.

try
    % Group the tests to run, you can combine test points from different files
    % Here we are combining all tests from a file to create a suite
    fileSuite = matlab.unittest.TestSuite.fromFile('tMatlabUnitTest.m');
    
    % Create a test runner object and attach TAP plugin
    runner = matlab.unittest.TestRunner.withTextOutput('LoggingLevel',3); % Static method withTextOutput
    runner.addPlugin(matlab.unittest.plugins.TestReportPlugin.producingHTML('report','MainFile','report.html'))
    
    result=runner.run(fileSuite);
    disp(result);
    exit;
catch ME
    disp('Error while executing main script')
    getReport(ME)
    exit;
end
