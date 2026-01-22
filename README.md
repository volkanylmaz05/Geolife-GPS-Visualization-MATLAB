Geolife Trajectories GPS Visualization Project
This project aims to process, filter, and visualize large-scale GPS data using the Microsoft Research Geolife Trajectories v1.3 dataset within the MATLAB environment. The application transforms raw GPS logs into a meaningful urban mobility map of Beijing.

Technical Features and Methodology
Data Pre-processing: The script automatically skips the first 6 header lines of .plt files to directly access coordinate data starting from the 7th line.

Logical Filtering: To ensure spatial accuracy and prevent map distortion, data points outside the Beijing metropolitan area (39-41N, 115-117E) and erroneous (0,0) coordinates are programmatically excluded.

Dynamic Visualization: Unique and high-contrast colors are assigned to each user using the hsv color palette, allowing for clear differentiation of individual routes on a satellite base map.

Performance Optimization: To handle the dataset's significant size (approx. 1.5GB) without system instability, a "Batch Processing" approach is implemented. The display refreshes every 10 files using the drawnow limitrate command to maintain smoothness.

⚙️ Installation & Usage
Download Dataset: Download the official Microsoft Research dataset from the following link: Microsoft Research Geolife Trajectories v1.3(https://www.kaggle.com/datasets/arashnic/microsoft-geolife-gps-trajectory-dataset)

Data Preparation: Extract the ZIP file and ensure the Data/ folder (containing user folders like 000, 001, etc.) is accessible.

Path Configuration: Open gps_visualizer.m and update the mainPath variable with your local dataset directory:

Matlab
mainPath = 'C:\...\Dataset_\Geolife Trajectories 1.3\Data\';
Execution: Run the script in MATLAB. When prompted in the Command Window, enter the number of users you wish to visualize (up to 182).


<img width="1769" height="883" alt="image" src="https://github.com/user-attachments/assets/7b9001c0-3339-48aa-9c3e-82acf0159dc5" />

