# OASIS Submission - Increasing Hatch Spacing in Alterating Layers
- **Author:** Harshil Patel
- **Organization:** The Ohio State Center for Design & Manufacturing Excellence (CDME)
- **Submission Name:** Increasing Hatch Spacing in Alterating Layers

## Build & Run Instructions
The following instructions should get you up and running:
1. Build and run the Dockerfile via `docker build -t osu_cdme:latest -m 2GB .`
2. Run the Dockerfile via `docker run -it osu_cdme`
3. Get this directory into the container. Options include `docker cp` and `git clone`.
4. Build the source code by running `build.bat`
5. Execute layer/scan generation for the build plate by running `run_Build_Plate.bat` and for the NIST Plate by running `run_NIST.bat`
6. You can then find the output .scn file in the location specified in the respective config file.

## Scanpath Overview
Alternating hatch spacing between each layer, meaning first layer will use spacing size in configuration file and next layer will use increase it by a defined percentage, and repeat the pattern.


## Excel File Changes
A ninth tab titled `9.CustomParameters` (mind the spaces) must be added, and Cell C2 must contain a numerical value for the hatch space size increase by percentage between alternating layers. This is read in as a double, so decimals are allowed.  
