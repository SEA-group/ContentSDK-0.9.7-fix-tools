%% Available MP nodes check ver.2020.09.21a by AstreTunes from SEA group
% This script checks MP nodes in all .visual files and removes the invalid ones

% !!!!!! Matlab version r2016b or later is required (mandatory) !!!!!!

% How to use:
% - put this script and content_0.10.5.0.mat in res_mods/PnFMods/
% - run this script

clc
clear
fclose all;
tic

%% Parameter

gameVersion = '0.10.7.0';

%% Load available nodes list

contentFileName = ['content_', gameVersion, '.mat'];

if isempty(dir(['./', contentFileName]))
    toc;
    error([contentFileName, ' doesn''t exist']);
end

load(contentFileName);

%% Prepare log file

logFile=fopen('Obsolete_node_remover.log', 'w');

%% Generate file list

visualList = dir('**/*.visual');

if isempty(visualList)
    
    toc;
    error('No .visual file found.');
    
end

%% Check 

for indVisual = 1 : size(visualList, 1)
    
    currentFileName = [visualList(indVisual).folder, '\', visualList(indVisual).name];
    
    % back up original visual file
    copyfile(currentFileName, [currentFileName, 'bak']);
    disp(['checking ', currentFileName, ' ...']);
    
    currentFileBackup = fopen([currentFileName, 'bak'], 'rt');
    currentFile = fopen(currentFileName, 'w');
    lineBuffer = 0;
    exitCycle = 0;
    isInNode = 0;
    
    while exitCycle == 0
    
        lineBuffer = fgetl(currentFileBackup);
%         lineSpaceless = lineBuffer;
%         lineSpaceless(isspace(lineSpaceless))=[];
        
        if isInNode
            
            if contains(lineBuffer, 'MP_') % if the current node is a MP node
                
                % check the identifier
                if strcmp(lineBuffer(strfind(lineBuffer, 'MP_')+4), 'M')    % misc node, xMnnn
                    
                    nodeIdentifier = lineBuffer((strfind(lineBuffer, 'MP_') + 3) : (strfind(lineBuffer, 'MP_') + 7));
                    
                elseif strcmp(lineBuffer(strfind(lineBuffer, 'MP_')+4), 'T')    % technical node, xTxnnnn
                    
                    nodeIdentifier = lineBuffer((strfind(lineBuffer, 'MP_') + 3) : (strfind(lineBuffer, 'MP_') + 9));
                    
                else
                    
                    nodeIdentifier = 'other';
                    
                end
                
                if max(contains(nodesMat, nodeIdentifier)) % node is available
                    
                    % write lineCache and the current line and the following 7 lines
                    fprintf(currentFile, '%s\r\n', lineCache);
                    fprintf(currentFile, '%s\r\n', lineBuffer);
                    lineBuffer = fgetl(currentFileBackup);  % to <transform>
                    fprintf(currentFile, '%s\r\n', lineBuffer);
                    lineBuffer = fgetl(currentFileBackup);  % to <row0>
                    fprintf(currentFile, '%s\r\n', lineBuffer);
                    lineBuffer = fgetl(currentFileBackup);  % to <row1>
                    fprintf(currentFile, '%s\r\n', lineBuffer);
                    lineBuffer = fgetl(currentFileBackup);  % to <row2>
                    fprintf(currentFile, '%s\r\n', lineBuffer);
                    lineBuffer = fgetl(currentFileBackup);  % to <row3>
                    fprintf(currentFile, '%s\r\n', lineBuffer);
                    lineBuffer = fgetl(currentFileBackup);  % to </transform>
                    fprintf(currentFile, '%s\r\n', lineBuffer);
                    lineBuffer = fgetl(currentFileBackup);  % to </node>
                    fprintf(currentFile, '%s\r\n', lineBuffer);
                    
                else   % node is obsolete
                    
                    % skip the current node
                    fgetl(currentFileBackup);  % to <transform>
                    fgetl(currentFileBackup);  % to <row0>
                    fgetl(currentFileBackup);  % to <row1>
                    fgetl(currentFileBackup);  % to <row2>
                    fgetl(currentFileBackup);  % to <row3>
                    fgetl(currentFileBackup);  % to </transform>
                    fgetl(currentFileBackup);  % to </node>
                    
                    % write log
                    disp(['node ', nodeIdentifier, ' removed;']);
                    fprintf(logFile, 'node %s is removed from %s \r\n', nodeIdentifier, currentFileName);
                    
                end
                
            elseif contains(lineBuffer, 'SP_')  % if the current node is a SP node
                
                % skip the current node
                fgetl(currentFileBackup);  % to <transform>
                fgetl(currentFileBackup);  % to <row0>
                fgetl(currentFileBackup);  % to <row1>
                fgetl(currentFileBackup);  % to <row2>
                fgetl(currentFileBackup);  % to <row3>
                fgetl(currentFileBackup);  % to </transform>
                fgetl(currentFileBackup);  % to </node>
                
            else   % if it's neither SP nor MP node
            
                % write lineCache and the current line
                fprintf(currentFile, '%s\r\n', lineCache);
                fprintf(currentFile, '%s\r\n', lineBuffer);
                
            end
            
            isInNode = 0;
            
        elseif ~isempty(lineBuffer)
            
            if lineBuffer==-1
                
                exitCycle=1;
                
            elseif contains(lineBuffer, '<node>')   % if the current line starts a new node
            
                isInNode = 1;
                lineCache = lineBuffer;
                
            else
            
                fprintf(currentFile, '%s\r\n', lineBuffer);
            
            end
            
        end        
    
    end
    
    fclose(currentFileBackup);
    fclose(currentFile);
    
end

%%

disp('log written to Obsolete_node_remover.log; routine finished.')
fclose all;
toc

