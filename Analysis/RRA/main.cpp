#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <string>
#include <vector>
#include <fstream>
#include <OpenSim/OpenSim.h>

const std::string ABSPATH = "/home/none/Downloads/TUd_2020-2021/Research/master_thesis/2_experiments/motion_capture/Guoping/sub06";

std::vector<double> getStartEndTime(std::string grfFile){
    std::ifstream grfStream(grfFile);
    std::string line;
    int lineno = 0;
    int linenoStart = 0;
    bool flag = false;

    std::vector<double> result;
    // tab 7 and 13 for vertical GRF force
    while(std::getline(grfStream,line)){
        ++lineno;
        if(lineno > 7){
            std::string value;
            std::stringstream strStream(line);
            std::vector<double> values;
            int valueno = 0;
            while(std::getline(strStream,value,'\t')){
                ++valueno;
                values.push_back(std::stod(value));
            }
            if (values[6] != 0.0 || values[12] != 0.0){
                result.push_back(values[0]);
                linenoStart = lineno;
                break;
            }
        }
    }

    std::ifstream grfStream2(grfFile);
    lineno = 0;
    flag = false;
    while(std::getline(grfStream2,line)){
        ++lineno;
        if(lineno > linenoStart){
            std::string value;
            std::stringstream strStream(line);
            std::vector<double> values;
            int valueno = 0;
            while(std::getline(strStream,value,'\t')){
                ++valueno;
                values.push_back(std::stod(value));
            }
            if (values[6] == 0 && values[12] == 0){
                result.push_back(values[0]);
                break;
            }
        }
    }
    std::cout << result[0] << "    " << result[1] << std::endl;
    return result;
}

int main(){
    // in:  model (.osim)
    //      grf data (.mot)
    //      motion data (.mot)
    //      RRA actuators (.xml) -
    //      RRA tasks (.xml)     -- RRA setup (.xml)

    // out: q kinematics (.sto)
    //      adjusted model (.osim)
    std::vector<std::string> trials{"01","02","03","04","05","12","13","14","15"};
    std::vector<std::string> runs{"01","02","03","04","05","06","07","08"};
    std::vector<std::string> runsToRun;
    for(unsigned i=0; i<trials.size(); i++){
        for(unsigned ii=0; ii<runs.size(); ii++){
            runsToRun.push_back(trials[i]+"-"+runs[ii]);
        }
    }

    for(int i=0; i<runsToRun.size(); i++){
        std::string run = runsToRun[i];
        std::cout << "run: " << run << std::endl;

        std::string modelFile = ABSPATH + "/Analysis/RRA/setup/sub06_model_RRA.osim";
        std::string forceSetFile = ABSPATH + "/Analysis/ID/results/id-loads-"+run+".xml";
        std::string grfFile = ABSPATH + "/GRFMot/grf-"+run+".mot";
        std::string motionFile = ABSPATH + "/Analysis/IK/results/IK-"+run+"/ik-"+run+".mot";

        std::string setupFile = ABSPATH + "/Analysis/RRA/setup/setup_from_gui_to_cpp.xml";
        std::string tasksFile = ABSPATH + "/Analysis/RRA/setup/sub06_RRA_Tasks.xml";
        std::string actuatorsFile = ABSPATH + "/Analysis/RRA/setup/sub06_RRA_Actuators.xml";
        std::string controlConstraintsFile = ABSPATH + "/Analysis/RRA/setup/sub06_RRA_ControlConstraints.xml";

        std::string resultsDir = ABSPATH + "/Analysis/RRA/results";
        std::string outputDir = resultsDir + "/RRA-"+run;
        std::system(("mkdir "+outputDir).c_str());
        std::string outputModelFile = outputDir + "/sub06_model_RRA-"+run+".osim";

        OpenSim::RRATool rraTool(setupFile);
        rraTool.setName("sub06");

        rraTool.setModelFilename(modelFile);                // sub06_model_RRA.osim
        OpenSim::Array<std::string> forceSetArray(actuatorsFile,1);
        rraTool.setForceSetFiles(forceSetArray);

        rraTool.setExternalLoadsFileName(forceSetFile);     // id-loads-01-01.xml
        rraTool.setDesiredKinematicsFileName(motionFile);   // ik-01-01.xml
        rraTool.setLowpassCutoffFrequency(6.0);

        rraTool.setTaskSetFileName(tasksFile);              // sub06_RRA_Tasks.xml
        rraTool.setConstraintsFileName(controlConstraintsFile);// sub06_RRA_ControlConstraints.xml
        rraTool.setErrorTolerance(0.01);

        // Detect when GRF is actually measuring for begin and end time
        std::vector<double> startEnd = getStartEndTime(grfFile);
        rraTool.setStartTime(startEnd[0]);
        rraTool.setFinalTime(startEnd[1]);

        rraTool.setResultsDir(outputDir);
        rraTool.setOutputModelFileName(outputModelFile);
        rraTool.setAdjustCOMToReduceResiduals(true);

        rraTool.print("rra_tool.xml");

        rraTool.run();

        for (int i=0; i<3; i++){
            OpenSim::RRATool rraToolLoop("tool.xml");
            rraToolLoop.setModelFilename(outputModelFile);
            rraToolLoop.run();
        }
    }

    return 0;
}
