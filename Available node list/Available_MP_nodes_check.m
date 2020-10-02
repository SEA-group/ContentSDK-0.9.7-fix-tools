%% Available MP nodes check ver.2020.08.20a by AstreTunes from SEA group
% This script checks available MP nodes in the current game client, and
% save them in a list

% How to use:
% - use wowsunpack.exe to generate a content list: (can take few minutes)
% - - command: 
%           wowsunpack.exe -l -x bin\[build_number]\idx -p ..\..\..\res_packages -I content/gameplay/*/misc/* -I content/gameplay/*/technical/* -X *textures* -X *lod* > content.txt
% - - support page:https://forum.worldofwarships.ru/topic/123043-all-wows-unpack-tool-%D1%80%D0%B0%D1%81%D0%BF%D0%B0%D0%BA%D0%BE%D0%B2%D0%BA%D0%B0-%D1%80%D0%B5%D1%81%D1%83%D1%80%D1%81%D0%BE%D0%B2-%D0%BA%D0%BB%D0%B8%D0%B5%D0%BD%D1%82%D0%B0-%D0%B8%D0%B3%D1%80%D1%8B/
% - copy lcontent.txt to this folder
% - run this script

clc
clear
fclose all;
tic

%% Parameter

gameVersion = '0.9.9.0';

%% Prepare file

contentFileName = ['content_', gameVersion, '.txt'];

if isempty(dir(['./', contentFileName]))
    toc;
    error([contentFileName, ' doesn''t exist']);
end

contentFile = fopen(contentFileName, 'rt');

%% Read file

lineBuffer = 0;
nodesMat = {};
exitCycle = 0;
lineCount = 0;

while exitCycle == 0
    
    lineBuffer = fgetl(contentFile);
    
    if ~isempty(lineBuffer)
        
        if lineBuffer == -1
            
            exitCycle = 1;
            
        elseif length(lineBuffer) > 17
            
            lineSlashes = strfind(lineBuffer, '/');
            lineCount = lineCount + 1;
            nodesMat{lineCount} = lineBuffer((lineSlashes(end) + 1) : (end - 11));
            
        end
        
    end
    
end

save(['content_', gameVersion, '.mat'], 'nodesMat');

%%

disp('Node list saved to content.mat; routine finished.')
fclose all;
toc

