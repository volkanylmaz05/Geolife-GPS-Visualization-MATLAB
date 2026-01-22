% ==========================================================
% Project: Geolife Trajectories GPS Visualization
% Author: Volkan Yılmaz
% Description: Visualizing Beijing GPS data with noise filtering
% ==========================================================
clear; clc; close all;

mainPath = 'C:\...\Dataset_\Geolife Trajectories 1.3\Data\'; %% Dataset directory path
userFolders = dir(mainPath); % List all directories in the dataset path
userFolders = userFolders(~ismember({userFolders.name}, {'.', '..'})); 

% Map Initialization
figure('Name', 'Geolife Clean Visualization', 'Color', 'w');
gx = geoaxes; % Create geographic axes for mapping
geobasemap(gx, 'satellite'); 
hold(gx, 'on');
title(gx, 'Beijing Trajectories (Color Coded)', 'Color', 'w');

% Geographic Limits (Focus on Beijing)
geolimits(gx, [39.8 40.1], [116.2 116.5]); 

limit = input("How many users would you like to visualize? (Max: 182): ");

colorPalette = hsv(limit); % Generate contrasting colors for each user

% Legend Preallocation
hLine = gobjects(limit, 1); % Preallocate an array to store graphic handles for legend tracking
userNames = cell(limit, 1); % Preallocate a cell array to store formatted user labels for the legend

for i = 1:limit
    currentUserFolder = userFolders(i).name;
    trajPath = fullfile(mainPath, currentUserFolder, 'Trajectory');
    
    % Select a unique color for the current user from the palette
    myColor = colorPalette(i, :); 
    
    % Store the label for the legend
    userNames{i} = ['User ', num2str(i)];
    
    firstPlotDone = false; % Flag to capture the first plot as a representative for the legend
    
    if exist(trajPath, 'dir')
        pltFiles = dir(fullfile(trajPath, '*.plt')); % List only .plt files
        
        for j = 1:length(pltFiles)
            currentPltName = pltFiles(j).name;
            fullFilePath = fullfile(trajPath, currentPltName);
            
            try % Error handling for file reading
                opts = detectImportOptions(fullFilePath, 'FileType', 'text');
                opts.DataLines = [7 Inf]; % Start reading from the 7th line
                T = readtable(fullFilePath, opts); % Import file as a table
                
                lat = T.Var1; % Latitude
                lon = T.Var2; % Longitude
                
                % Data Filtering
                % Filter to exclude points outside Beijing and prevent map distortion
                cleanData = (lat > 39) & (lat < 41) & (lon > 115) & (lon < 117); 
                lat = lat(cleanData);
                lon = lon(cleanData);
                
                if ~isempty(lat)
                    p = geoplot(gx, lat, lon, 'Color', [myColor, 0.7], 'LineWidth', 0.5);
                    if ~firstPlotDone
                        hLine(i) = p;
                        firstPlotDone = true;
                    end
                    
                    if mod(j, 10) == 0 % Refresh rate (Lower values (e.g., mod(j, 2)) provide smoother animation but increase CPU load. Default is 10 for balanced performance.)
                        drawnow limitrate;
                    end
                end
            catch % Skip the file if an error occurs during processing
            end
        end
        fprintf('User %d processed.\n', i);
    end
end

% Create legend only for valid graphic objects
validIdx = isgraphics(hLine); 
legend(gx, hLine(validIdx), userNames(validIdx), 'TextColor', 'w', 'Color', 'k');

msgbox('Processing Completed Successfully!');