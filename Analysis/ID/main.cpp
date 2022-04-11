#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <string>
#include <vector>
#include <fstream>
#include <OpenSim/OpenSim.h>

const std::string ABSPATH = "/home/none/Downloads/TUd_2020-2021/Research/master_thesis/2_experiments/motion_capture/Guoping/sub06";

double getEndTime(const std::string& run){
    std::string newFileLoc = "/home/none/ik-"+run+".mot";

    std::ifstream motionStream(ABSPATH+"/Analysis/IK/results/ik-"+run+".mot");
    std::string line;
    int lineno = 0;

    double endTime = 1.0;

    while(std::getline(motionStream,line)){
        ++lineno;
        if (lineno > 11){
            std::string value;
            std::stringstream strStream(line);
            int valueno = 0;
            while(std::getline(strStream,value,'\t')){
                ++valueno;
                if (valueno == 1){
                    endTime = std::stod(value);
                    break;
                }
            }
        }
    }
    motionStream.close();
    return endTime;
}


int main()
{
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

        // setup
        std::string setupFile = ABSPATH + "/opensimModel/sub_id_setup.xml";

        // in
        std::string motionFile = ABSPATH + "/Analysis/IK/results/ik-"+run+".mot";
        std::string grfFile = ABSPATH + "/GRFMot/grf-"+run+".mot";
        std::string loadsFileIn = ABSPATH + "/opensimModel/sub_id_external_load.xml";

        // out
        std::string loadsFileOut = ABSPATH + "/Analysis/ID/results/id-loads-"+run+".xml";

        // print new loads file
        std::ofstream loadsFileOutStream(loadsFileOut);
        std::ifstream loadsFileInStream(loadsFileIn);
        std::string line;
        int lineno = 0;
        while(std::getline(loadsFileInStream,line)){
            ++lineno;
            if(lineno == 36){
                loadsFileOutStream << "\t\t<datafile>"+grfFile+"</datafile>\n";
            } else if(lineno == 38){
                loadsFileOutStream << "\t\t<external_loads_model_kinematics_file />\n";
            } else{
                loadsFileOutStream << line;
            }
        }
        loadsFileOutStream.close();
        loadsFileInStream.close();

        double endTime = getEndTime(run);
        std::cout << "endTime detected: " << endTime << std::endl;

        OpenSim::InverseDynamicsTool idTool(setupFile);
        idTool.setCoordinatesFileName(motionFile);
        idTool.setExternalLoadsFileName(loadsFileOut);
        idTool.setResultsDir(ABSPATH + "/Analysis/ID/results");
        idTool.setStartTime(0.0);
        idTool.setEndTime(endTime);
        idTool.run();

//        std::system(("rm "+loadsFileOut).c_str());
    }


    return 0;
}
