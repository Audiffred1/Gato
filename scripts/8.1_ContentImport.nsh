OS="WindowsNT"
if [[ "${OS}" = "WindowsNT" ]]
then
	UTILS_DIR="$TEMP/Utilities"
else
	UTILS_DIR="/tmp/Utilities"
fi

echo "Verifying existence of '$UTILS_DIR'."

ITERATION=1
while [ $ITERATION -lt 30 ]
do
	if [ ! -d $UTILS_DIR ]
	then
		break;
	fi

	if [ $ITERATION -eq 1 ]
	then
		echo "Waiting for another installer to complete. If another installation doesn't complete in next 30 minutes, this operation will resume..."
	fi

	sleep 60
	ITERATION=$(($ITERATION+1))
done

echo -E "Starting execution..."

mkdir -p "C:\PROGRA~1\BMCSOF~1\BLADEL~1/NSH/br/Content_Installer"
cp -f "//BLTSERVER/C/Program Files/BMC Software/BladeLogic/storage/installer_bundle/windows/files/compliance_content/Content89-SP4-WIN.exe" "C:\PROGRA~1\BMCSOF~1\BLADEL~1/NSH/br/Content_Installer/"
exit_code=`echo $?`
if [ "$exit_code" -ne '0' ]
then
	echo "Error occurred while copying //BLTSERVER/C/Program Files/BMC Software/BladeLogic/storage/installer_bundle/windows/files/compliance_content/Content89-SP4-WIN.exe EXIT_CODE is $exit_code... Exiting"
	exit "$exit_code"
fi
cp -f "//BLTSERVER/C/Program Files/BMC Software/BladeLogic/storage/installer_bundle/windows/files/compliance_content/final_response_file.properties" "C:\PROGRA~1\BMCSOF~1\BLADEL~1/NSH/br/Content_Installer/"
exit_code=`echo $?`
if [ "$exit_code" -ne '0' ]
then
	echo "Error occurred while copying //BLTSERVER/C/Program Files/BMC Software/BladeLogic/storage/installer_bundle/windows/files/compliance_content/final_response_file.properties EXIT_CODE is $exit_code... Exiting"
	exit "$exit_code"
fi
chmod +x "C:\PROGRA~1\BMCSOF~1\BLADEL~1/NSH/br/Content_Installer/Content89-SP4-WIN.exe"
exit_code=`echo $?`
if [ "$exit_code" -ne '0' ]
then
	echo "Error occurred while executing chmod +x EXIT_CODE is $exit_code... Exiting"
	exit "$exit_code"
fi
nexec BLTSERVER "C:\PROGRA~1\BMCSOF~1\BLADEL~1/NSH/br/Content_Installer/Content89-SP4-WIN.exe" -i silent -DOPTIONS_FILE="C:\PROGRA~1\BMCSOF~1\BLADEL~1/NSH/br/Content_Installer/final_response_file.properties"
exit_code=`echo $?`
if [ "$exit_code" -ne '0' ]
then
	echo "Error occurred while executing "nexec" EXIT_CODE is $exit_code... Exiting"
	exit "$exit_code"
fi
rm -rf "C:\PROGRA~1\BMCSOF~1\BLADEL~1/NSH/br/Content_Installer"
