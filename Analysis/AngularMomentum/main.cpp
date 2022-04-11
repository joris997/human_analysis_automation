#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <string>
#include <vector>
#include <fstream>
// #include "/home/none/opensim/opensim-install/lib/cmake"
#include <OpenSim/OpenSim.h>

const std::string ABSPATH = "/home/none/Downloads/master_thesis/2_experiments/motion_capture/Guoping/sub06";
const double PI = 3.14159265;

std::vector<std::vector<double>> getValuesFromFile(const std::string path,
                                                   std::vector<std::string>& headers){
    std::vector<std::vector<double>> values;

    std::ifstream in(path);
    int lineno = 0;
    std::string line;
    while (std::getline(in,line)){
        ++lineno;
        if (lineno == 19){
            std::stringstream strStream(line);
            std::string value;
            while(std::getline(strStream,value,'\t')){
                headers.push_back(value);
            }
        }
        if (lineno > 19){
            std::stringstream strStream(line);
            std::string value;
            std::vector<double> valuesAti;
            while(std::getline(strStream,value,'\t')){
                valuesAti.push_back(std::stod(value));
            }
            values.push_back(valuesAti);
        }
    }
    in.close();
    return values;
}

int findStrInxInVector(const std::vector<std::string>& header,
                       const std::string& str){
    int idx = 0;
    for (unsigned i=0; i<header.size(); i++){
        if (strcmp(header[i].c_str(),str.c_str()) == 0){
            return i;
        }
    }
    return idx;
}

SimTK::Vec3 getXYZ(const std::vector<std::string>& headers,
                   const std::vector<double>& values,
                   const std::string& bodyName,
                   bool linear){
    std::string X, Y, Z;
    if (linear){
        X = bodyName + "_X";
        Y = bodyName + "_Y";
        Z = bodyName + "_Z";
    } else {
        X = bodyName + "_Ox";
        Y = bodyName + "_Oy";
        Z = bodyName + "_Oz";
    }
    int idxX = findStrInxInVector(headers,X);
    int idxY = findStrInxInVector(headers,Y);
    int idxZ = findStrInxInVector(headers,Z);

    // std::cout << bodyName << std::endl;
    // std::cout << "["<<idxX<<","<<idxY<<","<<idxZ<<"]" << std::endl;

    SimTK::Vec3 XYZ(values[idxX],values[idxY],values[idxZ]);

    return XYZ;
}

SimTK::Vec3 cross(SimTK::Vec3& a, SimTK::Vec3& b){
    SimTK::Vec3 result;
    result[0] = a[1]*b[2] - a[2]*b[1];
    result[1] = a[2]*b[0] - a[0]*b[2];
    result[2] = a[0]*b[1] - a[1]*b[0];
    return result;
}

