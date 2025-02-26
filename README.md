# OASIS Submission - Alternating Order Hatching
- **Author:** Harshil Patel
- **Organization:** The Ohio State Center for Design & Manufacturing Excellence (CDME)
- **Submission Name:** Alternating Order Hatching

## Build & Run Instructions
The following instructions should get you up and running:
1. Build and run the Dockerfile via `docker build -t osu_cdme:latest -m 2GB .`
2. Run the Dockerfile via `docker run -it osu_cdme`
3. Get this directory into the container. Options include `docker cp` and `git clone`.
4. Build the source code by running `build.bat`
5. Execute layer/scan generation for the build plate by running `run_Build_Plate.bat` and for the NIST Plate by running `run_NIST.bat`
6. You can then find the output .scn file in the location specified in the respective config file.

## Scanpath Overview
Alternating order hatching, meaning stripe 1 and then 3 and then 5, then when finished with odd stipes, go to 2 and then 4 and then 6.
