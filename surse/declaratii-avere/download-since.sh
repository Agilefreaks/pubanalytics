#!/bin/bash

get_initial_page() {
	2>/dev/null curl 'http://declaratii.integritate.eu/search.html' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/115.0' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8' -H 'Accept-Language: en-US,en;q=0.5' -H 'Accept-Encoding: gzip, deflate' -H 'Referer: http://declaratii.integritate.eu/statistics.html' -H 'Connection: keep-alive' -H 'Upgrade-Insecure-Requests: 1'
}

get_jsession_id() {
	grep -o 'jsessionid=[^"]*' | awk -F '=' '{print $2; exit}'
}

get_ice_window() {
	grep -o '<[^>]*name="ice.window"[^>]*'|grep -o 'value="[^"]*'| awk -F '"' '{print $2; exit}'
}

get_ice_view() {
	grep -o '<[^>]*name="ice.view"[^>]*'|grep -o 'value="[^"]*'| awk -F '"' '{print $2; exit}'|sed 's/:/%3A/'
}

get_view_state() {
	grep -o '<[^>]*name="javax.faces.ViewState"[^>]*'|grep -o 'value="[^"]*'| awk -F '"' '{print $2; exit}'|sed 's/:/%3A/'
}

click_cautare_avansata() {
	local jsessionid="$1"
	local window="$2"
	local view="$3"
	local view_state="$4"

	2>/dev/null curl "http://declaratii.integritate.eu/search.html;jsessionid=$jsessionid"\
		-X POST\
		-H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/115.0'\
		-H 'Accept: */*'\
		-H 'Accept-Language: en-US,en;q=0.5'\
		-H 'Accept-Encoding: gzip, deflate'\
		-H 'Faces-Request: partial/ajax'\
		-H 'Content-type: application/x-www-form-urlencoded;charset=UTF-8'\
		-H 'Origin: http://declaratii.integritate.eu'\
		-H 'Connection: keep-alive'\
		-H 'Referer: http://declaratii.integritate.eu/search.html'\
		-H "Cookie: JSESSIONID=$jsessionid; _ga=GA1.2.1108484763.1713624375; _gid=GA1.2.2066264236.1713624375; _gat=1"\
		--data-raw "form=form&ice.window=$window&ice.view=$view&form%3AsearchKey_input=&form%3AsearchField_input=numePrenume&javax.faces.ViewState=$view_state&javax.faces.ClientWindow=$window&form%3AshowAdvancedSearch=form%3AshowAdvancedSearch&javax.faces.source=form&javax.faces.partial.execute=%40all&javax.faces.partial.render=%40all&ice.window=$window&ice.view=$view&ice.focus=&ice.event.target=form&ice.event.captured=form&ice.event.type=onsubmit&ice.submit.type=ice.s&ice.submit.serialization=form&javax.faces.partial.ajax=true"
}

change_judet() {
	local jsessionid="$1"
	local window="$2"
	local view="$3"
	local view_state="$4"
	local start_date="$5"
	local stop_date="$6"
	local judet="$7"
	local doctype="$8"

	2>/dev/null curl "http://declaratii.integritate.eu/search.html"\
		-X POST\
		-H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/115.0'\
		-H 'Accept: */*'\
		-H 'Accept-Language: en-US,en;q=0.5'\
		-H 'Accept-Encoding: gzip, deflate'\
		-H 'Faces-Request: partial/ajax'\
		-H 'Content-type: application/x-www-form-urlencoded;charset=UTF-8'\
		-H 'Origin: http://declaratii.integritate.eu'\
		-H 'Connection: keep-alive'\
		-H 'Referer: http://declaratii.integritate.eu/search.html'\
		-H "Cookie: JSESSIONID=$jsessionid; _ga=GA1.2.1108484763.1713624375; _gid=GA1.2.2066264236.1713624375; _gat=1"\
		--data-raw "form=form&ice.window=$window&ice.view=$view&form%3ANumePrenume_input=&form%3AautoComplete_input=&form%3AFnc_input=&form%3AstartDate_input=$start_date&form%3AendDate_input=$stop_date&form%3AJudet_input=$judet&form%3ALocalitate_input=-1&form%3ATip_input=$doctype&advancedAction=&javax.faces.ViewState=$view_state&javax.faces.source=form%3AJudet&javax.faces.partial.execute=form%3AJudet&javax.faces.partial.render=%40all&ice.window=$window&ice.view=$view&ice.focus=form%3AJudet_input&ice.event.target=form%3AJudet_input&ice.event.captured=form%3AJudet&ice.event.type=onchange&javax.faces.behavior.event=valueChange&javax.faces.partial.event=change&javax.faces.partial.ajax=true"
}