int main(){
    std::vector<std::string> trials{"01","02","03","04","05","12","13","14","15"};
    std::vector<std::string> runs{"01","02","03","04","05","06","07","08"};

    std::vector<std::string> runsToRun;
    for(unsigned i=0; i<trials.size(); i++){
        for(unsigned ii=0; ii<runs.size(); ii++){
            runsToRun.push_back(trials[i]+"-"+runs[ii]);
        }
    }

    std::string modelPath =   ABSPATH + "/opensimModel/sub06_model.osim";
    OpenSim::Model model(modelPath);

    std::vector<std::string> lowerBodies{"pelvis","femur_r","femur_l",
                                         "tibia_r","tibia_l","talus_r","talus_l",
                                         "calcn_r","calcn_l","toes_r","toes_l"};

    // Perform Angular Momentum Analysis
    for(int i=0; i<runsToRun.size(); i++){
        std::string run = runsToRun[i];
        std::cout << "run: " << run << std::endl;

        std::string bodyPosPath = ABSPATH + "/Analysis/IK/results/IK-"+run+"/pert_sub06_BodyKinematics_pos_global.sto";
        std::string bodyVelPath = ABSPATH + "/Analysis/IK/results/IK-"+run+"/pert_sub06_BodyKinematics_vel_global.sto";
        std::string outPath     = ABSPATH + "/Analysis/IK/results/IK-"+run+"/angular-momentum.sto";

        // Preset the header string vector
        std::vector<std::string> posHeaders, velHeaders;
        // Pass the preset header string vector and also get the values of each
        // file in return. posValues[i][j] is the j-th body/property at time-
        // stamp i
        std::vector<std::vector<double>> posValues = getValuesFromFile(bodyPosPath,posHeaders);
        std::vector<std::vector<double>> velValues = getValuesFromFile(bodyVelPath,velHeaders);

        // Vectors of angular momentum considered around right and left leg
        std::vector<SimTK::Vec3> HR_full, HL_full, LR_full, LL_full;
        std::vector<SimTK::Vec3> HR_lower, HL_lower, LR_lower, LL_lower;
        std::vector<double> times;
        for (unsigned i=0; i<posValues.size(); i++){
            std::vector<double> positions = posValues[i];
            std::vector<double> velocities = velValues[i];

            SimTK::Vec3 posFootR = getXYZ(posHeaders,positions,"calcn_r",true);
            SimTK::Vec3 posFootL = getXYZ(posHeaders,positions,"calcn_l",true);
            times.push_back(posValues[i][0]);

            SimTK::Vec3 HiR_full(0.0); SimTK::Vec3 HiR_lower(0.0);
            SimTK::Vec3 HiL_full(0.0); SimTK::Vec3 HiL_lower(0.0);
            SimTK::Vec3 LiR_full(0.0); SimTK::Vec3 LiR_lower(0.0);
            SimTK::Vec3 LiL_full(0.0); SimTK::Vec3 LiL_lower(0.0);

            for (OpenSim::Body& body : model.updComponentList<OpenSim::Body>()){
                SimTK::Vec3 posBody = getXYZ(posHeaders,positions,body.getName(),true);
                SimTK::Vec3 velBody = getXYZ(velHeaders,velocities,body.getName(),true);
                SimTK::Vec3 dthBody = getXYZ(velHeaders,velocities,body.getName(),false)*(PI/180.0);

                SimTK::Vec3 rR = posBody - posFootR;
                SimTK::Vec3 rL = posBody - posFootL;

                // std::cout << body.getName() << std::endl;
                // std::cout << rR << std::endl;
                // std::cout << rL << std::endl;
                // std::cout << velBody << std::endl;
                // std::cout << dthBody << std::endl;

                if (std::find(lowerBodies.begin(),lowerBodies.end(),body.getName()) != lowerBodies.end()){
                    HiR_lower += cross(rR,body.getMass()*velBody) + body.getInertia()*dthBody;
                    HiL_lower += cross(rL,body.getMass()*velBody) + body.getInertia()*dthBody;
                    LiR_lower += body.getMass()*velBody;
                    LiL_lower += body.getMass()*velBody;
                }
                
                HiR_full += cross(rR,body.getMass()*velBody) + body.getInertia()*dthBody;
                HiL_full += cross(rL,body.getMass()*velBody) + body.getInertia()*dthBody;
                LiR_full += body.getMass()*velBody;
                LiL_full += body.getMass()*velBody;

                std::cout << "HR: " << HiR_full << std::endl;
                std::cout << "HL: " << HiL_full << "\n" << std::endl;
                // break;
            }

            HR_full.push_back(HiR_full);
            HL_full.push_back(HiL_full);
            LR_full.push_back(LiR_full);
            LL_full.push_back(LiL_full);
            HR_lower.push_back(HiR_lower);
            HL_lower.push_back(HiL_lower);
            LR_lower.push_back(LiR_lower);
            LL_lower.push_back(LiL_lower);

            // break;
        }
        break;

        // // Print angular momentum results to file
        // std::ofstream out(outPath);
        // std::string header = "time\tH_Rx\tH_Ry\tH_Rz\tH_Lx\tH_Ly\tH_Lz\tL_Rx\tL_Ry\tL_Rz\tL_Lx\tL_Ly\tL_Lz\tH_Rx\tH_Ry\tH_Rz\tH_Lx\tH_Ly\tH_Lz\tL_Rx\tL_Ry\tL_Rz\tL_Lx\tL_Ly\tL_Lz\n";
        // out << header;
        // for (unsigned i=0; i<HR_full.size(); i++){
        //     std::string line = std::to_string(times[i])+"\t"+

        //                        std::to_string(HR_full[i][0])+"\t"+
        //                        std::to_string(HR_full[i][1])+"\t"+
        //                        std::to_string(HR_full[i][2])+"\t"+
        //                        std::to_string(HL_full[i][0])+"\t"+
        //                        std::to_string(HL_full[i][1])+"\t"+
        //                        std::to_string(HL_full[i][2])+"\t"+

        //                        std::to_string(LR_full[i][0])+"\t"+
        //                        std::to_string(LR_full[i][1])+"\t"+
        //                        std::to_string(LR_full[i][2])+"\t"+
        //                        std::to_string(LL_full[i][0])+"\t"+
        //                        std::to_string(LL_full[i][1])+"\t"+
        //                        std::to_string(LL_full[i][2])+"\t"+

        //                        std::to_string(HR_lower[i][0])+"\t"+
        //                        std::to_string(HR_lower[i][1])+"\t"+
        //                        std::to_string(HR_lower[i][2])+"\t"+
        //                        std::to_string(HL_lower[i][0])+"\t"+
        //                        std::to_string(HL_lower[i][1])+"\t"+
        //                        std::to_string(HL_lower[i][2])+"\t"+

        //                        std::to_string(LR_lower[i][0])+"\t"+
        //                        std::to_string(LR_lower[i][1])+"\t"+
        //                        std::to_string(LR_lower[i][2])+"\t"+
        //                        std::to_string(LL_lower[i][0])+"\t"+
        //                        std::to_string(LL_lower[i][1])+"\t"+
        //                        std::to_string(LL_lower[i][2])+"\n";

        //     out << line;
        // }
        // out.close();
    }
    return 0;
}



//SimTK::Vec2 rR2(rR[0],rR[1]);
//SimTK::Vec2 rL2(rR[0],rR[1]);
//SimTK::Vec2 velBody2(velBody[0],velBody[1]);
//double Izz = 0.047735486316072419;

//HiR2 += rR2 % (body.getMass()*velBody2) + Izz*dthBody[1];
//HiL2 += rL2 % (body.getMass()*velBody2) + Izz*dthBody[1];
//std::cout << dthBody[1] << std::endl;
//std::cout << rR2 % (body.getMass()*velBody2) << std::endl;
//std::cout << "HiR2: " << HiL2 << std::endl;
