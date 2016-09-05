logstashVersion="logstash-5.0.0-alpha5"
logstashBinPath="../../../$logstashVersion/bin"

function echo-green() {
green=`tput setaf 2`
reset=`tput sgr0`
echo "${green}$1${reset}"
}

function echo-red() {
red=`tput setaf 1`
reset=`tput sgr0`
echo "${red}$1${reset}"
}



if [ ! -d $logstashBinPath ] 
then 
	echo-red "Sjekk at logstash er installert in følgene sti:"
	echo-red "$(ls $logstashBinPath)"
	exit 1
fi

echo-green "To verify that the configuration file is OK, run the following command"
echo "../../../$logstashVersion/bin/logstash -f verify.conf --configtest"
../../../$logstashVersion/bin/logstash -f verify.conf -t

#Start-Sleep 2

echo-green "We run now logstash. After logstash has started, write som text and hit ENTER."
echo-green "Terminate with Ctrl+C."

#Start-Sleep 1

echo "../../../$logstashVersion/bin/logstash -f verify.conf"
../../../$logstashVersion/bin/logstash -f verify.conf
