#!/bin/bash

echo "checking if war file is available or not in the target directory.........................!"

file="target/petclinic.war"
if [ ! -f "$file" ]
then
    echo "$0: File '${file}' not found."
	exit 1
else
	echo "$file found....................!"
fi


#versioning the war file with build number

echo "versioning the artifacts..................!"
cp target/petclinic.war .
mv petclinic.war petclinic-${BUILD_NUMBER}.war

#upload genareted war file to nexus repository
echo "uploading versioned artifacts to nexus repository...............!"

curl -v -u admin:admin123 --upload-file petclinic-${BUILD_NUMBER}.war http://192.168.33.10:8081/repository/k-mart-artifacts/

if [ $? == 0 ]
then
    echo "artifacts sucessfully uploaded into the nexus repository................!"
else
	echo "upload artifacts failed to nexus please check the logs...................!"
fi
