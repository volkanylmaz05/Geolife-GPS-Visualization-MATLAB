Geolife Trajectories GPS Visualization Project

This project aims to process, filter, and visualize large-scale GPS data using the Microsoft Research Geolife Trajectories v1.3 dataset within the MATLAB environment. The application transforms raw GPS logs into a meaningful urban mobility map of Beijing.

Technical Features and Methodology

Data Pre-processing: The script automatically skips the first 6 header lines of .plt files to directly access coordinate data starting from the 7th line.


Logical Filtering: To ensure spatial accuracy and prevent map distortion, data points outside the Beijing metropolitan area (39-41N, 115-117E) and erroneous (0,0) coordinates are programmatically excluded.


Dynamic Visualization: Unique and high-contrast colors are assigned to each user using the hsv color palette, allowing for clear differentiation of individual routes on a satellite base map.


Performance Optimization: To handle the dataset's significant size (approx. 1.5GB) without system instability, a "Batch Processing" approach is implemented, refreshing the display every 10 files using the drawnow command.

Usage Instructions

Data Preparation: Download the Microsoft Geolife v1.3 dataset and place it in the Data/ directory within the project folder.


Path Configuration: Update the mainPath variable in konum_izler.m to reflect the local path of your dataset.


Execution: Run the script and enter the desired number of users (up to 182) in the Command Window when prompted.

Developer: Volkan Yılmaz
