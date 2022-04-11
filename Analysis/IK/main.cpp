#include <iostream>
#include <string>
#include <vector>
#include <OpenSim/OpenSim.h>

const std::string ABSPATH = "/home/none/Downloads/TUd_2020-2021/Research/master_thesis/2_experiments/motion_capture/Guoping/sub06";

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

    for(unsigned i=0; i<runsToRun.size(); i++){
        std::string run = runsToRun[i];
        std::cout << "run: " << run << std::endl;

        std::string setupFile = ABSPATH + "/Analysis/IK/setup/sub_ik_setup.xml";
        std::string markerFile = ABSPATH + "/MarkerTrc/qtm-"+run+".trc";

        std::string outputDir = ABSPATH + "/Analysis/IK/results/IK-"+run;
        std::system(("mkdir "+outputDir).c_str());

        std::string motionFile = ABSPATH + "/Analysis/IK/results/IK-"+run+"/ik-"+run+".mot";

        OpenSim::InverseKinematicsTool ikTool(setupFile);
        ikTool.setMarkerDataFileName(markerFile);
        ikTool.setOutputMotionFileName(motionFile);

        ikTool.run();
    }

    for(unsigned i=0; i<runsToRun.size(); i++){
        std::string run = runsToRun[i];
        std::cout << "run: " << run << std::endl;

        std::string setupFile = ABSPATH + "/Analysis/IK/matlab/CoM/com_analyze_Setup.xml";
        std::string modelFile = ABSPATH + "/opensimModel/sub06_model.osim";
        std::string outputDir = ABSPATH + "/Analysis/IK/results/IK-"+run;

        std::string motionFile = ABSPATH + "/Analysis/IK/results/IK-"+run+"/ik-"+run+".mot";

        OpenSim::AnalyzeTool anTool(setupFile);
        anTool.setName("pert_sub06");
        anTool.setModelFilename(modelFile);
        anTool.setResultsDir(outputDir);
        anTool.setCoordinatesFileName(motionFile);

        anTool.run();
    }

    return 0;
}
