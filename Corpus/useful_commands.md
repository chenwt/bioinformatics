# Useful commands
After downloading a corpus of publications, it's useful to check the subdirectories. Replace an example keyword `RNAseq` with your own.

**Some of these commands are dangerous to your system. Use at your own risk.**

#### Find how many XML files are downloaded
```
find ./RNAseq -name fulltext.xml | wc -l
```

#### Transform XML files into Scholarly HTML
When needed, you can use `norma` to transform downloaded XML files to Scholarly HTML files.

```
norma --project RNAseq --input fulltext.xml --output scholarly.html --transform nlm2html
```

Again, find how many Scholarly HTML files are made.

```
find ./RNAseq -name scholarly.html | wc -l
```

#### Find subdirectories without XML files
There may be subdirectories without XML files (e.g., not open access). I would like to make a list of these subdirectories and delete them.

```
cd RNAseq
find . -mindepth 1 -maxdepth 1 -type d '!' -exec test -e "{}/fulltext.xml" ';' -print > MissingXML.txt
xargs rm -r < MissingXML.txt
```

#### Delete all json files in subdirectories
This is not necessary for importing XML files into R. But it was sometimes useful.

```
find . -name "eupmc_result.json" -type f -delete
```

#### Scan for a search term
Sometimes, I want to quickly scan for a search term in all files under a current working directory. Below, I use `egrep` to see if any downloaded XML file contains either `myTool1` or `myTool2`; note that I included an extra space in front of those search terms.

```
egrep -H -r -w " myTool1| myTool2" ./ | cut -d: -f1
```

You can also save those file pathes into a plain text file, `egrep_output.txt`.

```
egrep -H -r -w " myTool1| myTool2" ./ | cut -d: -f1 > egrep_output.txt
```