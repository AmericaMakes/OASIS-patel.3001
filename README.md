# OASIS Submission - Better Striping
- **Author:** Anden Acitelli
- **Organization:** The Ohio State Center for Design & Manufacturing Excellence (CDME)
- **Submission Name:** Better Striping

## Build & Run Instructions
The following instructions should get you up and running:
1. Build and run the Dockerfile via `docker build -t osu_cdme:latest -m 2GB .`
2. Run the Dockerfile via `docker run -it osu_cdme`
3. Get this directory into the container. Options include `docker cp` and `git clone`.
4. Build the source code by running `build.bat`
5. Execute layer/scan generation for the build plate by running `run_Build_Plate.bat` and for the NIST Plate by running `run_NIST.bat`
6. You can then find the output .scn file in the location specified in the respective config file.

## Scanpath Overview
This scan path is essentially an implementation of the paintbrush algorithm visualized in this picture:

<img src="https://www.researchgate.net/profile/Jamasp_Jhabvala/publication/47366273/figure/fig8/AS:667114696372230@1536063946392/The-four-scanning-strategies.png" height="400" alt="Paintbrush Scan Path Picture">

However, there is one important addition. After vectors are sliced up into stripes (or "alleys" as I refer to them through the code), I take every vector that is shorter in length than our overall alley width and add a jump vector onto the end of them that makes them take as much time to burn as a full-width vector would have. This picture should illustrate what I"m talking about, where

This should result in better performance on triangular or tapered parts, where the rate at which you switch between vectors accelerates. Such scenarios would now take roughly the same time for each vector, even for shorter ones. We were unable to do much testing, though, so we'll see how it goes. 

## Excel File Changes
A ninth tab titled `9.CustomParameters` (mind the spaces) must be added, and Cell C2 must contain a numerical value for the stripe width. This is read in as a double, so decimals are allowed.  

## Implementation Details
First, we allow the baseline code to overlay its vectors and then split and inset them based on part boundaries. Then, we do the following two procedures:

- **Split Into Alleys**: We go through the following steps.
    - Overlay alleys `stripeWidth` wide perpendicular to the hatch angle.
    - Make an output array.
    - Iterate through each alley. For each alley:
        - Iterate through each original vector, and append the subset of that vector that is inside the alley into our output array.
        - Note that, when this procedure is done, the output array will be in alley order, and the order within each alley will be in the order of the original vectors. Note, however, that alleys will be done left to right, and vectors within each individual alley will be burned from minimum x to maximum x, as that's what direction works best with gas flow in most machines, from what I understand.
    - Replace our input `isList` with our output array.
- **Lengthen Short Vectors**: Go through the following steps.
    - For each vector, if it's shorter than our stripe width, add a jump vector onto the end of it (with the same velocity profile as the mark vector, as the point is to take the same amount of time) such that the total time to burn the original mark vector and the new jump vector takes the same amount of time as if it was just one long mark vector. 