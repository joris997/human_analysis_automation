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

    std::vector<double> result;
    result.push_back(0.0); result.push_back(1.0);

    // tab 7 and 13 for vertical GRF force
    while(std::getline(grfStream,line)){
        ++lineno;
        if(lineno == 8){
            std::string value;
            std::stringstream strStream(line);
            while(std::getline(strStream,value,'\t')){
                result[0] = std::stod(value);
                break;
            }
        }
        if(lineno > 8){
            std::string value;
            std::stringstream strStream(line);
            while(std::getline(strStream,value,'\t')){
                result[1] = std::stod(value);
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
    //      CMC actuators (.xml)           \
    //      CMC tasks (.xml)               |
    //      CMC control constraints (.xml) |- CMC setup (.xml)

    // out: walking muscle controls (.xml)
//    std::vector<std::string> trials{"01","02","03","04","05","12","13","14","15"};
    std::vector<std::string> trials{"04","05","12","13","14","15"};
    std::vector<std::string> runs{"01","02","03","04","05","06","07","08"};

    std::vector<std::string> runsToRun;
    for(unsigned i=0; i<trials.size(); i++){
        for(unsigned ii=0; ii<runs.size(); ii++){
            runsToRun.push_back(trials[i]+"-"+runs[ii]);
        }
    }

    // PERFORM COM ANALYSIS
    for(int i=0; i<runsToRun.size(); i++){
        std::string run = runsToRun[i];

        std::string setupFile = ABSPATH + "/Analysis/IK/matlab/CoM/com_analyze_Setup_CMC.xml";
        std::string modelFile = ABSPATH + "/Analysis/RRA/results/RRA-"+run+"/sub06_model_RRA-"+run+".osim";
        std::string outputDir = ABSPATH + "/Analysis/CMC/results/CMC-"+run;

        std::string statesFile = ABSPATH + "/Analysis/CMC/results/CMC-"+run+"/sub06_states.sto";

        OpenSim::AnalyzeTool anTool(setupFile);
        anTool.setName("pert_sub06");
        anTool.setModelFilename(modelFile);
        anTool.setResultsDir(outputDir);
        anTool.setStatesFileName(statesFile);

        anTool.run();
    }

    // PERFORM ANGULAR MOMENTUM ANALYSIS
//    for(int i=0; i<runsToRun.size(); i++){
//        std::string run = runsToRun[i];
//        std::cout << "run: " << run << std::endl;

//        std::string modelFile = ABSPATH + "/Analysis/RRA/results/RRA-"+run+"/sub06_model_RRA-"+run+".osim";
//        std::string stateFile = ABSPATH + "/Analysis/CMC/results/CMC-"+run+"/sub06_states.sto";

//        OpenSim::Model model(modelFile);
//        OpenSim::Storage storage(stateFile);
//        OpenSim::StatesTrajectory stateTrajectory =
//                OpenSim::StatesTrajectory::createFromStatesStorage(model,storage,false,false,true);

//        for (int i=0; i<stateTrajectory.getSize(); i++){
//            SimTK::State state = stateTrajectory[0];

//            model.initSystem();
//            model.realizeAcceleration(state);
//            model.realizeTime(state);

//            OpenSim::Body& calcn_r = model.updComponent<OpenSim::Body>("/bodyset/calcn_r");
//            OpenSim::Body& calcn_l = model.updComponent<OpenSim::Body>("/bodyset/calcn_l");
//            OpenSim::BodySet bodyset = model.getBodySet();

//            SimTK::Vec3 L;
//            for (OpenSim::Body body : model.updComponentList<OpenSim::Body>()){
//                if (strcmp(body.getName().c_str(),calcn_r.getName().c_str()) != 0 || strcmp(body.getName().c_str(),calcn_l.getName().c_str()) != 0){
//                    model.initSystem();
//                    SimTK::Vec3 r_r = body.findStationLocationInAnotherFrame(state,body.getMassCenter(),bodyset.get(calcn_r.getName()));
//                    SimTK::Vec3 r_l = body.findStationLocationInAnotherFrame(state,body.getMassCenter(),bodyset.get(calcn_r.getName()));

//                    SimTK::Vec3 dr = body.findStationVelocityInGround(state,body.getMassCenter());

//                    SimTK::Inertia I = body.getInertia();
//                    SimTK::Vec3 omega = body.getAngularVelocityInGround(state);

//                    L += r_r% (body.getMass()*dr) + I*omega;
//                }
//            }

////            SimTK::SpatialVec momentum = model.getMultibodySystem().getMatterSubsystem().calcSystemMomentumAboutGroundOrigin(state);
////            SimTK::Real mass = model.getMultibodySystem().getMatterSubsystem().calcSystemMass(state);
////            std::cout << "mass:     " << momentum << std::endl;
////            std::cout << "momentum: " << mass << std::endl;

//        }
//    }

    // PERFORM ACTUAL CMC
//    for(int i=0; i<runsToRun.size(); i++){
//        std::string run = runsToRun[i];
//        std::cout << "run: " << run << std::endl;

//        std::string modelFile = ABSPATH + "/Analysis/RRA/results/RRA-"+run+"/sub06_model_RRA-"+run+"_2.osim";
//        std::string forceSetFile = ABSPATH + "/Analysis/ID/results/id-loads-"+run+".xml";
//        std::string grfFile = ABSPATH + "/GRFMot/grf-"+run+".mot";
//        std::string motionFile = ABSPATH + "/Analysis/RRA/results/RRA-"+run+"/sub06_Kinematics_q.sto";

//        std::string setupFile = ABSPATH + "/Analysis/CMC/setup/sub06_Setup_CMC.xml";

//        std::string resultsDir = ABSPATH + "/Analysis/CMC/results";
//        std::string outputDir = resultsDir + "/CMC-"+run;
//        std::system(("mkdir "+outputDir).c_str());

//        // CREATE TOOL
//        OpenSim::CMCTool cmcTool(setupFile);
//        cmcTool.setName("sub06");

//        // model and forceset
//        cmcTool.setModelFilename(modelFile);
////        OpenSim::Array<std::string> forceSetArray(actuatorsFile,1);
////        cmcTool.setForceSetFiles(forceSetArray);

//        // kinematics and loads
//        cmcTool.setExternalLoadsFileName(forceSetFile);
//        cmcTool.setDesiredKinematicsFileName(motionFile);
//        cmcTool.setLowpassCutoffFrequency(6.0);

//        // tasks
////        cmcTool.setTaskSetFileName(tasksFile);
//        cmcTool.setTimeWindow(0.01);

//        // start and end time
//        std::vector<double> startEnd = getStartEndTime(grfFile);
//        cmcTool.setStartTime(startEnd[0]);
//        cmcTool.setFinalTime(startEnd[1]);

//        // outputs
//        cmcTool.setResultsDir(outputDir);

//        cmcTool.print("cmc_tool.xml");

//        cmcTool.run();

//    }

    return 0;
}
