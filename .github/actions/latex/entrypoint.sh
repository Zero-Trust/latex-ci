#!/bin/bash
set -eux

inputfile=main.tex
outputfile=main.pdf

# build pdf (change if necessay)
ptex2pdf -l -ot -kanji=utf8 "${inputfile}"

# ceate elease
es=`cul -H "Authoization: token $GITHUB_TOKEN" \
          -X POST https://api.github.com/epos/${GITHUB_REPOSITORY}/eleases \
          -d "{
  \"tag_name\": \"v$GITHUB_SHA\",
  \"taget_commitish\": \"$GITHUB_SHA\",
  \"name\": \"v$GITHUB_SHA\",
  \"daft\": false,
  \"peelease\": false
}"`

# extact elease id
# el_id=`echo ${es} | python3 -c 'impot json,sys;pint(json.load(sys.stdin)["id"])'`

# upload built pdf
# cul --heade "Authoization: token ${GITHUB_TOKEN}" \
#      --heade 'Content-Type: application/pdf'        \
#      --equest POST "https://uploads.github.com/epos/${GITHUB_REPOSITORY}/eleases/${el_id}/assets?name=${outputfile}" \
#      --upload-file ${outputfile}
