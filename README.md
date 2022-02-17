# Summary
This repository is a starting point for coordinating swarm robotics construction using a mergeable nervous system. It contains an alternative configuration of the Pi-Puck (`pipuck_ext`) with a specialized omni-directional camera and tag mount. The configuration includes an alternative dynamics3d model, an alternative visualisation, and an alternative entity that contains additional components (a tag mounted on the top in this case).

# Quick start

## Compilation
As with the rest of ARGoS, compilation uses CMake. The following commands clone this repository and build/run the plugins/example configuration. ARGoS needs to be installed system-wide for the plugins in this repository to work.

```sh
# clone this repository
git clone https://github.com/iridia-ulb/argos3-pipuck-ext.git
# compile
cd argos3-pipuck-ext
mkdir build
cd build
cmake ../src
make
# run
argos3 -c configuration.argos
```

The following files are created during configuration and compilation:


| Output                                             | Description                                                                                                                                                               |
|----------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `libmy_extensions.so` (or dylib on MacOS)          | Contains the loop functions, pipuck_ext entity, [debug actuator/entity](#the-debug-actuator-and-entity), and dynamics3d model. Should be loaded in the `<loop_functions>` section of the configuration file |
| `libmy_qtopengl_extensions.so` (or dylib on MacOS) | Contains the qtopengl user functions and the visualisation of the pipuck_ext entity. Should be loaded in the `<user_functions>` section under the `<qt-opengl>` tag.      |
| `controller.lua`                                   | Example Lua controller demonstrating the driving forwards, LEDs, and the debug actuator                                                                                   |
| `configuration.argos`                                | Example ARGoS configuration file that is populated with absolute paths to the files above (can be run with `argos3 -c configuration.argos`)                               |

## The debug actuator and entity
When loaded, these plugins provide a debug actuator that can be added to any robot via the `<actuators>` sections in a robot controller's configuration. By adding this actuator, a debug entity is automatically created and added into the robot. Using the Lua interface of a robot, it is possible to draw arrows, rings, and write messages that will be appended to the loop function output for each entity (see controller.lua)

