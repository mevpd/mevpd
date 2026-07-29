#!/bin/bash
# Wednesday, 29 July, 2026 07:05:27 AM UTC
# AUTHOR: mevpd
# DESC  : script to generate a table containing information about the certificates without having to code the HTML manually

script_path=$(dirname "$(realpath "$0")")

main(){
    echo -n > "$script_path/files/.tmp"
    tail -n +2 "$script_path/files/certs.csv" | while read -r line;do
        date=$(echo "$line" | cut -d "|" -f1)
        logo=$(echo "$line" | cut -d "|" -f2)
        tech=$(echo "$line" | cut -d "|" -f3)
        link=$(echo "$line" | cut -d "|" -f4)
        link_txt=$(echo "$line" | cut -d "|" -f5)
        cert=$(echo "$line" | cut -d "|" -f6)
        echo -n '<tr>
            <td>'"$date"'</td>
            <td><img src="'"$logo"'" alt="'"$logo"'" width="40px" height="40px"></td>
            <td>'"$tech"'</td>
            <td><a href="'"$link"'">'"$link_txt"'</a></td>
            <td> <img src="'"$cert"'" alt="'"$cert"'" width="100"/> </td>
        </tr>' >> "$script_path/files/.tmp"
    done
    grep -B 1000 REPLACE_THIS_WITH_THE_TABLE_DATA "$script_path/files/template_readme.md" | head -n -1
    cat "$script_path/files/.tmp"
    grep -A 1000 REPLACE_THIS_WITH_THE_TABLE_DATA "$script_path/files/template_readme.md" | tail -n +2
}

main "$@" | tee test.md