#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <string>
#include <vector>
#include <fstream>
#include <OpenSim/OpenSim.h>

const std::string ABSPATH = "/home/none/Downloads/TUd_2020-2021/Research/master_thesis/2_experiments/motion_capture/Guoping/sub06";

int main(){
    std::string modelFile = ABSPATH + "/Analysis/Random/files/sub06_model.osim";
    OpenSim::Model model = OpenSim::Model(modelFile);

    double mass = 0.0;
    for(OpenSim::Body& b : model.updComponentList<OpenSim::Body>()){
        mass += b.getMass();
    }

    std::cout << "total mass: " << mass << std::endl;

    return 0;
}
