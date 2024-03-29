%% LOD issue's temporary fix proposed by MatroseFuchs, script witten by AstreTunes from SEA group
% This script moves all lod files into lods/ folder

% !!!!!! Matlab version must be r2016b or higher (mandatory) !!!!!!

% How to use:
% - put this script in res_mods/PnFMods/
% - run this script

clc
clear
fclose all;
tic

%% Prepare log file

% logFile=fopen('LOD_transporter.log', 'w');

%% Generate file list

ancaList = dir('**/*.anca');
modelList = dir('**/*.model');
primitivesList = dir('**/*.primitives');
visualList = dir('**/*.visual');

if isempty(modelList)
    
    toc;
    error('No lod file found.');
    
end

%% Move and modify model

for indModel = 1 : size(modelList, 1)
    
    currentFileName = [modelList(indModel).folder, '\', modelList(indModel).name];
    
    % backup file
    copyfile(currentFileName, [currentFileName, 'bak']);
    disp([currentFileName, ' is backed up']);
    
    % modify file
    currentFileBackup = fopen([currentFileName, 'bak'], 'rt');
    currentFile = fopen(currentFileName, 'w');
    
    % create folder if doesn't exist
    if ~exist([modelList(indModel).folder, '\lods'], 'dir') 
        mkdir([modelList(indModel).folder, '\lods']);
    end
    
    lineBuffer = 0;
    exitLoop = 0;
    
    while exitLoop == 0
        
        lineBuffer = fgetl(currentFileBackup);
        
        if ~isempty(lineBuffer)
            
            if lineBuffer==-1
                
                exitLoop=1;
                
            elseif contains(lineBuffer, '<parent>')
            
                slashPositions1 = strfind(lineBuffer, '/');
                slashPositions2 = strfind(lineBuffer, '\');
                if isempty(slashPositions1)
                    newLine = [lineBuffer(1:slashPositions2(end-1)), 'lods\', lineBuffer((slashPositions2(end-1)+1):end)];
                else
                    newLine = [lineBuffer(1:slashPositions1(end-1)), 'lods/', lineBuffer((slashPositions1(end-1)+1):end)];
                end

                fprintf(currentFile, '%s\r\n', newLine);

            elseif contains(lineBuffer, 'nodefullVisual')

                if contains(lineBuffer, '_lod')

                    slashPositions1 = strfind(lineBuffer, '/');
                    slashPositions2 = strfind(lineBuffer, '\');
                    if isempty(slashPositions1)
                        newLine = [lineBuffer(1:slashPositions2(end-1)), 'lods\', lineBuffer((slashPositions2(end-1)+1):end)];
                    else
                        newLine = [lineBuffer(1:slashPositions1(end-1)), 'lods/', lineBuffer((slashPositions1(end-1)+1):end)];
                    end

                    fprintf(currentFile, '%s\r\n', newLine);

                else

                    fprintf(currentFile, '%s\r\n', lineBuffer);

                end
                
            else
                
                fprintf(currentFile, '%s\r\n', lineBuffer);
                
            end
            
        else
            
            fprintf(currentFile, '%s\r\n', lineBuffer);
            
        end
        
        
    end
    
    % move file if lod
    if strcmp(currentFileName(end-10 : end-7), '_lod')
        
        fclose all;
        disp(['moving ', currentFileName, ' ...']);
        movefile(currentFileName, [modelList(indModel).folder, '\lods']);
                
    end
    
end

%% Move primitives

if ~isempty(primitivesList)
    
    for indPrimitives = 1 : size(primitivesList, 1)

        % check if there is "_lod" in its filename
        currentFileName = [primitivesList(indPrimitives).folder, '\', primitivesList(indPrimitives).name];
        if strcmp(currentFileName(end-15 : end-12), '_lod')

            disp(['moving ', currentFileName, ' ...']);
            movefile(currentFileName, [primitivesList(indPrimitives).folder, '\lods']);

        end

    end
    
end


%% Move visual

for indVisual = 1 : size(visualList, 1)
    
    currentFileName = [visualList(indVisual).folder, '\', visualList(indVisual).name];
    if strcmp(currentFileName(end-11 : end-8), '_lod')
        
        disp(['moving ', currentFileName, ' ...']);
        movefile(currentFileName, [visualList(indVisual).folder, '\lods']);
                
    end
   
end

%% Move anca

for indAnca = 1 : size(ancaList, 1)
    
    currentFileName = [ancaList(indAnca).folder, '\', ancaList(indAnca).name];
    if strcmp(currentFileName(end-9 : end-6), '_lod')
        
        disp(['moving ', currentFileName, ' ...']);
        movefile(currentFileName, [ancaList(indAnca).folder, '\lods']);
                
    end
   
end

%% Finish

fclose all;
toc
disp('Finished')
