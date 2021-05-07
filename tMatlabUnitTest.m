classdef tMatlabUnitTest<matlab.unittest.TestCase
    %MIL tests for all models
    
   methods(TestMethodSetup)
        function setupTest(testCase)
            import matlab.unittest.fixtures.WorkingFolderFixture;
            testCase.applyFixture(WorkingFolderFixture);
        end
   end
   
   methods (Test)

       function checkSimulationOutputFor_mCounterWithReset(testCase)
           model='mCounterWithReset';
           open_system(model)
           testCase.addTeardown(@()close_system(model,0));
           simOut=sim(model,'ReturnWorkspaceOutputs', 'on');
           testCase.verifyEqual(simOut.yout1.signals.values,zeros(51,1))
       end
       
       function checkSimulationOutputFor_mCounterWithSaturation(testCase)
           model='mCounterWithSaturation';
           open_system(model)
           testCase.addTeardown(@()close_system(model,0));
           simOut=sim(model,'ReturnWorkspaceOutputs', 'on');
           testCase.verifyEqual(simOut.yout1.signals.values,ones(51,1));
       end
       
       function checkSimulationOutputFor_mIntegratedModel(testCase)
           model='mIntegratedModel';
           open_system(model)
           testCase.addTeardown(@()close_system(model,0));
           simOut=sim(model,'ReturnWorkspaceOutputs', 'on');
           testCase.verifyEqual(simOut.yout1.signals.values,zeros(6,1),'yout1 dont match')
           testCase.verifyEqual(simOut.yout2.signals.values,[0;1;2;3;4;5],'yout2 dont match')
       end
   end
            
end