change_doctype() {
	local jsessionid="$1"
	local window="$2"
	local view="$3"
	local view_state="$4"
	local start_date="$5"
	local stop_date="$6"
	local doctype="$7"

	2>/dev/null curl "http://declaratii.integritate.eu/search.html"\
		-X POST\
		-H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/115.0'\
		-H 'Accept: */*'\
		-H 'Accept-Language: en-US,en;q=0.5'\
		-H 'Accept-Encoding: gzip, deflate'\
		-H 'Faces-Request: partial/ajax'\
		-H 'Content-type: application/x-www-form-urlencoded;charset=UTF-8'\
		-H 'Origin: http://declaratii.integritate.eu'\
		-H 'Connection: keep-alive'\
		-H 'Referer: http://declaratii.integritate.eu/search.html'\
		-H "Cookie: JSESSIONID=$jsessionid; _ga=GA1.2.1108484763.1713624375; _gid=GA1.2.2066264236.1713624375; _gat=1"\
		--data-raw "form=form&ice.window=$window&ice.view=$view&form%3ANumePrenume_input=&form%3AautoComplete_input=&form%3AFnc_input=&form%3AstartDate_input=$start_date&form%3AendDate_input=$stop_date&form%3AJudet_input=-1&form%3ALocalitate_input=-1&form%3ATip_input=$doctype&advancedAction=&form%3AtypeIn=csv&javax.faces.ViewState=$view_state&javax.faces.ClientWindow=$window&javax.faces.source=form%3ATip&javax.faces.partial.execute=form%3ATip&javax.faces.partial.render=%40all&ice.window=$window&ice.view=$view&ice.focus=form%3ATip_input&ice.event.target=form%3ATip_input&ice.event.captured=form%3ATip&ice.event.type=onchange&javax.faces.behavior.event=valueChange&javax.faces.partial.event=change&javax.faces.partial.ajax=true"
}

cautare_avansata() {
	local jsessionid="$1"
	local window="$2"
	local view="$3"
	local view_state="$4"
	local start_date="$5" #04.01.2023
	local stop_date="$6"
	local judet="$7"
	local doctype="$8"

	local prefix="cautare $start $end $judet $doctype:"

	# change_doctype "$jsessionid" "$window" "$view" "$view_state" "$start_date" "$stop_date" "$doctype"
	# [ "$judet" != "-1" ] &&\
	# 	change_judet "$jsessionid" "$window" "$view" "$view_state" "$start_date" "$stop_date" "$judet" "$doctype"

	local results="$(2>/dev/null curl 'http://declaratii.integritate.eu/search.html'\
		-X POST\
		-H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/115.0'\
		-H 'Accept: */*'\
		-H 'Accept-Language: en-US,en;q=0.5'\
		-H 'Accept-Encoding: gzip, deflate'\
		-H 'Faces-Request: partial/ajax'\
		-H 'Content-type: application/x-www-form-urlencoded;charset=UTF-8'\
		-H 'Origin: http://declaratii.integritate.eu'\
		-H 'Referer: http://declaratii.integritate.eu/search.html'\
		-H "Cookie: JSESSIONID=$jsessionid; _ga=GA1.2.1108484763.1713624375; _gid=GA1.2.2066264236.1713624375"\
		--data-raw "form=form&ice.window=$window&ice.view=$view&form%3ANumePrenume_input=&form%3AautoComplete_input=&form%3AFnc_input=&form%3AstartDate_input=$start_date&form%3AendDate_input=$stop_date&form%3AJudet_input=$judet&form%3ALocalitate_input=-1&form%3ATip_input=$doctype&advancedAction=&javax.faces.ViewState=$view_state&javax.faces.source=form%3AsubmitButtonAS&javax.faces.partial.execute=%40all&javax.faces.partial.render=%40all&ice.window=$window&ice.view=$view&ice.focus=form%3AsubmitButtonAS&form%3AsubmitButtonAS=caut%C4%83%3E&ice.event.target=form%3AsubmitButtonAS&ice.event.captured=form%3AsubmitButtonAS&ice.event.type=onclick&ice.event.alt=false&ice.event.ctrl=false&ice.event.shift=false&ice.event.meta=false&ice.event.x=420&ice.event.y=964&ice.event.left=true&ice.event.right=false&javax.faces.behavior.event=click&javax.faces.partial.event=click&javax.faces.partial.ajax=true")"

	if grep "ntoarce mai mult de 10 000 de rezultate" <<< "$results"; then
		echo "$prefix too many results" >&2
		[ "$judet" == "-1" ] && return 35
		return 36
	fi

	if grep '"validationFailed":true' <<< "$results"; then
		echo "$prefix validation failed" >&2
		return
	fi

	if grep 'Nu s-au găsit rezultate' <<< "$results"; then
		echo "$prefix 0 rezultate" >&2
		return
	fi

	echo "$results"
	# echo "results='$results'" >&2

	local num="$(echo "$results" | get_results_num)"
	local pages="$(echo "$num / 25" | bc)"
	local rest="$(echo "$num % 25" | bc)"
	[ "$rest" -gt 0 ] && pages=$(($pages + 1))
	echo "$prefix num=$num pages=$pages rest=$rest" >&2
	for page in $(seq 2 $pages); do
		echo "$prefix getting page $page" >&2
		2>/dev/null curl --trace log4$page 'http://declaratii.integritate.eu/search.html'\
			-X POST\
			-H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/115.0'\
			-H 'Accept: */*'\
			-H 'Accept-Language: en-US,en;q=0.5'\
			-H 'Accept-Encoding: gzip, deflate'\
			-H 'Faces-Request: partial/ajax'\
			-H 'Content-type: application/x-www-form-urlencoded;charset=UTF-8'\
			-H 'Origin: http://declaratii.integritate.eu'\
			-H 'Referer: http://declaratii.integritate.eu/search.html'\
			-H "Cookie: JSESSIONID=$jsessionid; _ga=GA1.2.1378349856.1713869582; _gid=GA1.2.1117928.1713869582; _gat=1"\
			--data-raw "form=form&ice.window=$window&ice.view=$view&form%3ANumePrenume_input=&form%3AautoComplete_input=&form%3AFnc_input=&form%3AstartDate_input=$start_date&form%3AendDate_input=$stop_date&form%3AJudet_input=$judet&form%3ALocalitate_input=-1&form%3ATip_input=$doctype&advancedAction=&form%3AtypeIn=csv&javax.faces.ViewState=$view_state&javax.faces.source=form%3AresultsTable&javax.faces.partial.execute=form%3AresultsTable&javax.faces.partial.render=form%3AresultsTable&ice.window=$window&ice.view=$view&ice.focus=form%3AresultsTable_paginatorbottom_current_page&ice.event.target=&ice.event.captured=form%3AresultsTable&ice.event.type=onclick&ice.event.alt=false&ice.event.ctrl=false&ice.event.shift=false&ice.event.meta=false&ice.event.x=432&ice.event.y=114&ice.event.left=true&ice.event.right=false&form%3AresultsTable=form%3AresultsTable&form%3AresultsTable_paging=true&form%3AresultsTable_rows=25&form%3AresultsTable_page=$page&javax.faces.partial.ajax=true"
	done
}

get_results_num() {
	sed -n  '/Rezultatele căutării:/,/declarații/p' | grep -o '>[0-9][0-9]*<' | sed -e 's/>//' -e 's/<//'
}

get_urls() {
	grep -o 'a href="/DownloadServlet[^"]*'
}

get_file_name() {
	grep -o "fileName=[^&]*"| awk -F '=' '{print $2}'
}

get_unique_id() {
	grep -o "uniqueIdentifier=[^&]*"| awk -F '=' '{print $2}'
}

download_file() {
	local rezultat="$1"
	local fname="$(echo "$rezultat"|get_file_name)"
	local unique_id="$(echo "$rezultat"|get_unique_id)"
	echo "downloading file: $fname $unique_id"
	2>/dev/null curl "http://declaratii.integritate.eu/DownloadServlet?fileName=$fname&uniqueIdentifier=$unique_id"\
		--output pdfs/$fname\
		-H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/115.0' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8' -H 'Accept-Language: en-US,en;q=0.5' -H 'Accept-Encoding: gzip, deflate' -H 'Connection: keep-alive' -H 'Referer: http://declaratii.integritate.eu/search.html' -H 'Cookie: _ga=GA1.2.1108484763.1713624375; _gid=GA1.2.2066264236.1713624375; JSESSIONID=F0FE6089A20B08C189E23519EDE5537C' -H 'Upgrade-Insecure-Requests: 1'
}

download_docs() {
	local rezultate_cautare="$1"
	IFS=$'\n'
	for rezultat in $rezultate_cautare; do
		download_file "$rezultat"
	done	
}

date_seq() {
	local start="$1"
	local end="$2"
	local seconds=$(($(date '+%s' -d "$end") - $(date '+%s' -d "$start") ))
	local days="$(echo "$seconds/3600/24" | bc)"
	seq 0 $days
}

toate_judetele() {
	echo "Alba" "Arad" "Arges" "Bacau" "Bihor" "Bistrita-Nasaud" "Botosani" "Brasov" "Braila" "Bucuresti" "Buzau"\
 "Caras%20Severin" "Calarasi" "Cluj" "Constanta" "Covasna" "Dambovita" "Dolj" "Galati" "Giurgiu" "Gorj" "Harghita"\
 "Hunedoara" "Ialomita" "Iasi" "Ilfov" "Maramures" "Mehedinti" "Mures" "Neamt" "Olt" "Prahova" "Satu%20Mare" "Salaj"\
 "Sibiu" "Suceava" "Teleorman" "Timis" "Tulcea" "Vaslui" "Valcea" "Vrancea" "Judet%20completat%20necorespunzator"
}

today(){
	date '+%Y-%m-%d'
}

specific_doctype_judet() {
	local start_date="$1"
	local judet="$2"
	local doctype="$3"
	for i in $(date_seq $start_date $(today)); do
	# for i in $(date_seq $start_date $start_date);do
		data="$(get_initial_page)"
		jsessionid="$(echo "$data"|get_jsession_id)"
		ice_window="$(echo "$data"|get_ice_window)"
		ice_view="$(echo "$data"|get_ice_view)"
		view_state="$(echo "$data"|get_view_state)"
		click_cautare_avansata "$jsessionid" "$ice_window" "$ice_view" "$view_state" >/dev/null 2>/dev/null
		j=$(($i+2))
		start="$(date '+%d.%m.%Y' -d "$start_date +$i days")"
		end="$(date '+%d.%m.%Y' -d "$start_date +$j days")"
		rezultate_cautare="$(cautare_avansata "$jsessionid" "$ice_window" "$ice_view" "$view_state" $start $end "$judet" "$doctype")"
		if [ "$?" -eq 35 ]; then
			for jud in $(toate_judetele); do
				rezultate_cautare="$(cautare_avansata "$jsessionid" "$ice_window" "$ice_view" "$view_state" $start $end "$jud" "$doctype")"
				rezultate_cautare="$(echo "$rezultate_cautare" | get_urls)"
				download_docs "$rezultate_cautare"
			done
		else
			rezultate_cautare="$(echo "$rezultate_cautare" | get_urls)"
			download_docs "$rezultate_cautare"
		fi
	done
}

specific_doctype() {
	local start_date="$1"
	local doctype="$2"

	for judet in $(toate_judetele); do
		specific_doctype_judet "$start_date" "$judet" "$doctype"
	done
}

start_date="2023-01-01"
for doctype in "Declaratie%20de%20avere" "Declaratie%20de%20interes"; do
	specific_doctype "$start_date" "$doctype" &
done

wait
