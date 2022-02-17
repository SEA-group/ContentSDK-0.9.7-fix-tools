%% Available MP nodes check ver.2020.08.20a by AstreTunes from SEA group
% This script checks available MP nodes in the current game client, and save them in a list IN THE FORMAT USED BY ShadowyBandit's scripts

% How to use:
% - use wowsunpack.exe to generate a content list: (can take few minutes)
% - - command: 
%           wowsunpack.exe -l -x bin\5191542\idx -p ..\..\..\res_packages -I content/gameplay/*/misc/* -I content/gameplay/*/technical/* -X *textures* -X *lod* > content_0.11.1.0.txt
% - - support page:https://forum.worldofwarships.ru/topic/123043-all-wows-unpack-tool-%D1%80%D0%B0%D1%81%D0%BF%D0%B0%D0%BA%D0%BE%D0%B2%D0%BA%D0%B0-%D1%80%D0%B5%D1%81%D1%83%D1%80%D1%81%D0%BE%D0%B2-%D0%BA%D0%BB%D0%B8%D0%B5%D0%BD%D1%82%D0%B0-%D0%B8%D0%B3%D1%80%D1%8B/
% - copy lcontent.txt to this folder
% - run this script

% clc
clear
fclose all;
tic

%% Parameter

gameVersion = '0.11.1.0';

%% Prepare file

contentFileName = ['content_', gameVersion, '.txt'];

if isempty(dir(['./', contentFileName]))
    toc;
    error([contentFileName, ' doesn''t exist']);
end

contentFile = fopen(contentFileName, 'rt');
listFile = fopen('notObsolete.txt','w');

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
            currentNode = lineBuffer((lineSlashes(end-1) + 1) : (lineSlashes(end)-1));
            fprintf(listFile, '%s\r\n', currentNode);
            
        end
        
    end
    
end

%%

disp('Node list saved to notObsolete.txt; routine finished.');
fclose all;
toc

