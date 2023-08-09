#!/bin/bash

# ---- BEGIN OF CONFIG SECTION ---- #

# Target Version
minecraftVersion="1.20.1"
paperBuildNumber=`curl -s -X 'GET' -H 'accept: application/json' "https://api.papermc.io/v2/projects/paper/versions/${minecraftVersion}/builds" | jq '.builds[-1].build'`
purpurBuildNumber=`curl -s -X 'GET' -H 'accept: application/json' "https://api.purpurmc.org/v2/purpur/${minecraftVersion}" | jq '.builds.all[-1] | tonumber'`
paperDownloadUrl="https://api.papermc.io/v2/projects/paper/versions/${minecraftVersion}/builds/${paperBuildNumber}/downloads/paper-${minecraftVersion}-${buildNumber}.jar"
purpurDownloadUrl="https://api.purpurmc.org/v2/purpur/${minecraftVersion}/${purpurBuildNumber}/download"

# Mandatory variables
downloadUrl=${purpurDownloadUrl}
allocatedMemorySize="4G"

# Optional variables
additionalJvmArguments=""
additonalScriptPath=""

# ----- END OF CONFIG SECTION ----- #

##### !! DO NOT EDIT BELOW !! #####

echo 'Executing entrypoint...'

# Check necessary variables are defined
if [ -z ${downloadUrl} ]; then
    echo 'You must write script as downloadUrl variable to download server jar file at config section in entrypoint.sh' >&2
    exit 1
elif [ -z ${allocatedMemorySize} ]; then
    echo 'You must specify allocated memory size for server as allocatedMemorySize variable at config section in entrypoint.sh' >&2
    exit 1
fi

# Make sure we are in correct workdir
cd /server

# Download server jar artifact
echo 'Downloading server jar file...'
curl -fsSL -o /server/server.jar ${downloadUrl}

# Run additonal script if defined
if [ ! -z ${additonalScriptPath} ]; then
    echo 'Executing additonal script...'
    bash -c ${additionalScriptPath}
fi

# Run server
echo 'Booting server...'
java -Xmx${allocatedMemorySize} -Xms${allocatedMemorySize} ${additionalJvmArguments} -jar server.jar nogui
